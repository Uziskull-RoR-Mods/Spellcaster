-- made by Uziskull

local totalWandNumber = 12       -- total number of wands
-- limits to divide between small (easy) wands vs normal (medium) wands vs large (hard) wands
local wandDiffLimit = {
    easy = 5,
    medium = 11
}
local wandDims = {
    easy = { width = 7,  height = 3, origX = 0, origY = 1 },
    medium = { width = 11, height = 5, origX = 0, origY = 2 },
    hard = { width = 15, height = 7, origX = 0, origY = 3 },
}

local wandSprites = {
    base = {
        Sprite.load("wands_base1", "spr/wands/base1", 1, wandDims.easy.origX, wandDims.easy.origY),
        Sprite.load("wands_base2", "spr/wands/base2", 1, wandDims.easy.origX, wandDims.easy.origY)
    },
    --shadow = Sprite.load("wand_shadow", "spr/wands/wandShadow", 1, 11, 7)
}
for i = 1, totalWandNumber do
    wandSprites[i] = {}
    local wandConf = "hard"
    if i <= wandDiffLimit.easy then
        wandConf = "easy"
    elseif i <= wandDiffLimit.medium then
        wandConf = "medium"
    end
    for j = 1, 3 do
        local suffix = i .. "_" .. j
        table.insert(wandSprites[i], Sprite.load("wands_" .. suffix, "spr/wands/wand" .. suffix, 1, wandDims[wandConf].origX, wandDims[wandConf].origY))
    end
end

local wandParticles = {
    ParticleType.find("Dust1", "vanilla"),
    ParticleType.find("Fire2", "vanilla"),
    ParticleType.find("FireIce", "vanilla"),
    ParticleType.find("Poison", "vanilla"),
    ParticleType.find("Ice", "vanilla"),
    ParticleType.find("Spore", "vanilla")
}

wandShopParticle = ParticleType.new("caster_wand_shop_particle")
wandShopParticle:shape("line")
wandShopParticle:color(Color.WHITE)
wandShopParticle:alpha(1, 0)
wandShopParticle:scale(0.25, 0.25)
wandShopParticle:speed(1, 2, 0, 0)
wandShopParticle:direction(1, 360, 0, 0)
wandShopParticle:angle(0, 0, 0, 0, true)
wandShopParticle:life(15, 30)

local colors = {
    Color.ROR_RED,
    Color.ROR_GREEN,
    Color.ROR_BLUE,
    Color.ROR_YELLOW,
    Color.ROR_ORANGE,
    Color.AQUA,
    Color.FUCHSIA,
    Color.LIME,
    Color.PURPLE,
    Color.PINK,
    Color.CORAL,
    Color.GRAY,
    Color.WHITE
}

local names = {
    pre = {
        "Solitude's", "Misery's", "Providence's", "Scavenger's", "Miner's", "Loader's", "Huntress'", 
        "Philosopher's", "Some Dude's", "Hell's", "Desire's", "Aurelionite's", "Faith's", "Saturn's",
        "Valentine's", "Assa's", "Badger's", "Unknown", "Heaven's", "Anon's", "Bob's", "Acrid's"
    },
    adj = {
        "Runed", "Haunted", "Spooky", "Canopic", "Catastrophic", "Infinity", "Lucky", 
        "Longevity", "Space", "Alien", "Aurora", "Paramount", "Immortal", "Overloading", 
        "Archaic", "Cute", "Fluffy", "Blazed", "Elemental", "Petrifying", "Pixelated", 
        "Deformed", "Happy", "Moonlit", "Celestial", "Hellish", "Pandemonium", "Long",
        "Short", "Sparkling", "Flowered", "Shapeshifting", "Azure", "Alpha", "Extra",
        "Mad", "Rancid", "Sweet", "Igneous", "Fiery", "Frosty", "Whimsical", "Drunk"
    },
    name = {
        "Temptation", "Virtue", "Girth", "Demise", "Vagrant", "Bonk", "Immortality", 
        "Paradise", "Wand", "Staff", "Stick", "Rod", "Surprise", "Accident", 
        "Fungi", "Boi", "Pencil", "Lightsaber", "Nightbringer", "Snek", "Demon",
        "Jigaboo", 
    },
    pos = {
        "of Mysteries", "of Virility", "of Apathy", "of Oaths", "of Misfortune", "of Destiny", "of Banishment", 
        "of Prosperity", "of Death", "of Doom", "of Black Magic", "of Luck", "of Decadence", "of Strength", 
        "of Malice", "of the Occult", "of the Scourge", "of the Undead", "of Riddles", "of Mending", "of Resistance",
        "of Lunacy", "of Annihilation", "of Destiny", "of the Void", "of Sunshine", "of Delirium", "of Imperviousness"
    }
}

