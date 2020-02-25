-- made by Uziskull

--==== constants ====--

CONST_GRAVITY = 0.10
CONST_REALSPEED = 0.50
CONST_HIT_OBSTACLE_FALLBACK = -0.10
CONST_BOUNCE_MAX = 2
CONST_BOUNCE_FALLBACK = -0.33
CONST_VSPEED_EPSILON = 0.05

--==== particles ====--

projParticles = {
    blur = function(projAngle)
        projAngle = projAngle or 0
        local particle = ParticleType.find("RainSplash", "vanilla")
        particle:angle(projAngle, projAngle, 0, 0, true)
        particle:scale(1.5, 1)
        return particle
    end
}

--==== buffs ====--

buffs = {
    burning = {
        buff = Buff.new("Burning"),
        damage = 0.05,
        damageBosses = 0.015
    },
    poison = {
        buff = Buff.new("Poison"),
        damage = 0.075,
        damageBosses = 0.05
    }
}
buffs.burning.buff.sprite = emptySprite
buffs.burning.buff:addCallback("start", function(actor)
    actorData = actor:getData()
    actorData.burningDamage = actor:get("maxhp") * buffs.burning.damage
    -- local actorObject = actor:getObject()
    -- for _, boss in ipairs(ParentObject.find("bosses", "vanilla")) do
        -- if actorObject == boss then
            -- actorData.burningDamage = actor:get("maxhp") * buffs.burning.damageBosses
            -- break
        -- end
    -- end
    -- TODO: find a proper way of seeing if its a boss lmfao
    if actor:get("show_boss_health") == 1 then
        actorData.burningDamage = actor:get("maxhp") * buffs.burning.damageBosses
    end
end)
buffs.burning.buff:addCallback("step", function(actor, timeLeft)
    if actor:isValid() and timeLeft % 30 == 0 then
        actorData = actor:getData()
        local fireBullet = misc.fireBullet(
            actor.x - 5, actor.y,
            0, 10,
            actorData.burningDamage,
            actor:get("team") == "player" and "enemy" or "player",
            Sprite.find("EfFirey", "vanilla"))
        fireBullet:set("specific_target", actor.id)
    end
end)

buffs.poison.buff.sprite = emptySprite
buffs.poison.buff:addCallback("start", function(actor)
    actorData = actor:getData()
    actorData.poisonDamage = actor:get("maxhp") * buffs.poison.damage
    if actor:get("show_boss_health") == 1 then
        actorData.poisonDamage = actor:get("maxhp") * buffs.poison.damageBosses
    end
end)
buffs.poison.buff:addCallback("step", function(actor, timeLeft)
    if actor:isValid() and timeLeft % 30 == 0 then
        actorData = actor:getData()
        local fireBullet = misc.fireBullet(
            actor.x - 5, actor.y,
            0, 10,
            actorData.poisonDamage,
            actor:get("team") == "player" and "enemy" or "player",
            Sprite.find("EfPoison", "vanilla"))
        fireBullet:set("specific_target", actor.id)
    end
end)

--==== functions ====--

function getRoRifiedDamage(noitaDamage)
    local minDmg, maxDmg = 0, 0
    local minPerc, maxPerc = 0, 0
    if noitaDamage <= 50 then
        -- small damage, goes from 100% to 300%
        minDmg, maxDmg = 3, 50
        minPerc, maxPerc = 1.00, 3.00
    elseif noitaDamage <= 200 then -- we don't consider any damage over 150 as a limit, so that it isn't too powerful
        -- big damage, goes from 300% to 450%
        minDmg, maxDmg = 50, 150
        minPerc, maxPerc = 3.00, 4.50
    else
        -- explosive damage, goes from ~~450% to 900%~~ 500% to 1200%
        minDmg, maxDmg = 250, 1000
        minPerc, maxPerc = 5.00, 12.00
    end
    return roundNumber(((maxPerc - minPerc)/(maxDmg - minDmg)) * (noitaDamage - minDmg) + minPerc, 2)
end

function getRoRifiedSpeed(noitaSpeed)
    return noitaSpeed / 20
end

local function projGetProperty(projData, property)
    if projData.properties[property] ~= nil then
        return projData.properties[property]
    else
        return projData.spell.properties[property]
    end
end

