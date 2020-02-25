-- made by Uziskull

--==== constants ====--

CONST_MAX_FLY_FUEL = 100
CONST_FLY_SPEED_START = -1
CONST_FLY_SPEED_STEP = 1/6000
CONST_FLY_SPEED_MAX = -3
CONST_FUEL_COOLDOWN = 30
CONST_INVENTORY_ACTIVITY = 45
CONST_WAND_PICKING_ACTIVITY = 46
CONST_GAMEPAD_OPTIONS_ACTIVITY = 47
CONST_DEFAULT_COLORS = {H = 207, S = 255, V = 237} -- {H = 292, S = 100, V = 93}

--==== sprite stuff ====--

spriteActions = {"idle", "walk", "jump", "climb", "select"}--, "death"}
spriteParts = {"Head", "Torso", "Legs"}
hsv = {"H", "S", "V"}
spritePieces = {
    idle = { frames = 1, x = 3, y = 10,
        handPos = {{1,10}}
    },
    walk = { frames = 8, x = 4, y = 10,
        handPos = {{4,9},{3,10},{3,10},{2,10},{1,10},{2,10},{3,10},{4,10}}
    },
    jump = { frames = 1, x = 5, y = 11,
        handPos = {{1,10}}
    },
    climb = { frames = 2, x = 4, y = 7,
        handPos = nil
    },
    death = { frames = 8, x = 48, y = 13,
        handPos = nil
    },
    select = { frames = 4, x = 2, y = 0,
        handPos = nil
    }
}           
local skinColor = Color.fromRGB(232, 237, 101)
spritePiecesList = {"Extra"}
for _, part in ipairs(spriteParts) do
    table.insert(spritePiecesList, part)
end

--==== load all sprite parts ====--

for _, action in ipairs(spriteActions) do
    spritePieces[action].sprites = {
        normal = {}, shaded = {}
    }
    for i = 1, spritePieces[action].frames do
        local normalPartTable = {}
        local shadedPartTable = {}
        for _, part in ipairs(spritePiecesList) do
            -- exception for select sprite
            if not (action == "select" and i <= 2 and part ~= "Extra") then
                local spritePart = part
                if spritePieces[action].frames > 1 then
                    spritePart = i .. "_" .. spritePart
                end
                normalPartTable[part] = Sprite.load(
                    "caster_" .. action .. "_" ..  spritePart,     ---- action --> frames
                    "spr/caster/" .. action .. "/" .. spritePart,  ----            x, y
                    1,                                             ----            sprites --> normal --> 1     Head 
                    spritePieces[action].x,                        ----                        shaded     2 --> Torso
                    spritePieces[action].y                         ----                                  ...    Legs
                )                                                  ----                                         Extra
                
                spritePart = spritePart .. "_shaded"
                if part == "Extra" then
                    shadedPartTable[part] = normalPartTable[part]
                else
                    shadedPartTable[part] = Sprite.load(
                        "caster_" .. action .. "_" ..  spritePart,
                        "spr/caster/" .. action .. "/" .. spritePart,
                        1,
                        spritePieces[action].x,
                        spritePieces[action].y
                    )
                end
            end
        end
        table.insert(spritePieces[action].sprites.normal, normalPartTable)
        table.insert(spritePieces[action].sprites.shaded, shadedPartTable)
    end
end

baseSprites = {
	--death = Sprite.load("caster_death", "spr/caster/death", 8, 48, 13),
    
	decoy = Sprite.load("caster_decoy", "spr/caster/decoy", 1, 6, 12)
}

sprites = {}

local function initSprites(playerIndex)
    sprites[playerIndex] = {}
    sprites[playerIndex].death, sprites[playerIndex].select, sprites[playerIndex].decoy = baseSprites.death, baseSprites.select, baseSprites.decoy
end

--==== networking ====--