local values = {
    maxCapacityLow = 6,                     maxCapacityHigh = 8,                        spellNumberCap = 3,
    
    castChance =   {  {99, 1, 0},         {89, 10, 1},        {69, 25, 6}             },
    manaMax =      {  {10, 20},           {10, 50},           {30, 90}                },
    castDelay =    {  {20, 60},           {25, 80},           {30, 100}               }, --{  {50, 100},          {30, 75},           {10, 50}                },
    rechargeTime = {  150,                125,                100                     },
    manaCharge =   {  {5, 15},            {10, 25},           {15, 50}                }
    
}

local function generateWandName()
    local wandName = table.random(names.adj) .. " " .. table.random(names.name)
    if math.random(3) > 1 then
        if math.random(2) == 1 then
            wandName = table.random(names.pre) .. " " .. wandName
        else
            wandName = wandName .. " " .. table.random(names.pos)
        end
    end
    return wandName
end

local function generateWandSprite(wandSpriteNum, color1, color2, color3)
    if wandSpriteNum == nil then
        local stagesPassed = misc.director:get("stages_passed")
        local diffLimit = wandDiffLimit.easy
        if stagesPassed >= 2 and stagesPassed <= 5 then
            diffLimit = wandDiffLimit.medium
        elseif stagesPassed > 5 then
            diffLimit = totalWandNumber
        end
        wandSpriteNum = math.random(diffLimit)
    end
    if color1 == nil or color2 == nil or color3 == nil then
        local colorNums = {}
        for i = 1, #colors do
            table.insert(colorNums, i)
        end
        local shuffledColorNums = shuffleCopy(colorNums)
        color1, color2, color3 = shuffledColorNums[1], shuffledColorNums[2], shuffledColorNums[3]
    end
    local wandColors = {colors[color1], colors[color2], colors[color3]}
    
    local wandSpriteName = "caster_rngwand_wand" .. wandSpriteNum .. "_p1c" .. color1 .. "_p2c" .. color2 .. "_p3c" .. color3
    local finalSprite = Sprite.find(wandSpriteName, modloader.getActiveNamespace())
    if finalSprite == nil then
        local wandConf = "hard"
        if wandSpriteNum <= wandDiffLimit.easy then
            wandConf = "easy"
        elseif wandSpriteNum <= wandDiffLimit.medium then
            wandConf = "medium"
        end
    
        local surf = Surface.new(
            wandDims[wandConf].width, wandDims[wandConf].height
        )
        graphics.setTarget(surf)
        for i = 3, 1, -1 do
            graphics.drawImage{
                wandSprites[wandSpriteNum][i],
                wandDims[wandConf].origX, wandDims[wandConf].origY,
                color = wandColors[i]
            }
        end
        graphics.resetTarget()
        
        local dynSprite = surf:createSprite(
            wandDims[wandConf].origX, wandDims[wandConf].origY
        )
        surf:free()
        
        finalSprite = dynSprite:finalize(wandSpriteName)
    end
    
    return finalSprite, wandColors[1]
end

local function wandSpriteToIcon(sprite)
    local iconName = sprite:getName() .. "_icon"
    local icon = Sprite.find(iconName, modloader.getActiveNamespace())
    if icon == nil then                            
        local surf = Surface.new(18, 18)                                  -- +------------+
        graphics.setTarget(surf)                                          -- |            |
        graphics.drawImage{                                               -- |       \    |
            sprite,                                                       -- | ======O= O |
            0 + 1, 9,                                                     -- |       /    |
            scale = (18 - 1 - 1) / sprite.width                           -- |            |
        }                                                                 -- +------------+
        graphics.resetTarget()
        local dynSprite = surf:createSprite(0,0)
        surf:free()
        icon = dynSprite:finalize(iconName)
    end
    return icon
end

local function drawWandParticles(wand, x, y)
    if math.random(10) == 1 then
        wandParticles[wand.graphics.particle]:size(0.05, 0.25, -0.0033, 0)
        wandParticles[wand.graphics.particle]:burst("middle", x, y, math.random(3), wand.graphics.particleColor)
    end
end

local function canShootSpell(wand, spellIndex)
    local spell = wand.spells[spellIndex]
    return type(spell) == "table"
      and spell.manaCost <= wand.stats.manaMax -- wand needs to be able to shoot this spell
      --and (spell.type ~= spellType.PROJECTILE or spell.count ~= 0)