function spellIconToProj(icon, scale)
    local spriteName = icon:getName() .. "_proj"
    local sprite = Sprite.find(spriteName, modloader.getActiveNamespace())
    if sprite == nil then
        local surf = Surface.new(icon.width * scale, icon.height * scale)
        graphics.setTarget(surf)
        graphics.drawImage{
            icon, 0, 0,
            scale = scale
        }
        local dynSprite = surf:createSprite(math.floor(surf.height / 2), math.floor(surf.height / 2))
        sprite = dynSprite:finalize(spriteName)
        graphics.resetTarget()
        surf:free()
    end
    return sprite
end

commonFuncs = {
    projEnemyHit = function(proj, enemy)
        projData = proj:getData()
        local angle = math.deg(math.atan2(-projData.vector[2], projData.vector[1]))
        local player = projData.player
        local pierce = projGetProperty(projData, "pierce") ~= nil
        local damager = player:fireBullet(
            enemy.x - 10, enemy.y,
            (angle >= 90 and angle < 270) and 180 or 0,
            20,
            projData.spell.damage,
            projData.spell.sprites.hit,
            pierce and DAMAGER_BULLET_PIERCE or 0
        )
        damager:set("specific_target", enemy.id)
        
        local damagerData = damager:getData()
        if projData.spell.callback ~= nil and projData.spell.callback.destroy ~= nil then
            damagerData.spellFunc = projData.spell.callback.destroy
        end
        if projData.modifier ~= nil and projData.modifier.destroy ~= nil then
            damagerData.modFunc = projData.modifier.destroy
        end
        
        if not pierce then
            proj:destroy()
        end
        return
    end,
    projEnemyExplode = function(proj, enemy)
        projData = proj:getData()
        local player = projData.player
        local damager = player:fireExplosion(
            enemy.x, enemy.y,
            projData.spell.explosion[1] / 19, projData.spell.explosion[2] / 4,
            projData.spell.damage,
            projData.spell.sprites.hit
        )
        
        local damagerData = damager:getData()
        if projData.spell.callback ~= nil and projData.spell.callback.destroy ~= nil then
            damagerData.spellFunc = projData.spell.callback.destroy
        end
        if projData.modifier ~= nil and projData.modifier.destroy ~= nil then
            damagerData.modFunc = projData.modifier.destroy
        end
        
        proj:destroy()
        
        return
    end,
}

spellType = {
    PROJECTILE = 1,
    MODIFIER = 2
}

require("src/spells_list")

--==== projectile ====--

projObj:addCallback("create", function(self)
    projData = self:getData()
    projData.origin = {self.x, self.y}
    projData.vector = {0, 0}
    projData.currentVector = {0, 0}
    projData.life = 0
    projData.lastTouchedGround = 0
    projData.spell = nil
    projData.modifier = {}
    projData.player = nil
    
    -- possible modifications
    projData.properties = {}
end)

projObj:addCallback("draw", function(self)
    projData = self:getData()
    local spell = projData.spell
    if spell.callback.draw ~= nil then
        spell.callback.draw(self)
    end
end)