function serializeColors(player)
    playerData = player:getData()
    local resultT = {}
    for _, part in ipairs(spriteParts) do
        for _, color in ipairs(hsv) do
            resultT[#resultT + 1] = playerData.colors[part][color]
        end
    end
    return table.unpack(resultT)
end

--==== functions ====--

function getSavedColors()
    local colorTable = {}
    for _, part in ipairs(spriteParts) do
        colorTable[part] = {}
        for _, color in ipairs(hsv) do
            local savedValue = save.read("caster_" .. part .. color)
            if savedValue == nil or type(savedValue) ~= "number" or not (savedValue >= 0 and savedValue <= 255) then
                savedValue = CONST_DEFAULT_COLORS[color]
            end
            -- due to the palette size, colors have to be confined a bit (not really noticeable anyway)
            colorTable[part][color] = math.floor(savedValue / 4) * 4
        end
    end
    local shading = save.read("caster_shading")
    if shading == nil or type(shading) ~= "boolean" then
        shading = false
    end
    colorTable.shading = shading
    return colorTable
end

function writeSavedColors(colors)
    -- validating values is for plebs anyway, just write it
    for _, part in ipairs(spriteParts) do
        for _, color in ipairs(hsv) do
            save.write("caster_" .. part .. color, colors[part][color])
        end
    end
    save.write("caster_shading", colors.shading)
end

function createNewColoredSprites(playerIndex, colors)
    initSprites(playerIndex)
    for _, action in ipairs(spriteActions) do
        local spritePartName = "caster_" .. action
        for _, part in ipairs(spriteParts) do
            spritePartName = spritePartName .. "_" .. part 
            for _, color in ipairs(hsv) do
                spritePartName = spritePartName .. "_" .. color .. colors[part][color]
            end
        end
        if colors.shading then
            spritePartName = spritePartName .. "_shaded"
        end
        local newSprite = Sprite.find(spritePartName, modloader.getActiveNamespace())
        if newSprite == nil then
            local spriteType = colors.shading and "shaded" or "normal"
            local dynSprite = nil
            local surfaceList = {}
            for i = 1, spritePieces[action].frames do
                for _, part in ipairs(spritePiecesList) do
                    -- exception for select sprite
                    if not (action == "select" and i <= 2 and part ~= "Extra") then
                        local pieceSprite = spritePieces[action].sprites[spriteType][i][part]
                        if surfaceList[i] == nil then
                            surfaceList[i] = Surface.new(pieceSprite.width, pieceSprite.height)
                            graphics.setTarget(surfaceList[i])
                        end
                        local color = Color.WHITE
                        local decoloration = 0
                        if action == "select" and i >= 3 then
                            -- do that decoloration thing that characters have in selection screen to make it look more ror-like
                            decoloration = i == 3 and -50 or -25
                        end
                        if part ~= "Extra" then
                            color = Color.fromHSV(colors[part].H, colors[part].S + decoloration, colors[part].V + decoloration)
                        end
                        graphics.drawImage{
                            pieceSprite, spritePieces[action].x, spritePieces[action].y,
                            color = color
                        }
                    end
                end
                if dynSprite == nil then
                    dynSprite = surfaceList[i]:createSprite(spritePieces[action].x, spritePieces[action].y)
                else
                    dynSprite:addFrame(surfaceList[i])
                end
            end
            newSprite = dynSprite:finalize(spritePartName)
            graphics.resetTarget()
            for i = 1, #surfaceList do
                surfaceList[i]:free()
            end
        end
        sprites[playerIndex][action] = newSprite
    end
end

function setPlayerSprites(player, ...)
    local data = {...}
    playerData = player:getData()
    
    if #data > 0 then
        local counter = 1
        playerData.colors = {}
        for _, part in ipairs(spriteParts) do
            playerData.colors[part] = {}
            for _, color in ipairs(hsv) do
                playerData.colors[part][color] = data[counter]
                counter = counter + 1
            end
        end
    end
    
    local playerIndex = isa(player, "PlayerInstance") and getPlayerIndex(player) or 1
    createNewColoredSprites(playerIndex, playerData.colors)
    if isa(player, "PlayerInstance") then
        player:setAnimations(sprites[playerIndex])
    end

    if #data == 0 then
        -- only ran for the local client
        writeSavedColors(playerData.colors)
        caster.loadoutSprite = sprites[playerIndex].select
        caster.titleSprite = sprites[playerIndex].walk
        caster.idleSprite = sprites[playerIndex].idle
    end
end

hud = {
    totalLength = 27,                               iconBarSpacing = 2,
    barLength = 20,                                 drawHeight = -15,
    barHeight = 2,                                  drawStep = -6,
    
    borderColor = Color.fromRGB(51, 43, 60),        indentEdgeColor = Color.fromRGB(40, 39, 58),
    fillColor = Color.fromRGB(64, 65, 87),          indentColor = Color.fromRGB(26, 26, 26),
    lightFillColor = Color.fromRGB(84, 85, 114),
    
    inventoryIcon = Sprite.load("caster_hud_inventory", "spr/hud/inventoryIcon", 1, 3, 0),
    pickingWandIcon = Sprite.load("caster_hud_pickingWand", "spr/hud/pickingWandIcon", 1, 3, 0)
    
}
hud[1] = { -- wand cooldown
    icon = Sprite.load("caster_hud_cooldown", "spr/hud/cooldownIcon", 1, 0, 0),
    color = Color.fromRGB(198, 79, 0)
}
hud[2] = { -- wand mana
    icon = Sprite.load("caster_hud_mana", "spr/hud/manaIcon", 1, 0, 0),
    color = Color.fromRGB(0, 122, 174)
}
hud[3] = { -- flight fuel
    icon = Sprite.load("caster_hud_fly", "spr/hud/flyIcon", 1, 0, 0),
    color = Color.fromRGB(186, 182, 12)
}

--==== character loadout ====--

local function getInitSpriteStuff()
    local initWands = getInitialWands() -- yes this gets called twice on run start, but who caaaaaares anyway
    local initWandsIcons = Sprite.find("caster_skills", modloader.getActiveNamespace())
    if initWandsIcons == nil then
        -- icon 1
        local surf = Surface.new(18, 18)
        graphics.setTarget(surf)
        initWands[1].graphics.icon:draw(0,0)
        local dynSprite = surf:createSprite(0,0)
        -- icon 2
        surf:clear()
        initWands[2].graphics.icon:draw(0,0)
        dynSprite:addFrame(surf)
        -- icon 3
        surf:clear()
        dynSprite:addFrame(surf)
        -- icon 4
        dynSprite:addFrame(surf)
        initWandsIcons = dynSprite:finalize("caster_skills")
    end
    return initWandsIcons
end

local initWandsIcons = getInitSpriteStuff()

local savedColors = getSavedColors()
createNewColoredSprites(1, savedColors)

caster:setLoadoutInfo(
[[The &y&Spellcaster&!& is a magician that collects wands and spells along the way to get stronger.
She starts out with two predetermined &y&wands&!& and can collect up to &y&four wands&!& in total.
Wands use up &b&mana&!& and can be &y&customized&!& at the end of each level.
As a weak human, the &y&Spellcaster&!& &r&cannot regenerate health&!&, so be careful!]], initWandsIcons)

caster:setLoadoutSkill(1, "Grandpa's Old Wand",
[[Simple but accurate and reliable wand. Shoots one of two magical bullets
that deal &y&100% damage&!& each.]])

caster:setLoadoutSkill(2, "Big Boom",
[[Slow and limited, but powerful. Throws a bomb that deals &y&600% damage&!& on explosion.
Limited to &y&3 bombs&!& per level.]])

caster:setLoadoutSkill(3, "Empty Slot",
[[Pick up a new wand to fill this slot!]])

caster:setLoadoutSkill(4, "Empty Slot",
[[Pick up a new wand to fill this slot!]])

caster.loadoutColor = Color(0xA31FA1)

caster.loadoutSprite = sprites[1].select

caster.titleSprite = sprites[1].walk

caster.endingQuote = "..and so it left, probably angering the gods along the way."

--==== character details ====--
function resetSkillDescriptions(player)
    playerData = player:getData()
    for i = 1, 4 do
        -- you dont need to display anything else other than the icon since we're not gonna be using that
        player:setSkill(i,
        "", --getWandName(playerData.wands[i]),
        "", --getWandDetails(playerData.wands[i]),
        getWandIcon(playerData.wands[i]), 1,
        0 --getWandCooldown(playerData.wands[i]) -- 0
        )
    end
end

caster:addCallback("init", function(player)
    -- for debugging
    if DEBUG_MODE then
        player:set("true_invincible", 1)
    end
    
    playerData = player:getData()
    playerData.wands = getInitialWands()
    playerData.selectedWand = 1
    playerData.inventory = {}
    for i = 1, 16 do
        table.insert(playerData.inventory, 0)
    end
    playerData.maxFuel = CONST_MAX_FLY_FUEL
    playerData.fuel = CONST_MAX_FLY_FUEL
    playerData.fuelCooldown = 0
    playerData.openInventory = false
    playerData.editor = {}
    playerData.lastCursorIndex = {inv = 1, wandPick = 1, options = 1} -- controllers only
    playerData.pickWand = nil
    playerData.openOptions = false
    
    -- avoid firing as soon as game start is clicked
    playerData.preventFire = 1
    
    playerData.colors = savedColors
	player:setAnimations(sprites[getPlayerIndex(player)])
    
	player:survivorSetInitialStats(100, 14, 0) -- 100 hp, 14 base dmg, 0 hp regen
    player:set("pVmax", 0) -- no jumping
    
    resetSkillDescriptions(player)
    
    -- send your colors to others
    if net.online then
        if net.host then
            packets.casterSetSprite:sendAsHost(net.ALL, nil, player:getNetIdentity(), serializeColors(player))
        else
            packets.casterSetSprite:sendAsClient(player:getNetIdentity(), serializeColors(player))
        end
    end
end)

caster:addCallback("levelUp", function(player)
	player:survivorLevelUpStats(20, 4, 0, 5) -- +20 hp, +4 dmg, +0 hp regen, +5 armor
end)

--==== select wand with skills ====--
caster:addCallback("useSkill", function(player, skill)
    -- Artifact of Distortion wont let you pick skills, sad
    local distortion = Artifact.find("Distortion").active
    if input.getPlayerGamepad(player) == nil then
        playerData = player:getData()
        if type(playerData.wands[skill]) == "table" and (not distortion or
          (distortion and player:get("artifact_lock_choice") + 1 ~= skill)) then -- if slot isnt empty nor locked
            --if player:get("activity") == 0 then
            playerData.selectedWand = skill
            --end
        end
    end
end)

--==== draw wand bars ====--
caster:addCallback("draw", function(player)
    playerData = player:getData()
    
    -- draw wand mana, wand cooldown and flight fuel
    local wand = nil
    if playerData.selectedWand > 0 then
        wand = playerData.wands[playerData.selectedWand]
    end
    -- TODO: should this be seen by other players?
    -- if not net.online or (net.online and net.localPlayer == player) then
    local drawX, drawY = player.x - math.floor(hud.totalLength / 2), player.y + hud.drawHeight
    for i = 1, 3 do
        -- no wand available
        if playerData.selectedWand <= 0 and i < 3 then
            break
        end
        local current, max = 0, 0
        if i == 1 and type(wand) == "table" then
            current, max = wand.cooldown, 60 * wand.stats.rechargeTime
        elseif i == 2 and type(wand) == "table" then
            current, max = wand.mana, wand.stats.manaMax
        else
            current, max = playerData.fuel, playerData.maxFuel
        end
        if i == 1 and current > 0 or i ~= 1 and current < max then
            local filledBarLength = current / max
            if i == 1 then
                filledBarLength = 1 - filledBarLength -- cooldown is done backwards
            end
            
            -- draw icon
            hud[i].icon:draw(drawX, drawY)
            
            -- draw bar
            local prevColor = graphics.getColor()
            for j = 1, 2 do
                graphics.color(j == 1 and hud.fillColor or hud.borderColor)
                graphics.rectangle(
                    drawX + hud[i].icon.width + hud.iconBarSpacing,
                    drawY,
                    drawX + hud[i].icon.width + hud.iconBarSpacing + (hud.barLength + 1),
                    drawY + (hud.barHeight + 1),
                    j == 2
                )
            end
            graphics.color(hud[i].color)
            graphics.rectangle(
                drawX + hud[i].icon.width + (hud.iconBarSpacing + 1),
                drawY + 1,
                drawX + hud[i].icon.width + hud.iconBarSpacing + (hud.barLength * filledBarLength),
                drawY + hud.barHeight
            )
            graphics.color(prevColor)
            
            -- increment draw height
            drawY = drawY + hud.drawStep
        end
    end
    -- end
end)

local function printItemPopup(player, thingInst, dataString)
    local thingData = thingInst:getData()
    local thing = thingData[dataString]
    drawInfoPopup(
        thingInst.x - graphics.textWidth(thing.name, graphics.FONT_DEFAULT) / 2,
        thingInst.y - 20,
        thing, player, "shop"
    )
    local t1 = "Press"
    local t2 = " '" .. input.getControlString("enter", player) .. "'"
    local t3 = " to " .. (thingData.shop > 0 and "purchase" or "pick up") .. " " .. dataString
    local t4 = thingData.shop > 0 and (" ($" .. thingData.shop .. ")") or ""
    local tLen = graphics.textWidth(t1..t2..t3..t4, graphics.FONT_DEFAULT)
    graphics.color(Color.WHITE)
    graphics.print(t1, player.x - tLen / 2, player.y - 40)
    graphics.color(Color.ROR_YELLOW)
    graphics.print(t2, player.x - tLen / 2 + graphics.textWidth(t1, graphics.FONT_DEFAULT), player.y - 40)
    graphics.color(Color.WHITE)
    graphics.print(t3, player.x - tLen / 2 + graphics.textWidth(t1..t2, graphics.FONT_DEFAULT), player.y - 40)
    graphics.color(Color.ROR_YELLOW)
    graphics.print(t4, player.x - tLen / 2 + graphics.textWidth(t1..t2..t3, graphics.FONT_DEFAULT), player.y - 40)
end

local function hasFreeSpellSlot(player)
    playerData = player:getData()
    local inv = playerData.inventory
    for i = 5, #inv do
        if type(inv[i]) ~= "table" then
            return true
        end
    end
    return false
end

local function addNewSpell(player, spell)
    playerData = player:getData()
    local inv = playerData.inventory
    for i = 1, #inv do
        if type(inv[i]) ~= "table" then
            playerData.inventory[i] = spell
            break
        end
    end
end

function dropHeldThing(player, playerData, heldIndex, heldSpell)
    local thing = 0
    local isWand = false
    if heldIndex >= 5 then
        -- inventory
        thing, playerData.inventory[heldIndex-4] = playerData.inventory[heldIndex-4], thing
    elseif heldSpell ~= 0 then
        -- wand spells
        thing, playerData.wands[heldIndex].spells[heldSpell] = playerData.wands[heldIndex].spells[heldSpell], thing
        
        -- reset wand stuff (TODO: this will skip some spells from being fired, but is it really that important?)
        resetFiredSpells(playerData.wands[heldIndex])
        selectNewSpell(playerData.wands[heldIndex])--, #playerData.wands[heldIndex].spells)
    else
        -- wands
        thing, playerData.wands[heldIndex] = playerData.wands[heldIndex], thing
        isWand = true
        -- fix wand icon on hotbar
        resetSkillDescriptions(player)
    end
    if isWand then
        local _, angle = spawnWandObject(thing, player.x, player.y)
        if net.host then
            packets.spawnWandObject:sendAsHost(net.ALL, nil, player.x, player.y, angle, serializeWand(thing))
        else
            packets.spawnWandObject:sendAsClient(player.x, player.y, angle, serializeWand(thing))
        end
        -- if dropped wand was the selected one, select another one
        if playerData.selectedWand == heldIndex then
            while playerData.wands[playerData.selectedWand] == 0 do
                playerData.selectedWand = playerData.selectedWand % 4 + 1
                if playerData.selectedWand == heldIndex then
                    -- gone all the way around; no wands available
                    playerData.selectedWand = -1
                end
            end
        end
    else
        spawnSpellObject(thing, player.x, player.y - player.sprite.yorigin)
        if net.host then
            packets.spawnSpellObject:sendAsHost(net.ALL, nil, player.x, player.y - player.sprite.yorigin, serializeSpell(thing))
        else
            packets.spawnSpellObject:sendAsClient(player.x, player.y - player.sprite.yorigin, serializeSpell(thing))
        end
    end
    
    getSound("inv", "item_remove"):play()
    playerData.editor.heldThing = 0
end

caster:addCallback("draw", function(player)
    playerData = player:getData()
    -- only drawn client-side
    if not net.online or (net.online and net.localPlayer == player) then
        --==== draw wand/spell objects ====--
        if not playerData.openInventory and playerData.pickWand == nil and not playerData.openOptions then
            local wandInst = wandObj:findNearest(player.x, player.y)
            local spellInst = spellObj:findNearest(player.x, player.y)
            if wandInst ~= nil and wandInst:isValid() and not wandInst:getData().beingPicked and withinPickupRange(player, wandInst) then
                printItemPopup(player, wandInst, "wand")
            elseif spellInst ~= nil and spellInst:isValid() and withinPickupRange(player, spellInst) then
                printItemPopup(player, spellInst, "spell")
            end
        end
    end
    --==== draw thonk bubbles ====--
    -- TODO: is it really worth syncing this to display fancy image?
    if playerData.openInventory or playerData.openOptions then
        graphics.drawImage{
            hud.inventoryIcon,
            player.x, player.y - 20
        }
    elseif playerData.pickWand ~= nil then
        graphics.drawImage{
            hud.pickingWandIcon,
            player.x, player.y - 20
        }
    end
end)
-- caster:addCallback("draw", function(player)
    -- graphics.print("activity: " .. player:get("activity_type"), player.x, player.y - 5)
-- end)

--==== hovering over skill slots ====--
registercallback("preHUDDraw", function()
    player = net.online and net.localPlayer or misc.players[1]
    if player:getSurvivor() == caster then
        local infoIndex = misc.hud:get("info_index")
        if infoIndex ~= -1 then
            playerData = player:getData()
            hudData = misc.hud:getData()
            if playerData.pickWand == nil and not playerData.openOptions then
                -- display hovered over wand on skill slots
                if type(player:getData().wands[infoIndex + 1]) == "table" then
                    local mouseX, mouseY = input.getMousePos(true)
                    drawInfoPopup(mouseX, mouseY, playerData.wands[infoIndex + 1], player, "hotbar")
                end
            end
            
            -- store current index
            hudData["saved_info_index"] = infoIndex
            
            -- set it to -1 to avoid displaying text
            misc.hud:set("info_index", -1)
        end
    end
end)
registercallback("onHUDDraw", function()
    local hudData = misc.hud:getData()
    -- restore index
    if hudData["saved_info_index"] ~= nil then
        misc.hud:set("info_index", hudData["saved_info_index"])
        hudData["saved_info_index"] = nil
    end
end, -5000)

--==== turning player ====--
registercallback("postStep", function()
    for _, player in ipairs(misc.players) do
        if player:getSurvivor() == caster then
            local mouseX, _ = controlStatus.mouse(input.getPlayerGamepad(player), player)
            player.xscale = ((mouseX < player.x) and -1 or 1)
        end
    end
end)

debugDone = false
caster:addCallback("step", function(player)
    -- -- for debugging
    if DEBUG_MODE and not debugDone then
        local tp = Object.find("Teleporter"):find(1)
        tp:set("active", 3)
        player.x, player.y = tp.x, tp.y - 10
        debugDone = true
    end
    
    playerData = player:getData()
    local gamepad = input.getPlayerGamepad(player)
    
    --==== deal with Artifact of Distortion ====--
    local distortion = Artifact.find("Distortion").active
    if distortion then
        -- make sure locked slot has a wand
        local lockedSkill = player:get("artifact_lock_choice") + 1
        local wands = {}
        for index, wand in ipairs(playerData.wands) do
            if type(wand) == "table" then
                wands[#wands+1] = index
            end
        end
        if #wands <= 1 then
            -- too few wands means no locked skills
            player:set("artifact_lock_choice", 4) -- might throw error
        elseif type(playerData.wands[lockedSkill]) ~= "table" then
            player:set("artifact_lock_choice", table.random(wands) - 1)
        end
        -- make sure selected wand isnt locked
        lockedSkill = player:get("artifact_lock_choice") + 1
        if playerData.selectedWand == lockedSkill then
            -- pick the first non-locked wand
            playerData.selectedWand = lockedSkill == 1 and 2 or 1
        end
    end

    --==== flight management ====--
    -- only use magic flying powers if Photon Jetpack is done doing its thing
    local jetpackFuelLeft = player:countItem(Item.find("Photon Jetpack")) > 0 and player:get("jetpack_fuel") > 0
    if not jetpackFuelLeft and player:get("activity") ~= 30 and player:get("moveUpHold") == 1 and playerData.fuel > 0 and not playerData.openOptions then
        playerData.fuel = math.max(playerData.fuel - 1, 0)
        player:set("pVspeed", player:get("pVspeed") == 0 and CONST_FLY_SPEED_START or math.min(player:get("pVspeed") * (1 + CONST_FLY_SPEED_STEP), CONST_FLY_SPEED_MAX))
        playerData.fuelCooldown = CONST_FUEL_COOLDOWN
        
        if misc.getOption("video.quality") == 3 then
            local dust = ParticleType.find("Smoke2", "vanilla")
            dust:life(10, 15)                                                       -- 10 to 15 frames of lifespan
            dust:color(Color.fromRGB(184, 130, 86), Color.fromRGB(74, 65, 58))      -- from light brown to brown
            dust:alpha(1, 0)
            dust:gravity(0.05, 270)                                                 -- falling down slowly
            dust:burst("below", player.x, player.y, math.random(1,3))
        end
    end
    if player:get("moveUpHold") == 0 then
        playerData.fuelCooldown = math.max(playerData.fuelCooldown - 1, 0)
    end
    if playerData.fuelCooldown == 0 then
        playerData.fuel = math.min(playerData.fuel + 1, playerData.maxFuel)
    end

    local teleporting = player:get("activity") == 99

    --==== wand functions ====--
    local skill = playerData.selectedWand
    if skill > 0 and not playerData.openOptions and player:get("dead") == 0 and not teleporting then
        --==== shooting wand ====--
        local selectedWand = playerData.wands[skill]
        if player:get("activity") == 0 and playerData.preventFire == 0 and type(selectedWand) == "table" then -- and not isWandEmpty(selectedWand) then
            if controlStatus.fire(gamepad) == input.PRESSED then
                if isWandEmpty(selectedWand) then
                    getSound("wand", "shooting_empty_wand"):play()
                elseif wandOnCooldown(selectedWand) then
                    getSound("wand", "recharging"):play()
                elseif not wandHasManaForSpell(selectedWand) then
                    getSound("wand", "not_enough_mana_for_action"):play()
                end
            end
            if controlStatus.fire(gamepad) == input.HELD and not isWandEmpty(selectedWand) then
                if not wandOnSpellDelay(selectedWand) and not wandOnCooldown(selectedWand) and wandHasManaForSpell(selectedWand) then
                    --shootWand(player, selectedWand, player.x, player.y, controlStatus.mouse(gamepad, player))
                    local targetX, targetY = controlStatus.mouse(gamepad, player)
                    shootWand(player, selectedWand, player.x, player.y, targetX, targetY)
                    if net.host then
                        packets.shootWand:sendAsHost(net.ALL, nil, player:getNetIdentity(), player.x, player.y, targetX, targetY, serializeWand(selectedWand))
                    else
                        packets.shootWand:sendAsClient(player:getNetIdentity(), player.x, player.y, targetX, targetY, serializeWand(selectedWand))
                    end
                    --resetSkillDescriptions(player)
                end
            end
        end
        
        --==== wand step ====--
        wandStep(playerData.wands[skill])
        
        --==== scrolling through wands ====--
        local scroll = controlStatus.scroll(gamepad)
        if scroll ~= 0 then
            for i = 1, 3 do
                skill = ((skill - 1 + scroll) % 4) + 1
                -- if slot isnt empty nor locked
                if type(playerData.wands[skill]) == "table"
                  and (not distortion or (distortion and player:get("artifact_lock_choice") + 1 ~= skill)) then 
                    playerData.selectedWand = skill
                    break
                end
            end
        end
    end
    
    -- deal with wand fire blocking
    if playerData.preventFire > 0 then
        playerData.preventFire = playerData.preventFire - 1
        -- prevent instant firing afterwards by holding the fire button
        if playerData.preventFire == 0 and controlStatus.fire(gamepad) == input.HELD then
            playerData.preventFire = 1
        end
    end
    
    -- client-side only code
    if not net.online or (net.online and net.localPlayer == player) and not teleporting then
        --==== opening inventory ====--
        if (controlStatus.inventory(gamepad) == input.PRESSED
          or playerData.openInventory and controlStatus.escape(gamepad) == input.PRESSED)
          and playerData.pickWand == nil and not playerData.openOptions and player:get("dead") == 0 then
            playerData.openInventory = not playerData.openInventory
            if playerData.openInventory then
                playerData.editor = {
                    currentlyEditing = spriteParts[1],
                    shading = playerData.colors.shading,
                    
                    -- currently held wand/spell, for display and switching purposes
                    heldThing = 0,
                    wasOverHeldSpot = false
                }
                for _, part in ipairs(spriteParts) do
                    playerData.editor[part] = {}
                    for _, color in ipairs(hsv) do
                        playerData.editor[part][color] = playerData.colors[part][color]
                    end
                end
                player:set("activity", CONST_INVENTORY_ACTIVITY)
                getSound("inv", "inventory_open"):play()
            else
                -- before closing, drop any held things
                if playerData.editor.heldThing ~= 0 then
                    local heldIndex = roundNumber(math.floor(playerData.editor.heldThing), 0)
                    local heldSpell = roundNumber((playerData.editor.heldThing - heldIndex) * 10, 0)
                    dropHeldThing(player, playerData, heldIndex, heldSpell)
                end
                playerData.editor = {}
                player:set("activity", 0)
                getSound("inv", "inventory_close"):play()
            end
        end
        
        --==== picking up wands ====--
        local wandInst = wandObj:findNearest(player.x, player.y)
        if wandInst ~= nil and withinPickupRange(player, wandInst) and playerData.pickWand == nil and player:get("dead") == 0 then
            if wandInst:isValid() then
                wandData = wandInst:getData()
                if wandData.owner == nil and input.checkControl("enter") == input.PRESSED
                  and not wandData.beingPicked and not playerData.openInventory and not playerData.openOptions then
                    if misc.getGold() < wandData.shop then
                        Sound.find("Error"):play()
                    else
                        -- entering wand picking
                        playerData.pickWand = wandInst
                        playerData.lastCursorIndex.wandPick = 1
                        wandData.beingPicked = true
                        if net.host then
                            packets.lockWandObject:sendAsHost(net.ALL, nil, true, wandData.id)
                        else
                            packets.lockWandObject:sendAsClient(true, wandData.id)
                        end
                        player:set("activity", CONST_WAND_PICKING_ACTIVITY):set("activity_type", 3)
                    end
                end
            end
        end
        -- close wand pick dialogue
        if playerData.pickWand ~= nil and controlStatus.escape(gamepad) == input.PRESSED then
            player:set("activity", 0):set("activity_type", 0)
            wandData = playerData.pickWand:getData()
            wandData.beingPicked = false
            if net.host then
                packets.lockWandObject:sendAsHost(net.ALL, nil, false, wandData.id)
            else
                packets.lockWandObject:sendAsClient(false, wandData.id)
            end
            playerData.pickWand = nil
        end
        
        --==== picking up spells ====--
        local spellInst = spellObj:findNearest(player.x, player.y)
        if spellInst ~= nil and withinPickupRange(player, spellInst) and player:get("dead") == 0 then
            if spellInst:isValid() then
                spellData = spellInst:getData()
                if input.checkControl("enter") == input.PRESSED and not playerData.openInventory
                  and not playerData.pickWand and not playerData.openOptions then
                    local currGold = misc.getGold()
                    if currGold < spellData.shop then
                        Sound.find("Error"):play()
                    elseif not hasFreeSpellSlot(player) then
                        -- TODO: idk, different sound or smth
                        Sound.find("Error"):play()
                    else
                        if spellData.shop > 0 then
                            misc.setGold(currGold - spellData.shop)
                            getSound("player", "shop"):play()
                        else
                            getSound("player", "pickup", "generic"):play()
                        end
                        addNewSpell(player, spellData.spell)
                        
                        if net.host then
                            packets.destroySpellObject:sendAsHost(net.ALL, nil, spellData.id)
                        else
                            packets.destroySpellObject:sendAsClient(spellData.id)
                        end
                        spellInst:destroy()
                    end
                end
            end
        end
        
        --==== deal with option menu ====--
        if playerData.openOptions then
            if player:get("activity") ~= CONST_GAMEPAD_OPTIONS_ACTIVITY then
                player:set("activity", CONST_GAMEPAD_OPTIONS_ACTIVITY):set("activity_type", 1)
            end
            -- if singleplayer, pause the game
            if not net.online then
                misc.setTimeStop(2)
                local watchSound = Sound.find("Watch")
                if watchSound:isPlaying() then
                    watchSound:stop()
                end
            end
            -- pressing escape exits out
            if controlStatus.escape(gamepad) == input.PRESSED then
                playerData.openOptions = false
                player:set("activity", 0):set("activity_type", 2)
            end
        end
    end
end)

--==== on death ====--
registercallback("onPlayerDeath", function(player)
    if player:getSurvivor() == caster then
        getSound("player", "death"):play()
        playerData = player:getData()
        playerData.openInventory = false
        if playerData.pickWand ~= nil then
            wandData = playerData.pickWand:getData()
            wandData.beingPicked = false
            if net.host then
                packets.lockWandObject:sendAsHost(net.ALL, nil, false, wandData.id)
            else
                packets.lockWandObject:sendAsClient(false, wandData.id)
            end
            playerData.pickWand = nil
        end
        playerData.openOptions = false
        player:set("activity", 0):set("activity_type", 0)
        
        player:setAnimation("death", sprites[getPlayerIndex(player)].idle)
    end
end)

-- deal with death sprite effect
local deadSpinList = {}
registercallback("onStageEntry", function()
    -- reset dead bois list
    deadSpinList = {}
end, 5000)
-- add fresh meat back to the menu
Object.find("EfPlayerDead"):addCallback("create", function(self)
    -- add it to *the spin list:tm:*
    deadSpinList[#deadSpinList + 1] = {self, -1}
end)
-- make dead bois invisible
registercallback("onDraw", function()
    for i = 1, #deadSpinList do
        if deadSpinList[i] ~= nil then
            local deadBodySpriteID = deadSpinList[i][1]:get("player_index")
            if deadSpinList[i][2] == -1 then
                -- first time
                for j = 1, #misc.players do
                    if sprites[j].idle.id == deadBodySpriteID then
                        deadSpinList[i][2] = j
                        break
                    end
                end
                if deadSpinList[i][2] == -1 then
                    -- none of us
                    deadSpinList[i] = nil
                else
                    -- one of us
                    deadSpinList[i][1].alpha = 0
                    deadSpinList[i][1].sprite = emptySprite
                end
            end
            if deadSpinList[i] ~= nil then
                local deadBody = deadSpinList[i][1]
                if not deadBody:isValid() then
                    deadSpinList[i] = nil
                else
                    deadBody.angle = deadBody.angle + deadBody:get("hspeed") * 10
                    graphics.drawImage{
                        Sprite.fromID(deadBodySpriteID),
                        deadBody.x, deadBody.y,
                        angle = deadBody.angle
                    }
                end
            end
        end
    end
end)

--==== draw wand ====--
local function casterDrawWand(player)
    playerData = player:getData()
    if player:get("dead") == 0 and playerData.selectedWand > 0 then
        local spriteTable = sprites[getPlayerIndex(player)]
        if spriteTable == nil then
            -- other player's sprites not loaded yet
            spriteTable = sprites[1]
        end
        -- get current animation
        local currAnim = nil
        for anim, spr in pairs(spriteTable) do
            if player.sprite == spr then
                currAnim = anim
                break
            end
        end
        if currAnim == nil or spritePieces[currAnim].handPos == nil then
            return
        end
        -- draw wand 
        local handOffset = spritePieces[currAnim].handPos[math.floor(player.subimage)]
        drawWand(
            playerData.wands[playerData.selectedWand],
            {
                player.x - player.sprite.xorigin + handOffset[1],
                player.y - player.sprite.yorigin + handOffset[2]
            },
            {controlStatus.mouse(input.getPlayerGamepad(player), player)}
        )
        -- draw hand over wand
        if player:getFacingDirection() == 0 then
            local baseColors = graphics.getColor()
            graphics.color(skinColor)
            graphics.pixel(
                player.x - player.sprite.xorigin + handOffset[1],
                player.y - player.sprite.yorigin + handOffset[2]
            )
            graphics.color(baseColors)
        end
    end
end

registercallback("onPlayerDrawAbove", function(player)
    if player:getSurvivor() == caster and player:get("activity") ~= 30
      and player:get("dead") == 0 and player:getFacingDirection() == 0 then
        casterDrawWand(player)
    end
end)

registercallback("onPlayerDrawBelow", function(player)
    if player:getSurvivor() == caster and player:get("activity") ~= 30
      and player:get("dead") == 0 and player:getFacingDirection() == 180 then
        casterDrawWand(player)
    end
end)

--==== highlight selected wand ====--
registercallback("onPlayerHUDDraw", function(player, x, y)
    if not net.online or (net.online and net.localPlayer == player) then
        if player:getSurvivor() == caster then
            playerData = player:getData()
            if playerData.selectedWand > 0 then
                local iconX = x + (playerData.selectedWand - 1) * 23 -- skills are spaced 23px apart (from corner to corner)
                local currColor = graphics.getColor()
                graphics.color(Color.ROR_YELLOW)
                graphics.rectangle(iconX - 1, y - 1, iconX + 17 + 1, y + 17 + 1, true)
                graphics.color(currColor)
            end
        end
    end
end)

--==== deal with use items, scepter, etc ====--
require("src/caster_items")