end

function isWandEmpty(wand)
    -- a wand is empty when it exists, but has no fireable spells
    -- that is, if it only has zero-count projectiles or no projectiles at all
    local empty = true
    for i = 1, #wand.spells do
        local spell = wand.spells[i]
        if type(spell) == "table" and spellType.PROJECTILE and spell.count ~= 0 then
            empty = false
            break
        end
    end
    return empty
end

function resetFiredSpells(wand)
    wand.firedSpells = {}
    for i = 1, #wand.spells do
        if not canShootSpell(wand, i) then
            table.insert(wand.firedSpells, i)
        end
    end
end

-- function selectNewSpell(wand, lastSpellFired)
    -- -- if last spell fired wasn't actually fired (no more ammo, for example), return it again
    -- if lastSpellFired == nil then
        -- return
    -- end

    -- -- sanity check
    -- local allNil = true
    -- for i = 1, #wand.spells do
        -- if type(wand.spells[i]) == "table" then
            -- allNil = false
            -- break
        -- end
    -- end
    -- if allNil then
        -- return
    -- end

    -- if not wand.stats.shuffle then
        -- wand.selectedSpell = (lastSpellFired % #wand.spells) + 1
        -- while type(wand.spells[wand.selectedSpell]) ~= "table" do
            -- wand.selectedSpell = (wand.selectedSpell % #wand.spells) + 1
        -- end
    -- else
        -- local rt = {}
        -- for i = 1, #wand.spells do
            -- if type(wand.spells[i]) == "table" then
                -- local notYetCast = true
                -- for j = 1, #wand.firedSpells do
                    -- if wand.firedSpells[j] == i then
                        -- notYetCast = false
                        -- break
                    -- end
                -- end
                -- if notYetCast then
                    -- table.insert(rt, i)
                -- end
            -- end
        -- end
        -- wand.selectedSpell = table.random(rt)
    -- end
-- end

function selectNewSpell(wand)
    -- return if there's no spells left to pick
    if #wand.firedSpells == #wand.spells then
        return
    end

    if not wand.stats.shuffle then
        wand.selectedSpell = 1
        local done = false
        while not done do
            done = true
            for i = 1, #wand.firedSpells do
                if wand.firedSpells[i] == wand.selectedSpell then
                    done = false
                    break
                end
            end
            if not done then
                wand.selectedSpell = wand.selectedSpell + 1
            end
        end
    else
        local rt = {}
        for i = 1, #wand.spells do
            local notYetCast = true
            for j = 1, #wand.firedSpells do
                if wand.firedSpells[j] == i then
                    notYetCast = false
                    break
                end
            end
            if notYetCast then
                table.insert(rt, i)
            end
        end
        wand.selectedSpell = table.random(rt)
    end
end

--==== public functions ====--

function generateRandomWand()
    local genName = generateWandName()
    local genSprite, genColor = generateWandSprite()
    local stagesPassed = misc.director:get("stages_passed")
    
    -- predefine some variables
    local diff = 1
    if stagesPassed >= 2 and stagesPassed <= 5 then
        diff = 2
    elseif stagesPassed > 5 then
        diff = 3
    end
    local spellsCastChance = values.castChance[diff]                            -- 1/2/3 cast spells per usage
    local genManaMax = math.random(unpack(values.manaMax[diff])) * 10           -- incrementing by 10
    local genCastDelay = math.random(unpack(values.castDelay[diff])) / 100      -- incrementing by 0.01s
    local genRechargeTime = math.random(15, values.rechargeTime[diff]) / 100    -- incrementing by 0.01s
    local genManaCharge = math.random(unpack(values.manaCharge[diff]))          -- incrementing by 1
    
    -- max spells in wand
    local maxCapacity = values.maxCapacityLow
    if stagesPassed >= 3 then
        maxCapacity = values.maxCapacityHigh
    end
    local capacity = math.random(maxCapacity)
    local spellNumber = math.random(capacity)
    -- cap spell numbers
    if stagesPassed <= 3 then
        spellNumber = math.min(spellNumber, values.spellNumberCap)
    end
    local genSpells = {}
    for i = 1, capacity do
        local tempSpell = 0
        if i <= spellNumber then
            tempSpell = getRandomWeightedSpell()
        end
        table.insert(genSpells, tempSpell)
    end
    
    -- generate spell multicasting
    local numSpellsCast = math.random(100)
    if numSpellsCast <= spellsCastChance[3] and capacity >= 3 then
        numSpellsCast = 3
    elseif numSpellsCast <= spellsCastChance[2] and capacity >= 2 then
        numSpellsCast = 2
    else
        numSpellsCast = 1
    end
    
    local newWand = {
        name = genName,
        graphics = {
            sprite = genSprite,
            icon = wandSpriteToIcon(genSprite),
            particle = 1, --math.random(#wandParticles),   -- removed randomness for now, it gets pretty annoying
            particleColor = genColor
        },
        stats = {
            shuffle = math.random(2) == 1,
            spellsCast = numSpellsCast,
            castDelay = genCastDelay,
            rechargeTime = genRechargeTime,
            manaMax = genManaMax,
            manaChargeSpd = genManaCharge,
            spread = math.random(-10, 10)               -- from -10 to 10, incrementing by 1
            --autoFire = math.random(2) == 1
        },
        spells = genSpells,
        mana = genManaMax,
        selectedSpell = 1,
        firedSpells = {},
        cooldown = 0,
        spellDelay = 0,
        boosted = false,
        
        -- used for sounds
        prevMana = genManaMax
    }
    
    for i = 1, #newWand.spells do
        if type(newWand.spells[i]) ~= "table" then
            -- empty spell; add it to fired spells
            table.insert(newWand.firedSpells, i)
        end
    end
    
    return newWand
end

function getInitialWands()
    return {
        {
            name = "Grandpa's Old Wand",
            graphics = {
                sprite = wandSprites.base[1],
                icon = wandSpriteToIcon(wandSprites.base[1]),
                particle = 1,
                particleColor = colors[6]
            },
            stats = {
                shuffle = false,
                spellsCast = 1,
                castDelay = 0.15,
                rechargeTime = 0.45,
                manaMax = 100,
                manaChargeSpd = 15,
                spread = 0
                --autoFire = true
            },
            spells = {
                allSpells.sparkBolt(),
                allSpells.sparkBolt(),
                DEBUG_MODE and allModifiers.homing() or 0
            },
            mana = 100,
            selectedSpell = 1,
            firedSpells = { 3 },
            cooldown = 0,
            spellDelay = 0,
            boosted = false,
            
            -- used for sounds
            prevMana = 100
        },
        {
            name = "Big Boom",
            graphics = {
                sprite = wandSprites.base[2],
                icon = wandSpriteToIcon(wandSprites.base[2]),
                particle = 1,
                particleColor = colors[1]
            },
            stats = {
                shuffle = true,
                spellsCast = 1,
                castDelay = 0.12,
                rechargeTime = 0.15,
                manaMax = 110,
                currentMana = 110,
                manaChargeSpd = 9,
                spread = 0
                --autoFire = false
            },
            spells = {
                allSpells.bomb()
            },
            mana = 100,
            selectedSpell = 1,
            firedSpells = {},
            cooldown = 0,
            spellDelay = 0,
            boosted = false,
            
            -- used for sounds
            prevMana = 110
        },
        0,
        0
    }
end

function getWandName(wand)
    if type(wand) ~= "table" then
        return ""
    end
    return wand.name
end

function getWandDetails(wand)
    if type(wand) ~= "table" then
        return ""
    end
    local str = ""
    local counter = 0
    for _, spell in ipairs(wand.spells) do
        if type(spell) == "table" then
            local spellStr = spell.name
            if spell.type == spellType.PROJECTILE and spell.count ~= -1 then
                spellStr = spellStr .. " (" .. spell.count .. ")"
            end
            counter = counter + 1
            if str == "" then
                str = spellStr
            -- elseif counter == 3 then
                -- str = str .. ",\n" .. spellStr
            else
                str = str .. ", " .. spellStr
            end
        end
    end
    if str ~= "" then
        return str
    else
        return "Empty. Requires spells to work."
    end
end

function getWandIcon(wand)
    if type(wand) ~= "table" then
        return emptySprite
    end
    return wand.graphics.icon
end

function scepterBoostWand(wand)
    if type(wand) ~= "table" then
        return wand
    end
    wand.name = "Boosted " .. wand.name
    wand.castDelay = wand.castDelay / 2
    wand.stats.rechargeTime = wand.stats.rechargeTime * 3 / 4
    wand.boosted = true
    return wand
end

function getWandCooldown(wand)
    if type(wand) ~= "table" then
        return 0
    end
    return wand.cooldown
end

-- function getWandCastTime(wand)
    -- return math.max(wand.stats.castDelay + wand.spells[wand.selectedSpell].castDelay, 0)
-- end

-- function isWandAuto(wand)
    -- return wand.stats.autoFire
-- end

function wandOnSpellDelay(wand)
    return wand.spellDelay > 0
end

function wandOnCooldown(wand)
    return wand.cooldown > 0
end

function wandHasManaForSpell(wand)
    return wand.selectedSpell > 0
      and wand.spells[wand.selectedSpell] ~= nil
      and wand.mana >= wand.spells[wand.selectedSpell].manaCost
end

function shootWand(actor, wand, actorX, actorY, targetX, targetY)
    local wandAngleRad = math.atan2(targetY - actorY, targetX - actorX)
    local numberSpells = 0
    local newlyFiredSpells = {}
    for i = 1, wand.stats.spellsCast do
        -- if Shattered Mirror is on, just fire more shots lmao
        local multiplier = actor:get("sp")
        if multiplier == nil then
            multiplier = 0
        end
        -- fire wand
        local spellsCastDelay, spellsRechargeTime, spellsManaCost, nextSpellToCast = 0, 0, 0, 0
        for j = 1, multiplier + 1 do
            spellsCastDelay, spellsRechargeTime, spellsManaCost, nextSpellToCast = fireSpell(
                actor,
                wand,
                wand.selectedSpell,
                nil,
                nil,
                actorX + wand.graphics.sprite.width * math.cos(wandAngleRad),
                actorY + wand.graphics.sprite.height * math.sin(wandAngleRad),
                math.deg(wandAngleRad)
            )
        end
        local numberSpellsCast = nextSpellToCast - wand.selectedSpell
        
        -- get spells that were fired
        newlyFiredSpells = {}
        for j = wand.selectedSpell, wand.selectedSpell + numberSpellsCast - 1 do
            table.insert(newlyFiredSpells, j)
        end
        
        -- add non-repeats to fired shots
        for _, newlyFired in ipairs(newlyFiredSpells) do
            local alreadyFired = false
            for _, fired in ipairs(wand.firedSpells) do
                if newlyFired == fired then
                    alreadyFired = true
                    break
                end
            end
            if not alreadyFired then
                table.insert(wand.firedSpells, newlyFired)
            end
        end
        
        -- take mana spent after shooting
        wand.mana = math.max(wand.mana - spellsManaCost, 0)
        -- add cast delay after shooting
        -- if spellsCastDelay == nil, one of the spells fired reset the delay to 0
        wand.spellDelay = spellsCastDelay == nil and 0 or (math.max(wand.stats.castDelay + spellsCastDelay, 0) * 60)
        
        -- get all wand spells, including those who aren't even filled (because fired spells count those)
        numberSpells = #wand.spells
        
        -- if all spells were fired
        if #wand.firedSpells == numberSpells then
            -- trigger wand cooldown, then reset the fired spells
            wand.cooldown = 60 * math.max(wand.stats.rechargeTime + spellsRechargeTime, 0)
                * ( 1 / actor:get("attack_speed") ) -- TODO: should attack speed buff be nerfed?
            resetFiredSpells(wand)
            -- pick a new spell after resetting the fired spells
            selectNewSpell(wand)--, newlyFiredSpells[#newlyFiredSpells])
            -- and break the loop here
            break
        else
            -- if there's still spells to be fired, pick another one and carry on
            selectNewSpell(wand)--, newlyFiredSpells[#newlyFiredSpells])
        end
    end
end

function drawWand(wand, playerCoords, mouseCoords)
    -- origY needs to switch with playerY because RoR has a bad coord system
    local wandAngleRad = math.atan2(playerCoords[2] - mouseCoords[2], mouseCoords[1] - playerCoords[1])
    graphics.drawImage{
        image = wand.graphics.sprite,
        x = playerCoords[1],
        y = playerCoords[2],
        angle = math.deg(wandAngleRad)
    }
    if misc.getOption("video.quality") == 3 then
        drawWandParticles(
            wand,
            playerCoords[1] + wand.graphics.sprite.width * math.cos(wandAngleRad),
            playerCoords[2] + wand.graphics.sprite.width * math.sin(wandAngleRad)
        )
    end
end

function wandStep(wand)
    -- lower spell cast delays
    wand.spellDelay = math.max(wand.spellDelay - 1, 0)
    -- lower cooldown
    if wand.spellDelay == 0 then
        wand.cooldown = math.max(wand.cooldown - 1, 0)
    end
    -- increase mana
    wand.mana = math.min(wand.mana + wand.stats.manaChargeSpd / 60, wand.stats.manaMax)
    -- if wand.mana == wand.stats.manaMax and wand.prevMana < wand.stats.manaMax then
        -- sounds.wand.mana_fully_recharged:play()
    -- end
    wand.prevMana = wand.mana
end

function reorderItemsOrSpells(player, from, to)
    -- from/to can be:
    --     integers (representing inventory slot)
    --     decimals (only for wands (1 to 4); the decimals represent the spell slot (ex. 1.3 is the third spell of the first wand))
    playerData = player:getData()
    local inv = playerData.inventory
    
    if from < 1 or from > #inv+4 or to < 1 or to > #inv+4 then
        return
    end
    
    local fromIndex, toIndex = roundNumber(math.floor(from), 0), roundNumber(math.floor(to), 0)
    local fromWandSpell, toWandSpell = roundNumber((from - fromIndex) * 10, 0), roundNumber((to - toIndex) * 10, 0)
    
    local messedWithFromWand, messedWithToWand = false, false
    
    -- "from" has to have a wand, no switching from empty to something else
    if fromWandSpell == 0 and from <= 4 and type(playerData.wands[from]) ~= "table"
      or from >= 5 and type(playerData.inventory[from-4]) ~= "table"
      or fromWandSpell ~= 0 and type(playerData.wands[fromIndex].spells[fromWandSpell]) ~= "table" then
        return
    end
    
    if fromWandSpell == 0 and toWandSpell == 0 and from <= 4 and to <= 4 then
        -- wand to wand switching
        playerData.wands[to], playerData.wands[from] = playerData.wands[from], playerData.wands[to]
    else
        -- spell to spell switching
        if from >= 5 and to >= 5 then
            playerData.inventory[to-4], playerData.inventory[from-4] = playerData.inventory[from-4], playerData.inventory[to-4]
        elseif fromWandSpell ~= 0 and toWandSpell ~= 0 then
            playerData.wands[toIndex].spells[toWandSpell], playerData.wands[fromIndex].spells[fromWandSpell] =
                playerData.wands[fromIndex].spells[fromWandSpell], playerData.wands[toIndex].spells[toWandSpell]
            messedWithFromWand, messedWithToWand = true, true
        elseif fromWandSpell ~= 0 and to >= 5 then
            playerData.inventory[to-4], playerData.wands[fromIndex].spells[fromWandSpell] =
                playerData.wands[fromIndex].spells[fromWandSpell], playerData.inventory[to-4]
            messedWithFromWand = true
        elseif from >= 5 and toWandSpell ~= 0 then
            playerData.wands[toIndex].spells[toWandSpell], playerData.inventory[from-4] =
                playerData.inventory[from-4], playerData.wands[toIndex].spells[toWandSpell]
            messedWithToWand = true
        end
    end
    
    -- reset wand stuff if it was messed with (TODO: this will skip some spells from being fired, but is it really that important?)
    for i = 1, 2 do
        local index = i == 1 and fromIndex or toIndex
        local check = i == 1 and messedWithFromWand or i == 2 and messedWithToWand
        if check then
            resetFiredSpells(playerData.wands[index])
            selectNewSpell(playerData.wands[index])--, #playerData.wands[index].spells)
        end
    end
    
    if toWandSpell == 0 and to <= 4 and type(playerData.wands[to]) ~= "table"
      or to >= 5 and type(playerData.inventory[to-4]) ~= "table"
      or toWandSpell ~= 0 and type(playerData.wands[toIndex].spells[toWandSpell]) ~= "table" then
        getSound("inv", "item_move_success"):play()
    else
        getSound("inv", "item_switch_places"):play()
    end
end

--==== networking ====--

function serializeWandSprite(sprite)
    local spriteName = sprite:getName() .. "_"
    local nums = {}
    for n in spriteName:gmatch("(%d+)_") do
        table.insert(nums, tonumber(n))
    end
    if spriteName:find("wands_base") ~= nil then
        -- base wands be based
        return -nums[1]
    end
    return table.unpack(nums)
end

function deserializeWandSprite(wandSpriteNum, color1, color2, color3)
    if wandSpriteNum < 0 then
        return wandSprites.base[-wandSpriteNum], -wandSpriteNum == 1 and colors[6] or colors[1]
    else
        return generateWandSprite(wandSpriteNum, color1, color2, color3)
    end
end

function serializeWand(wand)
    local data = {
        wand.name,
        wand.graphics.particle,
        wand.stats.shuffle,
        wand.stats.spellsCast,
        wand.stats.castDelay,
        wand.stats.rechargeTime,
        wand.stats.manaMax,
        wand.stats.manaChargeSpd,
        wand.stats.spread,
        wand.mana,
        wand.selectedSpell,
        wand.cooldown,
        wand.spellDelay,
        wand.boosted,
        wand.prevMana
    }
    
    local spriteT = {serializeWandSprite(wand.graphics.sprite)}
    for _, spritePart in ipairs(spriteT) do
        table.insert(data, spritePart)
    end
    
    table.insert(data, #wand.spells)
    for _, spell in ipairs(wand.spells) do
        if type(spell) ~= "table" then
            table.insert(data, 0)
        else
            local serializedSpell = {serializeSpell(spell)}
            table.insert(data, #serializedSpell)
            for _, spellThing in ipairs(serializedSpell) do
                table.insert(data, spellThing)
            end
        end
    end
    
    for _, firedSpell in ipairs(wand.firedSpells) do
        table.insert(data, firedSpell)
    end
    
    return table.unpack(data)
end

function deserializeWand(serializedWand)
    local wand = {
        name = serializedWand[1],
        graphics = {
            particle = serializedWand[2]
        },
        stats = {
            shuffle = serializedWand[3],
            spellsCast = serializedWand[4],
            castDelay = serializedWand[5],
            rechargeTime = serializedWand[6],
            manaMax = serializedWand[7],
            manaChargeSpd = serializedWand[8],
            spread = serializedWand[9],
        },
        mana = serializedWand[10],
        selectedSpell = serializedWand[11],
        cooldown = serializedWand[12],
        spellDelay = serializedWand[13],
        boosted = serializedWand[14],
        prevMana = serializedWand[15]
    }
    
    local nextThings = 16
    if serializedWand[nextThings] < 0 then
        wand.graphics.sprite, wand.graphics.particleColor =
            deserializeWandSprite(serializedWand[nextThings])
    else
        wand.graphics.sprite, wand.graphics.particleColor =
            deserializeWandSprite(serializedWand[nextThings], serializedWand[nextThings+1],
                serializedWand[nextThings+2], serializedWand[nextThings+3])
        nextThings = nextThings + 3
    end
    nextThings = nextThings + 1
    wand.graphics.icon = wandSpriteToIcon(wand.graphics.sprite)
    
    local currCounter = 1
    wand.spells = {}
    for i = 1, serializedWand[nextThings] do
        local spellCount = serializedWand[nextThings + currCounter]
        -- if spellCount == 0 then
            -- wand.spells[i] = 0
        -- else
            -- local spellArgs = {}
            -- for ind = nextThings + currCounter + 1, nextThings + currCounter + spellCount do
                -- table.insert(spellArgs, serializedWand[ind])
            -- end
            -- wand.spells[i] = deserializeSpell(spellArgs)
        -- end
        wand.spells[i] = deserializeSpell({table.unpack(serializedWand, nextThings + currCounter + 1, nextThings + currCounter + spellCount)})
        currCounter = currCounter + spellCount + 1
    end
    
    wand.firedSpells = {}
    for i = currCounter, #serializedWand do
        table.insert(wand.firedSpells, serializedWand[i])
    end
    
    return wand
end

--==== wand object ====--                                       -- TODO: remove all "magic numbers"

-- counter for every wand object, used as id generator for online syncing
wandObjectCounter = 0
registercallback("onGameStart", function()
    wandObjectCounter = 0
end, 5000)
function newWandID()
    wandObjectCounter = wandObjectCounter + 1
    return wandObjectCounter
end

function spawnWandObject(wand, x, y, angle)
    local wandInst = wandObj:create(x, y)
    wandData = wandInst:getData()
    wandData.wand = wand
    if angle == nil then
        -- pick a random angle to throw the wand at
        angle = math.random(75, 105)
    end
    wandData.vector = {math.cos(math.rad(angle)), -math.sin(math.rad(angle))}
    
    return wandInst, angle
end

wandObj:addCallback("create", function(self)
    wandData = self:getData()
    --self.mask = wandSprites.shadow
    wandData.id = newWandID()
    wandData.wand = nil
    wandData.owner = nil
    wandData.vector = {0, 0}
    wandData.life = 0
    wandData.shop = -1
    wandData.beingPicked = false
end)

wandObj:addCallback("destroy", function(self)
    --TODO: add fancy particles or whatever
end)

wandObj:addCallback("draw", function(self)
    wandData = self:getData()
    if wandData.owner ~= nil and not wandData.owner:isValid() then
        wandData.owner = nil
        self.depth = -8
    end
    if wandData.wand ~= nil then
        if wandData.shop == -1 then
            local owner = wandData.owner
            if owner ~= nil then
                self.angle = (owner:get("state") == "chase" and 30 or -30) * owner.xscale
            else
                local isStopped = wandData.vector[1] == 0 and wandData.vector[2] == 0
                self.angle = (isStopped and wandData.life or wandData.life * 3) % 360
            end
            graphics.drawImage{
                wandData.wand.graphics.sprite,
                self.x, self.y,
                xscale = owner ~= nil and owner.xscale or 1,
                angle = self.angle,
                
                scale = 1.5
            }
        else
            self.angle = 90
            graphics.drawImage{
                wandData.wand.graphics.sprite,
                self.x, self.y + 3 * math.sin(math.rad(wandData.life)),
                angle = self.angle,
                
                scale = 1.5
            }
            if misc.getOption("video.quality") == 3 then
                wandShopParticle:burst("above", self.x, self.y, (wandData.life % 20 == 0) and math.random(2) or 0)
            end
        end
    end
end)

wandObj:addCallback("step", function(self)
    wandData = self:getData()
    wandData.life = wandData.life + 1
    
    if wandData.wand ~= nil and self.sprite ~= wandData.wand.graphics.sprite then
        self.sprite = wandData.wand.graphics.sprite
        self.alpha = 0
    end
    
    if wandData.owner == nil and wandData.shop == -1 then
        -- movement, collisions
        if wandData.vector[1] ~= 0 or wandData.vector[2] ~= 0 then
            wandData.vector = normalizeVector({wandData.vector[1], wandData.vector[2] + 1/10})
            self.x = self.x + wandData.vector[1] * 3
            if self:collidesMap(self.x, self.y) then
                while self:collidesMap(self.x, self.y) do
                    self.x = self.x - wandData.vector[1]
                end
                wandData.vector[1] = wandData.vector[1] * -2/3
            end
            self.y = self.y + wandData.vector[2] * 3
            if self:collidesMap(self.x, self.y) then
                while self:collidesMap(self.x, self.y) do
                    self.y = self.y - wandData.vector[2]
                end
                if wandData.vector[2] < 0 then
                    wandData.vector[2] = wandData.vector[2] * -2/3
                else
                    wandData.vector = {0, 0}
                end
            end
        end
        
        -- check if a classic enemy can pick it up
        local closestEnemy = ParentObject.find("classicEnemies", "vanilla"):findNearest(self.x, self.y)
        if closestEnemy ~= nil and closestEnemy:isValid() and withinPickupRange(closestEnemy, self) then
            local enemyData = closestEnemy:getData()
            if enemyData.hasWand == nil then
                wandData.owner = closestEnemy
                self.depth = closestEnemy.depth + 1
                enemyData.hasWand = true
            end
        end
    elseif wandData.shop ~= -1 then
        -- shop wands do nothing
    else
        local wand = wandData.wand
        if not net.online or (net.online and net.host) then
            -- enemies with wands
            local owner = wandData.owner
            self.x, self.y = owner.x, owner.y
            if wand.cooldown == 0 and wand.spellDelay == 0 and owner:get("state") == "chase"
              and owner:get("target") ~= nil and math.random(30) == 1 then
                local target = Object.findInstance(owner:get("target"))
                if target ~= nil and target:isValid() then
                    local wandW, wandH = wand.graphics.sprite.width * math.cos(30) * owner.xscale,
                        wand.graphics.sprite.height * math.sin(30) * -1
                    shootWand(owner, wand, owner.x + wandW, owner.y + wandH, target.x, target.y)
                    if net.online then
                        packets.shootWand:sendAsHost(net.ALL, nil, owner:getNetIdentity(), owner.x + wandW, owner.y + wandH, target.x, target.y, serializeWand(wand))
                    end
                end
            end
        end
        
        -- lower cooldowns
        wand.spellDelay = math.max(wand.spellDelay - 1, 0)
        if wand.spellDelay == 0 then
            wand.cooldown = math.max(wand.cooldown - 1, 0)
        end
        -- enemies are overpowered: unlimited mana and spells
        wand.mana = wand.stats.manaMax
        for _, spell in ipairs(wand.spells) do
            if type(spell) == "table" and spell.count ~= -1 then
                spell.count = spell.maxCount
            end
        end
    end
end)