projObj:addCallback("step", function(self)
    local destroyProj = false
    
    --==== check if its outside the stage ====--
    local stageW, stageH = Stage.getDimensions()
    if self.x < 0 or self.x > stageW or self.y < 0 or self.y > stageH then
        self:destroy()
        return
    end

    projData = self:getData()
    local spell = projData.spell
    local mods = projData.modifier
    
    --==== update current vector ====--
    projData.currentVector = {projData.vector[1] * CONST_REALSPEED * spell.speed, projData.vector[2] * CONST_REALSPEED * spell.speed}
    
    --==== add gravity ====--
    projData.currentVector = {
        projData.currentVector[1],
        projData.currentVector[2] == 0 and 0 or (projData.currentVector[2] + spell.weight * CONST_GRAVITY * (projData.life - projData.lastTouchedGround))
    }
    
    --==== increment projectile life ====--
    projData.life = projData.life + 1

    -- get current angle
    local beforeAngle = self.angle

    --==== do spell step ====--
    if spell.callback.step ~= nil then
        spell.callback.step(self)
    end
    if not self:isValid() then
        return
    end
    
    --==== apply modifiers ====--
    if mods ~= nil and mods.step ~= nil then
        mods.step(self)
    end
    if not self:isValid() then
        return
    end
    
    -- save final vector to a variable for easy access
    local endVector = projData.currentVector
    
    -- compute normalized vector, used for getting the angle and doing collisions
    local normVec = normalizeVector(endVector)
    
    --==== update proj angle ====--
    -- if angle changed, don't change angle :bigThink:
    if self.angle == beforeAngle then
        self.angle = math.deg(math.atan2(-normVec[2], normVec[1]))
    end
    
    --==== check for hit enemies ====--
    local newX, newY = self.x + endVector[1], self.y + endVector[2]
    -- TODO: this is highly inefficient and probably will lag like hell
    local hitEnemy = ParentObject.find(projData.player:get("team") == "player" and "enemies" or "actors", "vanilla"):findLine(self.x, self.y, newX, newY)
    while hitEnemy ~= nil do
        if spell.callback.hitEnemy == nil then
            -- just cut the x component kek
            projData.vector[1] = projData.vector[1] * CONST_HIT_OBSTACLE_FALLBACK
            break
        else
            spell.callback.hitEnemy(self, hitEnemy)
            if not self:isValid() then
                return
            end
            hitEnemy = ParentObject.find(projData.player:get("team") == "player" and "enemies" or "actors", "vanilla"):findLine(self.x, self.y, newX, newY)
        end
    end
    
    -- this makes no sense but it stops a random crash from happening so idk man just roll with it
    if newX == self.x and newY == self.y then
        return
    end
    
    --==== check for hit walls ====--
    self.x, self.y = newX, newY
    if self:collidesMap(self.x, self.y) then
        while self:collidesMap(self.x, self.y) do
            self.x, self.y = self.x - normVec[1], self.y - normVec[2]
        end
        
        -- check where the collision was
        local direction = self:collidesMap(self.x + endVector[1], self.y) and 1 or 2
        
        -- if it touched the ground, update last time it touched the ground
        if direction == 2 and endVector[2] >= 0 then
            projData.lastTouchedGround = projData.life
        end
        
        if spell.callback.hitWall == nil then
            local bounceAmount = projGetProperty(projData, "bounce")
            if bounceAmount ~= nil then
                projData.bounce = projData.bounce == nil and 1 or (projData.bounce + 1)
                if projData.bounce <= CONST_BOUNCE_MAX then
                    projData.vector[direction] = projData.vector[direction] * bounceAmount
                else
                    -- TODO: display hit sprite
                    self:destroy()
                    return
                end
            elseif projGetProperty(projData, "solid") ~= nil then
                projData.vector[direction] = (projData.vector[direction] > 0 and projData.vector[direction] < CONST_VSPEED_EPSILON)
                  and 0 or (projData.vector[direction] * CONST_HIT_OBSTACLE_FALLBACK)
            else
                -- TODO: display hit sprite
                self:destroy()
                return
            end
        else
            local hitAngle = endVector[direction] < 0 and (direction == 1 and 180 or 90) or (direction == 1 and 0 or 270)
            spell.callback.hitWall(self, hitAngle)
            if not self:isValid() then
                return
            end
        end
    end
end)

--==== networking ====--

function serializeSpell(spell)
    if type(spell) ~= "table" then
        return 0
    end
    return spell.internalName, spell.type, spell.count ~= nil and spell.count or -1
end

function deserializeSpell(data)
    if #data == 0 then
        return 0
    end
    local spell = data[2] == spellType.PROJECTILE and allSpells[data[1]]() or allModifiers[data[1]]()
    if data[2] == spellType.PROJECTILE then
        spell.count = data[3]
    end
    return spell
end

--==== public functions ====--

function getRandomWeightedSpell()
    -- TODO: define proper weights to every spell to avoid powerful ones being common
    local spellFunc = table.random(allSpells)
    if math.random(3) == 1 then spellFunc = table.random(allModifiers) end
    return spellFunc()
end

