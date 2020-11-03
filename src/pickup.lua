-- made by Uziskull

local pickupSprites = {
    regen = {
        hp = Sprite.load("caster_pickup_spr_hprefill", "spr/pickups/hp_refill", 1, 10, 10),
        spell = Sprite.load("caster_pickup_spr_spellrefill", "spr/pickups/spell_refill", 1, 10, 10)
    }
}

--==== text popups ====--

-- queue for popups
local popupTextQueue = {}
local function popupTextQueueAdd(text, subtext)
    popupTextQueue[#popupTextQueue + 1] = {text, subtext, 0}
end

registercallback("onPlayerHUDDraw", function(player, _, _)
    if #popupTextQueue > 0 and player:getSurvivor() == caster and (not net.online or (net.online and net.localPlayer == player)) then
        local hudW, hudH = graphics.getHUDResolution()
        local deltaY = 0
        if popupTextQueue[1][2] ~= nil then
            deltaY = graphics.textHeight(popupTextQueue[1][1], graphics.FONT_LARGE) + graphics.textHeight(popupTextQueue[1][2], graphics.FONT_DEFAULT)
        end
        graphics.color(Color.WHITE)
        graphics.alpha(1 - (math.max(popupTextQueue[1][3], 3*60) - 3*60) / 60)
        graphics.print(
            popupTextQueue[1][1],
            hudW / 2, hudH / 3 - deltaY / 2,
            graphics.FONT_LARGE,
            graphics.ALIGN_MIDDLE, graphics.ALIGN_CENTER
        )
        if popupTextQueue[1][2] ~= nil then
            graphics.print(
                popupTextQueue[1][2],
                hudW / 2, hudH / 3 + deltaY / 2,
                graphics.FONT_DEFAULT,
                graphics.ALIGN_MIDDLE, graphics.ALIGN_CENTER
            )
        end
        graphics.alpha(1)
        
        popupTextQueue[1][3] = popupTextQueue[1][3] + 1
        if popupTextQueue[1][3] >= 4 * 60 then
            -- queuen't
            popupTextQueue = {table.unpack(popupTextQueue, 2, #popupTextQueue)}
        end
    end
end)

--==== pickup objects ====--

-- counter for every pickup object, used as id generator for online syncing
pickupObjectCounter = 0
registercallback("onGameStart", function()
    pickupbjectCounter = 0
end, 5000)
function newPickupID()
    pickupObjectCounter = pickupObjectCounter + 1
    return pickupObjectCounter
end

local regenObj = Object.new("caster_pickup_regen")
regenObj:addCallback("create", function(self)
    objData = self:getData()
    objData.id = newPickupID()
    objData.type = "hp"
    objData.life = 0
end)
regenObj:addCallback("step", function(self)
    objData = self:getData()
    objData.life = objData.life + 1
    
    if self.sprite == nil then
        self.sprite = pickupSprites.regen[objData.type]
    end
    
    -- floatin
    self.y = self.y + 1/20 * math.cos(math.rad(objData.life * 360 / 120))
end)
regenObj:addCallback("draw", function(self)
    for _, player in ipairs(misc.players) do
        if player:getSurvivor() == caster and player:collidesWith(self, player.x, player.y) then
            objData = self:getData()
            if objData.type == "hp" then
                -- regen hp
                local maxhp = player:get("maxhp")
                player:set("hp", maxhp)
                -- draw text
                popupTextQueueAdd("PICKED UP FULL HEALTH REGENERATION", "Restored health to " .. maxhp)
                -- play sound
                getSound("player", "pickup", "heart_refresh"):play()
            elseif objData.type == "spell" then
                -- refresh all spell counts
                playerData = player:getData()
                for _, wand in ipairs(playerData.wands) do
                    if type(wand) == "table" then
                        for _, spell in ipairs(wand.spells) do
                            if type(spell) == "table" and spell.type == spellType.PROJECTILE then
                                spell.count = spell.maxCount
                            end
                        end
                    end
                end
                for _, spell in ipairs(playerData.inventory) do
                    if type(spell) == "table" and spell.type == spellType.PROJECTILE then
                        spell.count = spell.maxCount
                    end
                end
                -- draw text
                popupTextQueueAdd("PICKED UP SPELL REFRESHER", "All spells refreshed")
                -- play sound
                getSound("player", "pickup", "spell_refresh"):play()
            end
            self:destroy()
            break
        end
    end
end)
regenObj:addCallback("destroy", function(self)
    objData = self:getData()
    if net.host then
        packets.destroyPickup:sendAsHost(net.ALL, nil, self:getObject(), objData.id)
    else
        packets.destroyPickup:sendAsClient(self:getObject(), objData.id)
    end
    if misc.getOption("video.quality") == 3 then
        local particle = ParticleType.find("Spark")
        particle:color(objData.type == "hp" and Color.ROR_RED or Color.ROR_GREEN)
        particle:burst("above", self.x, self.y, 20)
    end
end)

function spawnPickups(x, y)
    local offset = 40
    local hpInst = regenObj:create(x - offset, y - 10)
    hpInst.depth = -7
    while hpInst:collidesMap(hpInst.x, hpInst.y) and hpInst.x < x do
        offset = offset + 5
        hpInst.x = x + offset
    end
    offset = 40
    local spellInst = regenObj:create(x + offset, y - 10)
    spellInst.depth = -7
    spellInst:getData().type = "spell"
    while spellInst:collidesMap(spellInst.x, spellInst.y) and spellInst.x > x do
        offset = offset - 5
        spellInst.x = x + offset
    end
end

registercallback("onStep", function()
    if not net.online or (net.online and net.host) then
        local currTp = Object.find("Teleporter"):find(1)
        if currTp ~= nil then
            tpData = currTp:getData()
            if tpData.spawnedPickups == nil and currTp:get("active") >= 3 then
                tpData.spawnedPickups = true
                local casterExists = false
                for _, p in ipairs(misc.players) do
                    if p:getSurvivor() == caster then
                        casterExists = true
                        break
                    end
                end
                if casterExists then
                    spawnPickups(currTp.x, currTp.y)
                    packets.spawnPickups:sendAsHost(net.ALL, nil)
                end
            end
        end
    end
end)