function fireSpell(player, wand, spellIndex, modifierFuncs, modifierProperties, origX, origY, fireAngle)
    modifierProperties = modifierProperties or {}
    
    local spells = wand.spells
    local spell = spells[spellIndex]
    if spell == nil or type(spell) ~= "table" or (spell.type == spellType.PROJECTILE and spell.count == 0) then
        return 0, 0, 0, spellIndex + 1
    end
    for i = 1, #wand.firedSpells do
        if wand.firedSpells[i] == spellIndex then
            return 0, 0, 0, spellIndex + 1
        end
    end
    if wand.mana - spell.manaCost < 0 then
        return 0, 0, 0, spellIndex
    end
    local spellsCastDelay, spellsRechargeTime, spellsManaCost, newSpellIndex = nil, nil, nil, nil
    if spell.type == spellType.PROJECTILE or spell.trigger then
        if spell.count ~= -1 then
            spell.count = spell.count - 1
        end
        local proj = projObj:create(origX, origY)
        proj.sprite = spell.sprites.proj.spr
        proj.spriteSpeed = spell.sprites.proj.speed
        projData = proj:getData()
        if modifierFuncs ~= nil and modifierFuncs.init ~= nil then
            fireAngle = modifierFuncs.init(fireAngle)
        end
        -- create vector based on angle, which comes with the bonus of already being normalized
        local trajAngleRad = math.rad(fireAngle + spell.degree)
        proj.angle = -(fireAngle + spell.degree)
        projData.vector = {math.cos(trajAngleRad), math.sin(trajAngleRad)}
        projData.spell = spell
        projData.modifier = modifierFuncs
        projData.player = player
        projData.properties = modifierProperties

        if spell.fireSound ~= nil then
            spell.fireSound:play()
        end

        spellsCastDelay, spellsRechargeTime, spellsManaCost, newSpellIndex = spell.castDelay, spell.rechargeTime, spell.manaCost, 1 + spellIndex
        
        if spell.type == spellType.PROJECTILE then
            return spellsCastDelay, spellsRechargeTime, spellsManaCost, newSpellIndex
        else
            -- TODO: triggers
            -- TODO: maybe fire the spell with an extra do-not-create-damager and use that
            --       but check if weird things are done afterwards
            if newSpellIndex <= #spells and spells[newSpellIndex] ~= nil and type(spells[newSpellIndex]) == "table"
              and (spells[newSpellIndex].type ~= spellType.PROJECTILE or spells[newSpellIndex].count ~= 0) then
                if wand.mana - spellsManaCost - spells[newSpellIndex].manaCost < 0 then
                    return spellsCastDelay, spellsRechargeTime, spellsManaCost, newSpellIndex
                else
                    projData.triggerSpell = spells[newSpellIndex]
                    local newRechargeTime = nil
                    if spells[newSpellIndex].rechargeTime ~= nil and spellsRechargeTime ~= nil then
                        newRechargeTime = spellsRechargeTime + spells[newSpellIndex].rechargeTime
                    end
                    return spellsCastDelay + spells[newSpellIndex].castDelay,
                        newRechargeTime, 
                        spellsManaCost + spells[newSpellIndex].manaCost,
                        newSpellIndex + 1
                end
            else
                return spellsCastDelay, spellsRechargeTime, spellsManaCost, newSpellIndex + 1
            end
        end
    end
    if spell.type == spellType.MODIFIER then
        spellsCastDelay, spellsRechargeTime, spellsManaCost, newSpellIndex = spell.castDelay, 0, spell.manaCost, 1 + spellIndex
        for i = 1, spell.spellsAffected do
        
            modifierFuncs = {}
            for _, callback in ipairs({"init", "step", "destroy"}) do
                if spell.modification[callback] ~= nil then
                    if type(spell.modification[callback]) == "function" then
                        modifierFuncs[callback] = spell.modification[callback]
                    else
                        modifierFuncs[callback] = spell.modification[callback][i]
                    end
                else
                    modifierFuncs[callback] = nil
                end
            end
            
            modifierProperties = {}
            if spell.properties ~= nil then
                modifierProperties = spell.properties
            end
            
            if newSpellIndex <= #spells and type(spells[newSpellIndex]) == "table" then
                if wand.mana - spellsManaCost - spells[newSpellIndex].manaCost < 0 then
                    return spellsCastDelay, spellsRechargeTime, spellsManaCost, newSpellIndex
                end
                local cd, rt, m, s = fireSpell(
                    player,
                    wand,
                    newSpellIndex,
                    modifierFuncs,
                    modifierProperties,
                    origX, origY,
                    fireAngle
                )
                if s == 0 then
                    return spellsCastDelay, spellsRechargeTime, spellsManaCost, newSpellIndex
                end
                if spellsCastDelay == nil or cd == nil then
                    spellsCastDelay = nil
                else
                    spellsCastDelay = spellsCastDelay + cd
                end
                spellsRechargeTime = spellsRechargeTime + rt
                spellsManaCost = spellsManaCost + m
                newSpellIndex = s
            else
                return spellsCastDelay, spellsRechargeTime, spellsManaCost, newSpellIndex
            end
        end
        return spellsCastDelay, spellsRechargeTime, spellsManaCost, newSpellIndex
    end
end

--==== spell object ====--

-- counter for every spell object, used as id generator for online syncing
spellObjectCounter = 0
registercallback("onGameStart", function()
    spellObjectCounter = 0
end, 5000)
function newSpellID()
    spellObjectCounter = spellObjectCounter + 1
    return spellObjectCounter
end

function spawnSpellObject(spell, x, y)
    local spellInst = spellObj:create(x, y)
    spellData = spellInst:getData()
    spellData.spell = spell
    
    return spellInst
end

function getSpellShopSprite(origSprite)
    local shopSpriteName = origSprite:getName() .. "_shop"
    local shopSprite = Sprite.find(shopSpriteName, modloader.getActiveNamespace())
    if shopSprite == nil then
        local surf = Surface.new(15, 15)
        graphics.setTarget(surf)
        graphics.drawImage{
            origSprite,
            0, 0,
            scale = 15 / origSprite.width
        }
        graphics.resetTarget()
        local dynSprite = surf:createSprite(7,14)
        surf:free()
        shopSprite = dynSprite:finalize(shopSpriteName)
    end
    return shopSprite
end

spellObj:addCallback("create", function(self)
    spellData = self:getData()
    spellData.id = newSpellID()
    spellData.spell = nil
    spellData.sprite = nil
    spellData.life = 0
    spellData.grav = 1/10
    spellData.speed = 0
    spellData.shop = -1
end)

spellObj:addCallback("step", function(self)
    spellData = self:getData()
    spellData.life = spellData.life + 1
    
    if spellData.spell ~= nil then
        if spellData.sprite == nil then
            spellData.sprite = getSpellShopSprite(spellData.spell.sprites.icon)
        end
        if self.sprite ~= spellData.sprite then
            self.sprite = spellData.sprite
            self.alpha = 0
        end
    end
    
    if spellData.shop == -1 and spellData.grav ~= 0 then
        spellData.speed = spellData.speed + spellData.grav
        self.y = self.y + spellData.speed
        if self:collidesMap(self.x, self.y) then
            while self:collidesMap(self.x, self.y) do
                self.y = self.y - spellData.grav
            end
            spellData.grav = 0
        end
    end
end)

spellObj:addCallback("draw", function(self)
    spellData = self:getData()
    if spellData.spell ~= nil then
        graphics.drawImage{
            spellData.sprite,
            self.x, self.y + 3 * math.sin(math.rad(spellData.life)),
            
            scale = 1.5
        }
    end
end)

--==== deal with "destroy" callbacks ====--

registercallback("onHit", function(damager, enemy, x, y)
    local player = damager:getParent()
    if player == nil then --or not isa(player, "PlayerInstance") or player:getSurvivor() ~= caster then -- cant have this cause enemies also fire shots
        return
    end
    local damagerData = damager:getData()
    if damagerData.spellFunc == nil and damagerData.modFunc == nil then
        return
    end
    
    if damagerData.spellFunc ~= nil then
        damagerData.spellFunc(enemy, x, y, damager)
    end
    if damagerData.modFunc ~= nil then
        damagerData.modFunc(enemy, x, y, damager)
    end
    
    if damagerData.triggerSpell ~= nil then
        -- TODO: trigger
    end 
    
    damagerData.hitDatFam = true
end)

registercallback("onImpact", function(damager, x, y)
    local player = damager:getParent()
    if player == nil then -- or not isa(player, "PlayerInstance") or player:getSurvivor() ~= caster then -- cant have this cause enemies also fire shots
        return
    end
    local damagerData = damager:getData()
    if damagerData.spellFunc == nil and damagerData.modFunc == nil then
        return
    end
    
    -- skip if already hit an enemy
    if damagerData.hitDatFam ~= nil then
        return
    end
    
    if damagerData.spellFunc ~= nil then
        damagerData.spellFunc(nil, x, y, damager)
    end
    if damagerData.modFunc ~= nil then
        damagerData.modFunc(nil, x, y, damager)
    end
end)