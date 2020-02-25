-- made by Uziskull

invHUD = {
    totalInvLength = 555,                       HUDDeltaYBetweenWands = 5,                      HUDCornerToTitleX = 5,
    totalInvHeight = 255,                       HUDDeltaXBetweenWindows = 15,                   HUDCornerToTitleY = 15,
    HUDSpellsSize = 20,
    
    wandHUDLength = 187,                        wandHUDCornerToSpriteX = 3,
    wandHUDHeight = 60,                         wandHUDCornerToSpriteY = 25 - 3,
    wandHUDCornerToTextX = 52,                  wandHUDCornerToSpellsX = 3,              
    wandHUDCornerToTextY = 24,                  wandHUDCornerToSpellsY = 37,
    wandHUDTextDeltaX = 78,                     wandHUDSpellsDelta = 3,
    wandHUDTextDeltaY = 8,
    
    invHUDLength = 187,                         invHUDCornerToSpellsX = 3,                      invHUDSpellsDeltaX = 3,
    invHUDHeight = 63,                          invHUDCornerToSpellsY = 18,                     invHUDSpellsDeltaY = 2,
    
    --colorHUDLength = 151,
    --colorHUDHeight = 124,
    colorHUDLength = 151,                       colorHUDCornerToTextX = 5,
    colorHUDHeight = 138,                       colorHUDCornerToTextY = 25,
    colorHUDCornerToColorX = 3,                 colorHUDColorDelta = 3,                         colorHUDColorBrightHeight = 6,
    colorHUDCornerToColorY = 29,                colorHUDColorSize = 66,
    --colorHUDCornerToApplyX = 20,
    --colorHUDCornerToApplyY = 111,
    colorHUDCornerToApplyX = 59,                colorHUDApplyLength = 33,
    colorHUDCornerToApplyY = 125,               colorHUDApplyHeight = 10,
    colorHUDCornerToColorButtonsX = 73,         colorHUDColorButtonsLength = 7,                 colorHUDColorButtonsDelta = 2,
    colorHUDCornerToColorButtonsY = 18,         colorHUDColorButtonsHeight = 33,
    colorHUDCornerToDisplayX = 82,              colorHUDDisplayLength = 66,
    colorHUDCornerToDisplayY = 18,              colorHUDDisplayHeight = 103,
    colorHUDCornerToShadingX = 3,               colorHUDShadingSize = 10,
    colorHUDCornerToShadingY = 111,             colorHUDShadingDelta = 3,
    
    optionsHUDExternalCornerToOptionsX = 116,   optionsHUDExternalCornerToOptionsY = 143,       optionsHUDExternalIconSize = 32,
    
    mouseHoverDistance = 10,
    
    popupInfoCornerToSpriteX = 125,             popupInfoCornerToDescX = 5,                     popupInfoIconToValueX = 78,
    popupInfoCornerToSpriteY = 3,               popupInfoCornerToDescY = 20,                    popupInfoIconSize = 7,
    popupInfoCornerToIconsX = 5,                popupInfoIconDeltaX = 4,                        popupInfoAlpha = 0.7,
    popupInfoCornerToIconsY = 36,               popupInfoIconDeltaY = 2,                        --popupInfoCornerToIconsY = 31,
    popupInfoCategorySpacing = 5,               popupInfoSpriteMaxWidth = 18,
    
    pickWandBoxLength = 190,                    pickWandBoxHeight = 155,
    pickWandDialogueLength = 350,               pickWandDialogueHeight = 25,
    
    warning = Sprite.load("caster_hud_warning", "spr/hud/warning", 1, 3, 3),
    
    paletteImg = Sprite.load("caster_hud_palette", "spr/hud/palette", 1, 0, 0),
    optionsIcon = Sprite.load("caster_hud_options", "spr/hud/options", 1, 0, 0),
    
}

local HUDicons = {
    icons = {
        shuffle = Sprite.load("caster_hud_icons_shuffle", "spr/hud/wandIcons/shuffle", 1, 0, 0),
        spellsCast = Sprite.load("caster_hud_icons_spellsCast", "spr/hud/wandIcons/spellsCast", 1, 0, 0),
        castDelay = Sprite.load("caster_hud_icons_castDelay", "spr/hud/wandIcons/castDelay", 1, 0, 0),
        rechargeTime = Sprite.load("caster_hud_icons_rechargeTime", "spr/hud/wandIcons/rechargeTime", 1, 0, 0),
        manaMax = Sprite.load("caster_hud_icons_manaMax", "spr/hud/wandIcons/manaMax", 1, 0, 0),
        manaChargeSpd = Sprite.load("caster_hud_icons_manaChargeSpd", "spr/hud/wandIcons/manaChargeSpd", 1, 0, 0),
        capacity = Sprite.load("caster_hud_icons_capacity", "spr/hud/wandIcons/capacity", 1, 0, 0),
        spread = Sprite.load("caster_hud_icons_spread", "spr/hud/wandIcons/spread", 1, 0, 0),
        type = Sprite.load("caster_hud_icons_type", "spr/hud/wandIcons/type", 1, 0, 0),
        count = Sprite.load("caster_hud_icons_count", "spr/hud/wandIcons/count", 1, 0, 0),
        damage = Sprite.load("caster_hud_icons_damage", "spr/hud/wandIcons/damage", 1, 0, 0),
        explosion = Sprite.load("caster_hud_icons_explosion", "spr/hud/wandIcons/explosion", 1, 0, 0),
        speed = Sprite.load("caster_hud_icons_speed", "spr/hud/wandIcons/speed", 1, 0, 0),
        weight = Sprite.load("caster_hud_icons_weight", "spr/hud/wandIcons/weight", 1, 0, 0),
        properties = Sprite.load("caster_hud_icons_properties", "spr/hud/wandIcons/properties", 1, 0, 0)
    },
    wands = {
        { stat = "shuffle", name = "Shuffle" },
        { stat = "spellsCast", name = "Spells/Cast" },
        { stat = "castDelay", name = "Cast delay" },
        { stat = "rechargeTime", name = "Rechrg. Time" },
        { stat = "manaMax", name = "Mana max" },
        { stat = "manaChargeSpd", name = "Mana chg.Spd" },
        { stat = "capacity", name = "Capacity" },
        { stat = "spread", name = "Spread" }
    },
    spells = {
        { stat = "type", name = "Type" },
        { stat = "count", name = "Uses remaining" }, -- note: spellsAffected is the modifier equivalent of count
            { stat = "break" },
        { stat = "manaCost", name = "Mana drain" },
            { stat = "breakModifiers" },
        { stat = "damage", name = "Damage" },
        { stat = "explosion", name = "Expl. Radius" },
        { stat = "degree", name = "Spread" },
        { stat = "speed", name = "Speed" },
        { stat = "weight", name = "Weight" },
            { stat = "break" },
        { stat = "castDelay", name = "Cast delay" },
        { stat = "rechargeTime", name = "Rechrg. Time" },
        
        { stat = "properties", name = "Properties" }
    }
}
HUDicons.icons.manaCost = HUDicons.icons.rechargeTime
HUDicons.icons.degree = HUDicons.icons.spread
HUDicons.icons.castDelay = HUDicons.icons.castDelay

--==== handle inventory ====--

function drawInfoPopup(x, y, thing, player, use)
    use = use or "inv"
    local surf = Surface.new(200, 400)
    graphics.setTarget(surf)
    local maxValueWidth = 0
    local maxHeight, deltaY = 0, 0
    
    graphics.color(Color.WHITE)
    local isSpell = thing.type ~= nil
    if isSpell then
        maxHeight = invHUD.popupInfoCornerToIconsY
        -- draw spell
        
        for _, details in ipairs(HUDicons.spells) do
            local stat, name = details.stat, details.name
            -- check for breaks, skips, etc
            if thing.type == spellType.MODIFIER and stat == "breakModifiers" then
                break
            elseif stat == "break" or stat == "breakModifiers" then
                deltaY = deltaY + invHUD.popupInfoCategorySpacing
            elseif stat == "count" and thing.type == spellType.MODIFIER then
                stat = "spellsAffected"
                name = "Spells affected"
            elseif not (thing.type == spellType.PROJECTILE and
              (stat == "count" and thing.count == -1 or stat == "explosion" and thing.explosion == nil))
              and not (stat == "properties" and #thing.properties == 0)
              and not (stat == "castDelay" and thing.castDelay ~= nil and thing.castDelay == 0)
              and not (stat == "rechargeTime" and thing.rechargeTime == 0) then
                -- draw icon
                HUDicons.icons[stat]:draw(
                    invHUD.popupInfoCornerToIconsX,
                    invHUD.popupInfoCornerToIconsY + deltaY
                )
                -- draw stat name
                graphics.print(
                    name,
                    invHUD.popupInfoCornerToIconsX + invHUD.popupInfoIconSize + invHUD.popupInfoIconDeltaX,
                    invHUD.popupInfoCornerToIconsY + deltaY,
                    graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_TOP
                )
                -- get stat value, deal with exceptions, add extras
                local value = nil
                if stat == "type" then
                    value = thing[stat] == spellType.PROJECTILE and "Projectile" or "Modifier"
                elseif stat == "damage" then
                    value = {(thing[stat] * 100) .. "%", math.floor(thing[stat] * player:get("damage"))}
                elseif stat == "explosion" then
                    value = thing.explosion[1] .. "x" .. thing.explosion[2]
                elseif stat == "castDelay" then
                    -- TODO: make this print with always two decimal cases (something something %f.2)
                    if thing[stat] == nil then 
                        value = "=0 s"
                    else
                        value = thing[stat] .. " s"
                    end
                elseif stat == "rechargeTime" then
                    -- TODO: make this print with always two decimal cases (something something %f.2)
                    value = thing[stat] .. " s" 
                elseif stat == "degree" then
                    value = thing[stat] .. " DEG"
                elseif stat == "properties" then
                    for prop, _ in pairs(thing.properties) do
                        value = value == nil and prop or (value .. ", " .. prop)
                    end
                else
                    value = thing[stat]
                end
                -- draw stat value
                if stat == "damage" then
                    graphics.printColor(
                        "&w&" .. value[1] .. "&!&  &r&(" .. value[2] .. ")&!&",
                        invHUD.popupInfoCornerToIconsX + invHUD.popupInfoIconToValueX,
                        invHUD.popupInfoCornerToIconsY + deltaY,
                        graphics.FONT_SMALL
                    )
                    value = value[1] .. "  (" .. value[2] .. ")"
                else
                    graphics.print(
                        value,
                        invHUD.popupInfoCornerToIconsX + invHUD.popupInfoIconToValueX,
                        invHUD.popupInfoCornerToIconsY + deltaY,
                        graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_TOP
                    )
                end
                -- increase max value width if bigger
                maxValueWidth = math.max(graphics.textWidth(value .. "", graphics.FONT_SMALL), maxValueWidth)
                -- increment delta
                deltaY = deltaY + invHUD.popupInfoIconSize + invHUD.popupInfoIconDeltaY
            end
        end
        
        -- draw short spell description
        maxValueWidth = maxValueWidth + 10
        local strLen = math.floor((invHUD.popupInfoCornerToIconsX + invHUD.popupInfoIconToValueX
            + maxValueWidth - invHUD.popupInfoCornerToDescX) / 4.69) -- average character pixel size (heh)
        local char = thing.desc:sub(strLen, strLen)
        while char ~= "" and char ~= " " do
            strLen = strLen - 1
            char = thing.desc:sub(strLen, strLen)
        end
        local descParts = {
            thing.desc:sub(1, strLen),
            thing.desc:sub(strLen + 1)
        }
        for i = 1, 2 do
            graphics.print(
                descParts[i],
                invHUD.popupInfoCornerToDescX,
                invHUD.popupInfoCornerToDescY + (i - 1) * 6,
                graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
            )
        end
    else
        maxHeight = invHUD.popupInfoCornerToDescY
        -- draw wand
        
        -- draw the name later, to be able to use max width to cut off text
        for _, details in ipairs(HUDicons.wands) do
            local stat, name = details.stat, details.name
            -- draw icon
            HUDicons.icons[stat]:draw(
                invHUD.popupInfoCornerToIconsX,
                invHUD.popupInfoCornerToDescY + deltaY
            )
            -- draw stat name
            graphics.print(
                name,
                invHUD.popupInfoCornerToIconsX + invHUD.popupInfoIconSize + invHUD.popupInfoIconDeltaX,
                invHUD.popupInfoCornerToDescY + deltaY,
                graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_TOP
            )
            -- get stat value, deal with exceptions, add extras
            local value = nil
            if stat == "shuffle" then
                value = thing.stats[stat] and "Yes" or "No"
            elseif stat == "castDelay" then
                value = thing.stats[stat] .. " s"
            elseif stat == "rechargeTime" then
                value = {thing.stats[stat] .. " s", roundNumber(thing.stats[stat] * ( 1 / player:get("attack_speed") ), 2) .. " s"}
            elseif stat == "capacity" then
                value = #thing.spells
            elseif stat == "spread" then
                value = thing.stats[stat] .. " DEG"
            else
                value = thing.stats[stat]
            end
            -- draw stat value
            if stat == "rechargeTime" then
                graphics.printColor(
                    "&w&" .. value[1] .. "&!&  &y&(" .. value[2] .. ")&!&",
                    invHUD.popupInfoCornerToIconsX + invHUD.popupInfoIconToValueX,
                    invHUD.popupInfoCornerToDescY + deltaY,
                    graphics.FONT_SMALL
                )
                value = value[1] .. "  (" .. value[2] .. ")"
            else
                graphics.print(
                    value,
                    invHUD.popupInfoCornerToIconsX + invHUD.popupInfoIconToValueX,
                    invHUD.popupInfoCornerToDescY + deltaY,
                    graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_TOP
                )
            end
            -- increase max value width if bigger
            maxValueWidth = math.max(graphics.textWidth(value .. "", graphics.FONT_SMALL), maxValueWidth)
            -- increment delta
            deltaY = deltaY + invHUD.popupInfoIconSize + invHUD.popupInfoIconDeltaY
        end
        local spellDeltaX = 0
        for _, spell in ipairs(thing.spells) do
            if type(spell) == "table" then
                spell.sprites.icon:draw(
                    invHUD.popupInfoCornerToIconsX + spellDeltaX,
                    invHUD.popupInfoCornerToDescY + deltaY
                )
                spellDeltaX = spellDeltaX + invHUD.HUDSpellsSize + invHUD.wandHUDSpellsDelta
            end
        end
        deltaY = deltaY + invHUD.HUDSpellsSize + 2
    end
    
    local maxWidth = invHUD.popupInfoCornerToIconsX + invHUD.popupInfoIconToValueX + maxValueWidth + 2
    maxHeight = maxHeight + deltaY + 2 -- small spacing at the end
    
    local sprite = isSpell and thing.sprites.icon or thing.graphics.sprite
    local scale = invHUD.popupInfoSpriteMaxWidth / (isSpell and sprite.width or sprite.height)
    local spriteWidth = (isSpell and sprite.width or sprite.height) * scale
    local spriteHeight = (isSpell and sprite.height or sprite.width) * scale
    if use ~= "choice" then
        -- draw wand vertically
        graphics.drawImage{
            sprite,
            isSpell and maxWidth or (maxWidth + spriteWidth / 2),
            maxHeight / 2 + (isSpell and -1 or 1) * spriteHeight / 2,
            scale = scale,
            angle = isSpell and 0 or 90
        }
    else
        -- draw wand horizontally
        graphics.drawImage{
            sprite,
            invHUD.pickWandBoxLength / 2 - spriteHeight / 2,
            invHUD.pickWandBoxHeight - 3 * scale - spriteWidth / 2,
            scale = scale,
            angle = 0
        }
    end
    
    maxWidth = maxWidth + spriteWidth + 4
    
    -- draw wand name to new surface
    graphics.color(Color.WHITE)
    local textSurf = Surface.new(
        use == "choice" and invHUD.pickWandBoxLength or maxWidth,
        invHUD.popupInfoCornerToIconsY - invHUD.HUDCornerToTitleY
    )
    graphics.setTarget(textSurf)
    graphics.print(
        thing.name,
        invHUD.HUDCornerToTitleX, textSurf.height - 1,
        graphics.FONT_DEFAULT, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
    )
    -- erase final part of the text
    graphics.setBlendMode("subtract")
    graphics.color(Color.BLACK)
    graphics.alpha(0.2)
    for i = 10, 2, -2 do
        graphics.rectangle(textSurf.width - i, 0, textSurf.width, textSurf.height)
    end
    graphics.setBlendMode("normal")
    graphics.color(Color.WHITE)
    graphics.alpha(1)
    
    -- draw text surface to current surface
    graphics.setTarget(surf)
    textSurf:draw(0, invHUD.HUDCornerToTitleY - textSurf.height)
    textSurf:clear()
    textSurf:free()
    
    graphics.resetTarget()
    
    
    -- draw background
    if use ~= "choice" then
        graphics.alpha(invHUD.popupInfoAlpha)
        graphics.color(hud.fillColor)
        graphics.rectangle(x, y, x + maxWidth - 1, y + (use == "hotbar" and -(maxHeight - 1) or maxHeight - 1))
        graphics.alpha(1)
    end
    -- draw border
    graphics.color(hud.borderColor)
    local drawY = (use == "choice" and invHUD.pickWandBoxHeight or maxHeight) - 1
    graphics.rectangle(
        x, y,
        x + (use == "choice" and invHUD.pickWandBoxLength or maxWidth) - 1,
        y + (use == "hotbar" and -drawY or drawY),
        true
    )
    -- draw content
    surf:draw(x + 1, use == "hotbar" and y - maxHeight + 1 or y + 1)
    surf:clear()
    surf:free()
end

local function HUDDrawWands(x, y, playerData, cursorIndex, canSpellSwap, lockedWand)
    local wands, selectedWand = playerData.wands, playerData.selectedWand
    local alreadyHighlighted = false
    for wandIndex, wand in ipairs(wands) do
        if type(wand) == "table" then
            
            if playerData.editor.heldThing == wandIndex then
                graphics.alpha(0.5)
            end
            
            -- draw background
            graphics.color(hud.fillColor)
            graphics.rectangle(x, y, x + invHUD.wandHUDLength - 1, y + invHUD.wandHUDHeight - 1)
            -- draw border
            graphics.color(selectedWand == wandIndex and Color.ROR_YELLOW or hud.borderColor)
            graphics.rectangle(x, y, x + invHUD.wandHUDLength - 1, y + invHUD.wandHUDHeight - 1, true)
            -- draw wand name
            graphics.color(Color.WHITE)
            graphics.print(
                wand.name,
                x + invHUD.HUDCornerToTitleX,
                y + invHUD.HUDCornerToTitleY,
                graphics.FONT_DEFAULT, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
            )
            -- draw wand sprite
            graphics.drawImage{
                wand.graphics.sprite,
                x + invHUD.wandHUDCornerToSpriteX,
                y + invHUD.wandHUDCornerToSpriteY,
                scale = 3,
                alpha = playerData.editor.heldThing == wandIndex and 0.5 or 1
            }
            -- draw short info text
            graphics.print(
                "Shuffle",
                x + invHUD.wandHUDCornerToTextX,
                y + invHUD.wandHUDCornerToTextY,
                graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
            )
            graphics.print(
                wand.stats.shuffle and "Yes" or "No",
                x + invHUD.wandHUDCornerToTextX + invHUD.wandHUDTextDeltaX,
                y + invHUD.wandHUDCornerToTextY,
                graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
            )
            graphics.print(
                "Spells/Cast",
                x + invHUD.wandHUDCornerToTextX,
                y + invHUD.wandHUDCornerToTextY + invHUD.wandHUDTextDeltaY,
                graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
            )
            graphics.print(
                wand.stats.spellsCast,
                x + invHUD.wandHUDCornerToTextX + invHUD.wandHUDTextDeltaX,
                y + invHUD.wandHUDCornerToTextY + invHUD.wandHUDTextDeltaY,
                graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
            )
            -- draw spells
            local hasNoSpells = true
            for i = 1, #wand.spells do
                local deltaX = (invHUD.HUDSpellsSize + invHUD.wandHUDSpellsDelta) * (i - 1)
                -- draw square + border
                graphics.color(hud.indentColor)
                graphics.rectangle(
                    x + invHUD.wandHUDCornerToSpellsX + deltaX,
                    y + invHUD.wandHUDCornerToSpellsY,
                    x + invHUD.wandHUDCornerToSpellsX + invHUD.HUDSpellsSize - 1 + deltaX,
                    y + invHUD.wandHUDCornerToSpellsY + invHUD.HUDSpellsSize - 1
                )
                graphics.color(hud.indentEdgeColor)
                graphics.rectangle(
                    x + invHUD.wandHUDCornerToSpellsX + deltaX,
                    y + invHUD.wandHUDCornerToSpellsY,
                    x + invHUD.wandHUDCornerToSpellsX + invHUD.HUDSpellsSize - 1 + deltaX,
                    y + invHUD.wandHUDCornerToSpellsY + invHUD.HUDSpellsSize - 1,
                    true
                )
                -- draw spell, if any
                local spellIndex = wandIndex + i / 10
                if not canSpellSwap or playerData.editor.heldThing == spellIndex then
                    graphics.alpha(0.5)
                end
                if type(wand.spells[i]) == "table" then
                    hasNoSpells = false
                    graphics.drawImage{
                        wand.spells[i].sprites.icon,
                        x + invHUD.wandHUDCornerToSpellsX + deltaX + 1,
                        y + invHUD.wandHUDCornerToSpellsY + 1,
                        alpha = (not canSpellSwap or playerData.editor.heldThing == spellIndex) and 0.5 or 1
                    }
                    
                    if wand.spells[i].type == spellType.PROJECTILE then
                        -- draw uses, if limited
                        if wand.spells[i].count ~= -1 then
                            graphics.color(Color.WHITE)
                            graphics.print(
                                wand.spells[i].count,
                                x + invHUD.wandHUDCornerToSpellsX + deltaX + invHUD.HUDSpellsSize - 2,
                                y + invHUD.wandHUDCornerToSpellsY + 1,
                                graphics.FONT_SMALL, graphics.ALIGN_RIGHT, graphics.ALIGN_TOP
                            )
                        end
                        -- draw warning if spell can't be fired
                        if wand.spells[i].manaCost > wand.stats.manaMax then
                            graphics.drawImage{
                                invHUD.warning,
                                x + invHUD.wandHUDCornerToSpellsX + deltaX,
                                y + invHUD.wandHUDCornerToSpellsY
                            }
                        end
                    end
                end
                if not canSpellSwap or playerData.editor.heldThing == spellIndex then
                    graphics.alpha(1)
                end
                -- highlight it if controller is over it
                if not alreadyHighlighted and cursorIndex ~= nil and cursorIndex == spellIndex then
                    alreadyHighlighted = true
                    graphics.color(Color.YELLOW)
                    graphics.alpha(0.3)
                    graphics.rectangle(
                        x + invHUD.wandHUDCornerToSpellsX + deltaX,
                        y + invHUD.wandHUDCornerToSpellsY,
                        x + invHUD.wandHUDCornerToSpellsX + invHUD.HUDSpellsSize - 1 + deltaX,
                        y + invHUD.wandHUDCornerToSpellsY + invHUD.HUDSpellsSize - 1
                    )
                    graphics.alpha(1)
                end
            end
            
            -- if wand has no spells, draw warning
            if hasNoSpells then
                graphics.drawImage{
                    invHUD.warning,
                    x, y
                }
            end
            
            if playerData.editor.heldThing == wandIndex then
                graphics.alpha(1)
            end
            
            -- if this is the locked wand
            if wandIndex == lockedWand then
                -- draw shadow over it
                graphics.color(hud.indentColor)
                graphics.alpha(0.5)
                graphics.rectangle(x, y, x + invHUD.wandHUDLength - 1, y + invHUD.wandHUDHeight - 1)
                graphics.alpha(1)
                
                -- draw cross
                graphics.color(Color.LIGHT_GREY)
                graphics.line(
                    x + 3,
                    y + 3,
                    x + invHUD.wandHUDLength - 1 - 3,
                    y + invHUD.wandHUDHeight - 1 - 3,
                    5
                )
                graphics.line(
                    x + invHUD.wandHUDLength - 1 - 3,
                    y + 3,
                    x + 3,
                    y + invHUD.wandHUDHeight - 1 - 3,
                    5
                )
            end
        end
        
        -- highlight it if controller is over it
        if not alreadyHighlighted and cursorIndex ~= nil and cursorIndex == wandIndex then
            alreadyHighlighted = true
            graphics.color(Color.YELLOW)
            graphics.alpha(0.3)
            graphics.rectangle(
                x,
                y,
                x + invHUD.wandHUDLength - 1,
                y + invHUD.wandHUDHeight - 1
            )
            graphics.alpha(1)
        end
        -- finally, increment y by spacing
        -- TODO: increment is done outside the empty wand check to allow space between wands to be seen (for switching)
        --       is this a good idea?
        y = y + invHUD.wandHUDHeight + invHUD.HUDDeltaYBetweenWands
    end
end

local function HUDDrawInventory(x, y, inventory, player, gamepad, mouseX, mouseY, canSpellSwap)
    local overHeldSpot = false

    -- draw background
    graphics.color(hud.fillColor)
    graphics.rectangle(x, y, x + invHUD.invHUDLength - 1, y + invHUD.invHUDHeight - 1)
    -- draw border
    graphics.color(hud.borderColor)
    graphics.rectangle(x, y, x + invHUD.invHUDLength - 1, y + invHUD.invHUDHeight - 1, true)
    -- draw inventory title
    graphics.color(Color.WHITE)
    graphics.print(
        "Inventory",
        x + invHUD.HUDCornerToTitleX,
        y + invHUD.HUDCornerToTitleY,
        graphics.FONT_DEFAULT, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
    )
    -- draw inventory slots
    local deltaX, deltaY, index = 0, 0, 0
    for i = 1, 2 do
        deltaY = (invHUD.HUDSpellsSize + invHUD.invHUDSpellsDeltaY) * (i - 1)
        for j = 1, 8 do
            deltaX = (invHUD.HUDSpellsSize + invHUD.invHUDSpellsDeltaX) * (j - 1)
            index = j + 8 * (i - 1)
            
            local x1 = x + invHUD.invHUDCornerToSpellsX + deltaX
            local y1 = y + invHUD.invHUDCornerToSpellsY + deltaY
            local x2 = x + invHUD.invHUDCornerToSpellsX + invHUD.HUDSpellsSize - 1 + deltaX
            local y2 = y + invHUD.invHUDCornerToSpellsY + invHUD.HUDSpellsSize - 1 + deltaY
            
            -- draw square + border
            graphics.color(hud.indentColor)
            graphics.rectangle(x1,y1,x2,y2)
            graphics.color(hud.indentEdgeColor)
            graphics.rectangle(x1,y1,x2,y2,true)
            
            -- check for held stuff
            if canSpellSwap and mouseX >= x1 and mouseX <= x2 and mouseY >= y1 and mouseY <= y2 then
                if playerData.editor.heldThing ~= 0 then
                    if controlStatus.fire(gamepad) == input.RELEASED then
                        if playerData.editor.heldThing ~= index+4 then
                            -- swap spells if held thing isnt the same inv slot
                            reorderItemsOrSpells(player, playerData.editor.heldThing, index+4)
                            resetSkillDescriptions(player)
                        else
                            getSound("inv", "item_move_denied"):play()
                        end
                        playerData.editor.heldThing = 0
                    elseif controlStatus.fire(gamepad) == input.HELD then
                        local heldIndex = math.floor(playerData.editor.heldThing)
                        local heldSpell = (playerData.editor.heldThing - heldIndex) * 10
                        if heldIndex >= 5 or heldSpell ~= 0 then
                            overHeldSpot = true
                            graphics.color(Color.YELLOW)
                            graphics.alpha(0.2)
                            graphics.rectangle(x1,y1,x2,y2)
                            graphics.alpha(1)
                        end
                    end
                elseif controlStatus.fire(gamepad) == input.PRESSED and type(inventory[index]) == "table" then
                    -- grab spell if clicked
                    playerData.editor.heldThing = index+4
                end
            end
            
            -- draw spell in inventory, if its not empty
            if type(inventory[index]) == "table" then
                if playerData.editor.heldThing == index+4 or not canSpellSwap then
                    graphics.alpha(0.5)
                end
                graphics.drawImage{
                    inventory[index].sprites.icon,
                    x + invHUD.invHUDCornerToSpellsX + deltaX + 1,
                    y + invHUD.invHUDCornerToSpellsY + deltaY + 1
                }
                if playerData.editor.heldThing == index+4 or not canSpellSwap then
                    graphics.alpha(1)
                end
            end
            
            -- highlight it if controller is over it
            if gamepad ~= nil and mouseX >= x1 and mouseX <= x2 and mouseY >= y1 and mouseY <= y2 then
                graphics.color(Color.YELLOW)
                graphics.alpha(0.3)
                graphics.rectangle(
                    x1,
                    y1,
                    x2,
                    y2
                )
                graphics.alpha(1)
            end
        end
    end
    
    return overHeldSpot
end

function HUDDrawColorPalette(x, y, playerData, cursorIndex)
    local editor = playerData.editor
    -- draw background
    graphics.color(hud.fillColor)
    graphics.rectangle(x, y, x + invHUD.colorHUDLength - 1, y + invHUD.colorHUDHeight - 1)
    -- draw border
    graphics.color(hud.borderColor)
    graphics.rectangle(x, y, x + invHUD.colorHUDLength - 1, y + invHUD.colorHUDHeight - 1, true)
    -- draw editor title
    graphics.color(Color.WHITE)
    graphics.print(
        "Character Editor",
        x + invHUD.HUDCornerToTitleX,
        y + invHUD.HUDCornerToTitleY,
        graphics.FONT_DEFAULT, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
    )
    -- draw currently editing part text
    graphics.print(
        editor.currentlyEditing .. ":",
        x + invHUD.colorHUDCornerToTextX,
        y + invHUD.colorHUDCornerToTextY,
        graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
    )
    -- draw color palette
    graphics.color(hud.indentEdgeColor)
    graphics.rectangle(
        x + invHUD.colorHUDCornerToColorX,
        y + invHUD.colorHUDCornerToColorY,
        x + invHUD.colorHUDCornerToColorX + invHUD.colorHUDColorSize - 1,
        y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize - 1
    )
    -- -- for h = 1, 64 do
        -- -- for s = 1, 64 do
            -- -- graphics.color(Color.fromHSV((h - 1) * 4, (64 - s) * 4, 255 - 2 * s))
            -- -- graphics.pixel(
                -- -- x + invHUD.colorHUDCornerToColorX + h,
                -- -- y + invHUD.colorHUDCornerToColorY + s
            -- -- )
        -- -- end
    -- -- end
    -- lmao this causes a ton of lag, lets just pussy out and draw a palette image
    invHUD.paletteImg:draw(x + invHUD.colorHUDCornerToColorX + 1, y + invHUD.colorHUDCornerToColorY + 1)
    -- draw crosshair over current color
    local currColorH = editor[editor.currentlyEditing].H / 4
    local currColorS = editor[editor.currentlyEditing].S / 4
    graphics.color(Color.BLACK)
    for i = 1, 2 do
        graphics.pixel(
            x + invHUD.colorHUDCornerToColorX + math.clamp(currColorH + i, 1, 64) + 1,
            y + invHUD.colorHUDCornerToColorY + 64 - currColorS
        )
        graphics.pixel(
            x + invHUD.colorHUDCornerToColorX + currColorH + 1,
            y + invHUD.colorHUDCornerToColorY + 64 - math.clamp(currColorS + i, 1, 64)
        )
        graphics.pixel(
            x + invHUD.colorHUDCornerToColorX + math.clamp(currColorH - i, 1, 64) + 1,
            y + invHUD.colorHUDCornerToColorY + 64 - currColorS
        )
        graphics.pixel(
            x + invHUD.colorHUDCornerToColorX + currColorH + 1,
            y + invHUD.colorHUDCornerToColorY + 64 - math.clamp(currColorS - i, 1, 64)
        )
    end
    -- draw yellow shade if controller over it
    if cursorIndex ~= nil and cursorIndex == #playerData.wands + #playerData.inventory + 1.1 then
        graphics.color(Color.YELLOW)
        graphics.alpha(0.3)
        graphics.rectangle(
            x + invHUD.colorHUDCornerToColorX,
            y + invHUD.colorHUDCornerToColorY,
            x + invHUD.colorHUDCornerToColorX + invHUD.colorHUDColorSize,
            y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize
        )
        graphics.alpha(1)
    end
    -- draw brightness palette
    graphics.color(hud.indentEdgeColor)
    graphics.rectangle(
        x + invHUD.colorHUDCornerToColorX,
        y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta,
        x + invHUD.colorHUDCornerToColorX + invHUD.colorHUDColorSize - 1,
        y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + invHUD.colorHUDColorBrightHeight - 1
    )
    for v = 1, 64 do
        graphics.color(Color.fromHSV(currColorH * 4, currColorS * 4, (64 - v) * 4))
        graphics.rectangle(
            x + invHUD.colorHUDCornerToColorX + v,
            y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + 1,
            x + invHUD.colorHUDCornerToColorX + v,
            y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + invHUD.colorHUDColorBrightHeight - 2
        )
    end
    -- draw black arrow under current brightness
    local currColorV = editor[editor.currentlyEditing].V / 4
    local currCoordV = x + invHUD.colorHUDCornerToColorX + 64 - currColorV
    graphics.color(Color.BLACK)
    graphics.triangle(
        currCoordV, y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + invHUD.colorHUDColorBrightHeight + 1,
        currCoordV - 2, y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + invHUD.colorHUDColorBrightHeight + 3,
        currCoordV + 2, y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + invHUD.colorHUDColorBrightHeight + 3
    )
    -- draw yellow shade if controller over it
    if cursorIndex ~= nil and cursorIndex == #playerData.wands + #playerData.inventory + 1.2 then
        graphics.color(Color.YELLOW)
        graphics.alpha(0.3)
        graphics.rectangle(
            x + invHUD.colorHUDCornerToColorX,
            y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta,
            x + invHUD.colorHUDCornerToColorX + invHUD.colorHUDColorSize - 1,
            y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + invHUD.colorHUDColorBrightHeight - 1
        )
        graphics.alpha(1)
    end
    -- draw shading box
    graphics.color(hud.indentColor)
    graphics.rectangle(
        x + invHUD.colorHUDCornerToShadingX,
        y + invHUD.colorHUDCornerToShadingY,
        x + invHUD.colorHUDCornerToShadingX + invHUD.colorHUDShadingSize - 1,
        y + invHUD.colorHUDCornerToShadingY + invHUD.colorHUDShadingSize - 1,
        true
    )
    graphics.color(hud.indentEdgeColor)
    graphics.rectangle(
        x + invHUD.colorHUDCornerToShadingX,
        y + invHUD.colorHUDCornerToShadingY,
        x + invHUD.colorHUDCornerToShadingX + invHUD.colorHUDShadingSize - 1,
        y + invHUD.colorHUDCornerToShadingY + invHUD.colorHUDShadingSize - 1,
        true
    )
    -- check shading box
    if editor.shading then
        graphics.color(Color.WHITE)
        -- drawn lines are non-pixelated for some reason, so we gotta pixelate ourselves
        for i = 1, invHUD.colorHUDShadingSize - 2 do
            graphics.pixel(
                x + invHUD.colorHUDCornerToShadingX + i,
                y + invHUD.colorHUDCornerToShadingY + i
            )
            graphics.pixel(
                x + invHUD.colorHUDCornerToShadingX + i,
                y + invHUD.colorHUDCornerToShadingY + invHUD.colorHUDShadingSize - 1 - i
            )
        end
    end
    -- draw yellow shade if controller over it
    if cursorIndex ~= nil and cursorIndex == #playerData.wands + #playerData.inventory + 1.3 then
        graphics.color(Color.YELLOW)
        graphics.alpha(0.3)
        graphics.rectangle(
            x + invHUD.colorHUDCornerToShadingX,
            y + invHUD.colorHUDCornerToShadingY,
            x + invHUD.colorHUDCornerToShadingX + invHUD.colorHUDShadingSize - 1,
            y + invHUD.colorHUDCornerToShadingY + invHUD.colorHUDShadingSize - 1
        )
        graphics.alpha(1)
    end
    -- draw shading text
    graphics.color(Color.WHITE)
    graphics.print(
        "Use shading",
        x + invHUD.colorHUDCornerToShadingX + invHUD.colorHUDShadingSize + invHUD.colorHUDShadingDelta,
        y + invHUD.colorHUDCornerToShadingY + invHUD.colorHUDShadingSize - 1,
        graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_BOTTOM
    )
    -- draw apply button
    graphics.color(hud.lightFillColor)
    graphics.rectangle(
        x + invHUD.colorHUDCornerToApplyX,
        y + invHUD.colorHUDCornerToApplyY,
        x + invHUD.colorHUDCornerToApplyX + invHUD.colorHUDApplyLength - 1,
        y + invHUD.colorHUDCornerToApplyY + invHUD.colorHUDApplyHeight - 1
    )
    graphics.color(hud.indentEdgeColor)
    graphics.rectangle(
        x + invHUD.colorHUDCornerToApplyX,
        y + invHUD.colorHUDCornerToApplyY,
        x + invHUD.colorHUDCornerToApplyX + invHUD.colorHUDApplyLength - 1,
        y + invHUD.colorHUDCornerToApplyY + invHUD.colorHUDApplyHeight - 1,
        true
    )
    -- draw apply text
    graphics.color(Color.WHITE)
    local textCoordX = math.floor((invHUD.colorHUDApplyLength - graphics.textWidth("Apply", graphics.FONT_SMALL)) / 2)
    graphics.print(
        "Apply",
        x + invHUD.colorHUDCornerToApplyX + 1 + textCoordX,
        y + invHUD.colorHUDCornerToApplyY,
        graphics.FONT_SMALL, graphics.ALIGN_LEFT, graphics.ALIGN_TOP
    )
    -- draw yellow shade if controller over it
    if cursorIndex ~= nil and cursorIndex == #playerData.wands + #playerData.inventory + 3 then
        graphics.color(Color.YELLOW)
        graphics.alpha(0.3)
        graphics.rectangle(
            x + invHUD.colorHUDCornerToApplyX,
            y + invHUD.colorHUDCornerToApplyY,
            x + invHUD.colorHUDCornerToApplyX + invHUD.colorHUDApplyLength - 1,
            y + invHUD.colorHUDCornerToApplyY + invHUD.colorHUDApplyHeight - 1
        )
        graphics.alpha(1)
    end
    -- draw buttons
    for i = 1, 3 do
        local deltaY = (i - 1) * (invHUD.colorHUDColorButtonsHeight + invHUD.colorHUDColorButtonsDelta)
        local pressed = editor.currentlyEditing == spriteParts[i]
        graphics.color(pressed and Color.WHITE or hud.lightFillColor)
        graphics.rectangle(
            x + invHUD.colorHUDCornerToColorButtonsX,
            y + invHUD.colorHUDCornerToColorButtonsY + deltaY,
            x + invHUD.colorHUDCornerToColorButtonsX + invHUD.colorHUDColorButtonsLength - 1,
            y + invHUD.colorHUDCornerToColorButtonsY + invHUD.colorHUDColorButtonsHeight - 1 + deltaY
        )
        graphics.color(hud.indentEdgeColor)
        graphics.rectangle(
            x + invHUD.colorHUDCornerToColorButtonsX,
            y + invHUD.colorHUDCornerToColorButtonsY + deltaY,
            x + invHUD.colorHUDCornerToColorButtonsX + invHUD.colorHUDColorButtonsLength - 1,
            y + invHUD.colorHUDCornerToColorButtonsY + invHUD.colorHUDColorButtonsHeight - 1 + deltaY,
            true
        )
        graphics.color(pressed and hud.lightFillColor or Color.WHITE)
        graphics.triangle(
            x + invHUD.colorHUDCornerToColorButtonsX + 1,
            y + invHUD.colorHUDCornerToColorButtonsY + deltaY + math.floor(invHUD.colorHUDColorButtonsHeight / 2) - 3,
            x + invHUD.colorHUDCornerToColorButtonsX + 1,
            y + invHUD.colorHUDCornerToColorButtonsY + deltaY + math.ceil(invHUD.colorHUDColorButtonsHeight / 2) + 3,
            x + invHUD.colorHUDCornerToColorButtonsX + invHUD.colorHUDColorButtonsLength - 3,
            y + invHUD.colorHUDCornerToColorButtonsY + deltaY + math.floor(invHUD.colorHUDColorButtonsHeight / 2) + 1
        )
        -- draw yellow shade if controller over it
        if cursorIndex ~= nil and cursorIndex == #playerData.wands + #playerData.inventory + 2 + i / 10 then
            graphics.color(Color.YELLOW)
            graphics.alpha(0.3)
            graphics.rectangle(
                x + invHUD.colorHUDCornerToColorButtonsX,
                y + invHUD.colorHUDCornerToColorButtonsY + deltaY,
                x + invHUD.colorHUDCornerToColorButtonsX + invHUD.colorHUDColorButtonsLength - 1,
                y + invHUD.colorHUDCornerToColorButtonsY + invHUD.colorHUDColorButtonsHeight - 1 + deltaY
            )
            graphics.alpha(1)
        end
    end
    -- draw display
    graphics.color(hud.indentColor)
    graphics.rectangle(
        x + invHUD.colorHUDCornerToDisplayX,
        y + invHUD.colorHUDCornerToDisplayY,
        x + invHUD.colorHUDCornerToDisplayX + invHUD.colorHUDDisplayLength - 1,
        y + invHUD.colorHUDCornerToDisplayY + invHUD.colorHUDDisplayHeight - 1
    )
    graphics.color(hud.indentEdgeColor)
    graphics.rectangle(
        x + invHUD.colorHUDCornerToDisplayX,
        y + invHUD.colorHUDCornerToDisplayY,
        x + invHUD.colorHUDCornerToDisplayX + invHUD.colorHUDDisplayLength - 1,
        y + invHUD.colorHUDCornerToDisplayY + invHUD.colorHUDDisplayHeight - 1,
        true
    )
    -- draw character in display
    local scale = (invHUD.colorHUDDisplayHeight - 3 - 3) / spritePieces.idle.sprites.normal[1].Head.height
    for _, part in ipairs(spritePiecesList) do
        local sprite = spritePieces.idle.sprites[editor.shading and "shaded" or "normal"][1][part]
        graphics.drawImage{
            sprite,
            x + invHUD.colorHUDCornerToDisplayX + sprite.xorigin * scale + (invHUD.colorHUDDisplayLength - sprite.width * scale) / 2,
            y + invHUD.colorHUDCornerToDisplayY + sprite.yorigin * scale + (invHUD.colorHUDDisplayHeight - sprite.height * scale) / 2,
            scale = scale,
            color = part == "Extra" and Color.WHITE or Color.fromHSV(editor[part].H, editor[part].S, editor[part].V)
        }
    end
end

local function HUDDrawWandSelection(drawCenterX, drawCenterY, hudW, hudH, wand, player, playerData, lockedWand)
    local pickedUpWandX, pickedUpWandY, cancelTextCenterX, cancelTextCenterY, wandListCornerX, wandListCornerY = -1, -1, -1, -1, -1, -1

    -- draw shadow overlay
    graphics.alpha(0.7)
    graphics.color(Color.BLACK)
    graphics.rectangle(0, 0, hudW, hudH)
    graphics.alpha(1)
    
    drawCenterY = drawCenterY - 250
    -- draw picked up wand details
    graphics.color(Color.WHITE)
    graphics.print(
        "New Wand",
        drawCenterX, drawCenterY,
        graphics.FONT_DEFAULT, graphics.ALIGN_MIDDLE, graphics.ALIGN_CENTER
    )
    drawCenterY = drawCenterY + graphics.textHeight("New Wand", graphics.FONT_DEFAULT)
    pickedUpWandX, pickedUpWandY = drawCenterX - invHUD.pickWandBoxLength / 2, drawCenterY
    drawInfoPopup(pickedUpWandX, pickedUpWandY, wand, player, "choice")
    
    drawCenterY = drawCenterY + 200
    -- draw wand pickup dialogue
    for i = 1, 2 do
        graphics.color(i == 1 and hud.fillColor or hud.borderColor)
        graphics.ellipse(
            drawCenterX - invHUD.pickWandDialogueLength / 2,
            drawCenterY,
            drawCenterX - invHUD.pickWandDialogueLength / 2 + 2 * invHUD.pickWandDialogueHeight,
            drawCenterY + invHUD.pickWandDialogueHeight,
            i ~= 1
        )
        graphics.ellipse(
            drawCenterX + invHUD.pickWandDialogueLength / 2,
            drawCenterY,
            drawCenterX + invHUD.pickWandDialogueLength / 2 - 2 * invHUD.pickWandDialogueHeight,
            drawCenterY + invHUD.pickWandDialogueHeight,
            i ~= 1
        )
    end
    for i = 0, 1 do
        graphics.color(i == 0 and hud.borderColor or hud.fillColor)
        graphics.rectangle(
            drawCenterX - invHUD.pickWandDialogueLength / 2 + invHUD.pickWandDialogueHeight,
            drawCenterY + i,
            drawCenterX + invHUD.pickWandDialogueLength / 2 - invHUD.pickWandDialogueHeight,
            drawCenterY + invHUD.pickWandDialogueHeight - i,
            i == 0
        )
    end
    graphics.color(Color.WHITE)
    graphics.print(
        "WHICH WAND DO YOU WANT TO DROP? (Click it!)",
        drawCenterX, drawCenterY + invHUD.pickWandDialogueHeight / 2,
        graphics.FONT_DEFAULT, graphics.ALIGN_MIDDLE, graphics.ALIGN_CENTER
    )
    
    drawCenterY = drawCenterY + 35
    cancelTextCenterX, cancelTextCenterY = drawCenterX, drawCenterY + invHUD.pickWandDialogueHeight / 2
    graphics.print(
        "Cancel",
        cancelTextCenterX, cancelTextCenterY,
        graphics.FONT_DEFAULT, graphics.ALIGN_MIDDLE, graphics.ALIGN_CENTER
    )
    
    drawCenterY = drawCenterY + 65
    drawCenterX = drawCenterX - invHUD.pickWandBoxLength - 2 - invHUD.pickWandBoxLength - 1
    wandListCornerX, wandListCornerY = drawCenterX, drawCenterY
    -- draw wands
    for wandIndex, wand in ipairs(playerData.wands) do
        if type(wand) == "table" then
            drawInfoPopup(drawCenterX, drawCenterY, wand, player, "choice")
            if wandIndex == lockedWand then
                -- draw shadow rectangle
                graphics.color(hud.borderColor)
                graphics.alpha(0.5)
                graphics.rectangle(
                    drawCenterX, drawCenterY,
                    drawCenterX + invHUD.pickWandBoxLength - 1,
                    drawCenterY + invHUD.pickWandBoxHeight - 1,
                    false
                )
                graphics.alpha(1)
                -- draw cross
                graphics.color(Color.LIGHT_GREY)
                graphics.line(
                    drawCenterX + 3,
                    drawCenterY + 3,
                    drawCenterX + invHUD.pickWandBoxLength - 1 - 3,
                    drawCenterY + invHUD.pickWandBoxHeight - 1 - 3,
                    5
                )
                graphics.line(
                    drawCenterX + invHUD.pickWandBoxLength - 1 - 3,
                    drawCenterY + 3,
                    drawCenterX + 3,
                    drawCenterY + invHUD.pickWandBoxHeight - 1 - 3,
                    5
                )
            end
        else
            -- draw empty rectangle
            graphics.color(hud.borderColor)
            graphics.rectangle(
                drawCenterX, drawCenterY,
                drawCenterX + invHUD.pickWandBoxLength - 1,
                drawCenterY + invHUD.pickWandBoxHeight - 1,
                true
            )
            graphics.color(Color.WHITE)
            graphics.print(
                "+",
                drawCenterX + invHUD.pickWandBoxLength / 2,
                drawCenterY + invHUD.pickWandBoxHeight / 2,
                graphics.FONT_LARGE, graphics.ALIGN_MIDDLE, graphics.ALIGN_CENTER
            )
        end
        drawCenterX = drawCenterX + invHUD.pickWandBoxLength + 2
    end
    
    return pickedUpWandX, pickedUpWandY, cancelTextCenterX, cancelTextCenterY, wandListCornerX, wandListCornerY
end

local function HUDDrawOptions(x, y, cursorIndex, playerData)
    if cursorIndex ~= nil then
        local optionX, optionY = x + invHUD.optionsHUDExternalCornerToOptionsX, y + invHUD.optionsHUDExternalCornerToOptionsY
        -- draw icon
        local hoveringOver = cursorIndex == #playerData.wands + #playerData.inventory + 4
        graphics.drawImage{
            invHUD.optionsIcon,
            optionX, optionY,
            alpha = hoveringOver and 0.5 or 1
        }
        -- highlight
        if hoveringOver then
            graphics.color(Color.YELLOW)
            graphics.alpha(0.3)
            graphics.rectangle(
                optionX,
                optionY,
                optionX + invHUD.optionsHUDExternalIconSize,
                optionY + invHUD.optionsHUDExternalIconSize
            )
            graphics.alpha(1)
        end
    end
end

-- function HUDHandler(handlerInst, frame)
    -- local player = handlerInst:getData().player
registercallback("onPlayerHUDDraw", function(player, _, _)
    playerData = player:getData()
    if player:getSurvivor() == caster and (not net.online or (net.online and net.localPlayer == player)) then
        local hudW, hudH = graphics.getHUDResolution()
        local mouseX, mouseY, cursorIndex = nil, nil, nil
        local gamepad = input.getPlayerGamepad(player)
        if gamepad == nil then
            mouseX, mouseY = input.getMousePos(true)
        end
        
        local hudWidth, hudHeight = graphics.getHUDResolution()
        local drawCenterX, drawCenterY = hudWidth * (1/2), hudHeight * (1/2) -- TODO: fixed HUD probably isnt the best option
        
        local baseColor = graphics.getColor()

        local teleporting = player:get("activity") == 99
        local distortion = Artifact.find("Distortion", "vanilla").active

        if playerData.openInventory then
            local heldIndex = roundNumber(math.floor(playerData.editor.heldThing), 0)
            local heldSpell = roundNumber((playerData.editor.heldThing - heldIndex) * 10, 0)
            
            if teleporting then
                playerData.openInventory = false
                
                if playerData.editor.heldThing ~= 0 then
                    dropHeldThing(player, playerData, heldIndex, heldSpell)
                end
                playerData.editor = {}
                return
            end
        
            cursorIndex = playerData.lastCursorIndex.inv
            if gamepad == nil then
                cursorIndex = nil
            end
            local cursorIndexI, cursorIndexS = nil, nil
            
            local drawCornerX, drawCornerY = drawCenterX - math.floor(invHUD.totalInvLength / 2), drawCenterY - math.floor(invHUD.totalInvHeight / 2)
            local overHeldSpot = false
            
            -- check if you can edit wands (if tp is done)
            local canSpellSwap = false
            local currTp = Object.find("Teleporter"):find(1)
            if currTp ~= nil then
                canSpellSwap = currTp:get("active") >= 3
            end
            
            -- if using gamepad and not in , check for movement
            if gamepad ~= nil then
                cursorIndexI = roundNumber(math.floor(cursorIndex), 0)
                cursorIndexS = roundNumber((cursorIndex - cursorIndexI) * 10, 0)
                local dx, dy = controlStatus.hudMove(gamepad)
                -- wands:
                --  - going down enters wand's first spell, going up enters previous wand's first spell
                --  - going left goes nowhere, going right goes to inventory
                -- wand spells:
                --  - going down enters next wand, going up exits to this wand
                --  - going left/right shifts between spells
                --  - going left on first spell exits to this wand, going right on last spell goes to inventory
                -- inventory:
                --  - going left/right/up/down shifts between inventory slots
                --  - going left on first slot on either row goes to first wand, going right on last slot on either row goes to misc
                -- misc:
                --  - going left on the color palette, shade palette or checkbox goes back to inventory
                --  - going left/right/up/down shifts around stuff
                --  - going down/right from accept button goes to options
                --  - going up/left from options goes to accept button
                
                -- before starting: if wand is locked and one of the spells was selected, deselect the spell
                if cursorIndexI <= #playerData.wands and distortion and player:get("artifact_lock_choice") + 1 == cursorIndexI then
                    cursorIndexS = 0
                end
                for i = 1, 2 do
                    local turn = (i == 1) and dx or dy
                    if cursorIndexI <= #playerData.wands then
                        if cursorIndexS == 0 then
                            -- wands
                            if turn == dx and dx > 0 then
                                -- move to inventory
                                cursorIndexI = #playerData.wands + 1
                            elseif turn == dy then
                                if dy < 0 and cursorIndexI ~= 1 then
                                    -- move to prev wand's first spell, if any
                                    cursorIndexI = cursorIndexI - 1
                                    if type(playerData.wands[cursorIndexI]) == "table"
                                      and (not distortion or (distortion and player:get("artifact_lock_choice") + 1 ~= cursorIndexI)) then
                                        cursorIndexS = 1
                                    end
                                elseif dy > 0 then
                                    -- move to this wand's first spell, if any
                                    if type(playerData.wands[cursorIndexI]) == "table"
                                      and (not distortion or (distortion and player:get("artifact_lock_choice") + 1 ~= cursorIndexI)) then
                                        cursorIndexS = 1
                                    elseif cursorIndexI ~= #playerData.wands then
                                        -- if no spells or locked wand, move to next wand instead
                                        cursorIndexI = cursorIndexI + dy
                                    end
                                end
                            end
                        else
                            -- wand spells
                            if turn == dx then
                                if dx < 0 and cursorIndexS == 1 then
                                    -- move to this wand
                                    cursorIndexS = 0
                                elseif dx > 0 and cursorIndexS == #playerData.wands[cursorIndexI].spells then
                                    -- move to inventory
                                    cursorIndexI, cursorIndexS = #playerData.wands + 1, 0
                                else
                                    -- move between spells
                                    cursorIndexS = cursorIndexS + dx
                                end
                            else
                                if dy < 0 then
                                    -- move to this wand
                                    cursorIndexS = 0
                                elseif dy > 0 and cursorIndexI ~= #playerData.wands then
                                    -- move to next wand
                                    cursorIndexI, cursorIndexS = cursorIndexI + 1, 0
                                end
                            end
                        end
                    elseif cursorIndexI <= #playerData.wands + #playerData.inventory then
                        -- inventory
                        if turn == dx then
                            if dx < 0 and (cursorIndexI == #playerData.wands + 1
                              or cursorIndexI == #playerData.wands + #playerData.inventory / 2 + 1) then
                                -- go back to wands
                                cursorIndexI = 1
                            elseif dx > 0 and (cursorIndexI == #playerData.wands + #playerData.inventory / 2
                              or cursorIndexI == #playerData.wands + #playerData.inventory) then
                                -- go to misc
                                if playerData.editor.heldThing == 0 then
                                    cursorIndexI, cursorIndexS = #playerData.wands + #playerData.inventory + 1, 1
                                end
                            else
                                -- move between slots
                                cursorIndexI = cursorIndexI + dx
                            end
                        else
                            -- move between slot rows
                            if cursorIndexI < #playerData.inventory / 2 + 1 + #playerData.wands and dy > 0
                              or cursorIndexI >= #playerData.inventory / 2 + 1 + #playerData.wands and dy < 0 then
                                cursorIndexI = cursorIndexI + (#playerData.inventory / 2) * dy
                            end
                        end
                    else
                        -- color picking, options, etc
                        local subDelta = #playerData.wands + #playerData.inventory
                        if cursorIndexI - subDelta == 1 and (cursorIndexS == 1 or cursorIndexS == 2)
                          and controlStatus.fire(gamepad) == input.HELD then
                            -- picking colors; don't change anything
                        elseif turn == dx then
                            if cursorIndexI - subDelta == 3 and dx > 0 or cursorIndexI - subDelta == 4 and dx < 0 then
                                -- shift between accept and options
                                cursorIndexI = cursorIndexI + dx
                            elseif cursorIndexI - subDelta == 1 and dx < 0 then
                                -- go back to inventory
                                cursorIndexI = #playerData.wands + #playerData.inventory / 2
                            elseif cursorIndexI - subDelta == 2 and dx < 0
                              or cursorIndexI - subDelta == 1 and dx > 0 then
                                -- shift between things
                                cursorIndexI = cursorIndexI + dx
                            end
                        else
                            if cursorIndexI - subDelta == 3 and dy > 0 or cursorIndexI - subDelta == 4 and dy < 0 then
                                -- shift between accept and options
                                cursorIndexI = cursorIndexI + dy
                            elseif cursorIndexS == 3 and dy > 0 then
                                -- go to accept
                                cursorIndexI, cursorIndexS = cursorIndexI + dy, 0
                            elseif cursorIndexI - subDelta == 3 and dy < 0 then
                                -- go back to things
                                cursorIndexI, cursorIndexS = cursorIndexI + dy, 3
                            elseif (cursorIndexI - subDelta == 1 or cursorIndexI - subDelta == 2) and
                              cursorIndexS < 3 and dy > 0 or cursorIndexS > 1 and dy < 0 then
                                -- shift between things
                                cursorIndexS = cursorIndexS + dy
                            end
                        end
                    end
                end
                cursorIndex = cursorIndexI + cursorIndexS / 10
            end
            
            -- calculate mouse/cursor position, indexes, etc
            -- TODO: export this to external function, and use "virtual" mouse coords for everything afterwards instead of using cursorIndex
            if gamepad ~= nil then
                if cursorIndexI <= #playerData.wands then
                    -- wands
                    mouseX, mouseY = drawCornerX, drawCornerY + (cursorIndexI - 1)*(invHUD.wandHUDHeight + invHUD.HUDDeltaYBetweenWands)
                    if cursorIndexS ~= 0 then
                        -- wand spells
                        mouseX, mouseY = mouseX + invHUD.wandHUDCornerToSpellsX + (cursorIndexS - 1)*(invHUD.HUDSpellsSize + invHUD.wandHUDSpellsDelta),
                            mouseY + invHUD.wandHUDCornerToSpellsY
                    end
                elseif cursorIndexI <= #playerData.wands + #playerData.inventory then
                    -- inventory
                    local invIndex = cursorIndexI - #playerData.wands
                    local deltaX = ((invIndex - 1) % (#playerData.inventory / 2))*(invHUD.HUDSpellsSize + invHUD.invHUDSpellsDeltaX)
                    local deltaY = math.floor(invIndex/(#playerData.inventory / 2 + 1))*(invHUD.HUDSpellsSize + invHUD.invHUDSpellsDeltaY)
                    mouseX, mouseY = drawCornerX + invHUD.wandHUDLength + invHUD.HUDDeltaXBetweenWindows
                        + invHUD.invHUDCornerToSpellsX + deltaX, drawCornerY + invHUD.invHUDCornerToSpellsY + deltaY
                else
                    -- misc
                    local miscIndex = cursorIndexI - #playerData.wands - #playerData.inventory
                    if miscIndex == 1 then
                        -- color palettes and checkbox
                        mouseX, mouseY = drawCornerX + 2*(invHUD.wandHUDLength + invHUD.HUDDeltaXBetweenWindows)
                            + invHUD.colorHUDCornerToColorX, drawCornerY + invHUD.colorHUDCornerToColorY
                        if cursorIndexS == 2 then
                            mouseY = mouseY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta
                        elseif cursorIndexS == 3 then
                            mouseX, mouseY = drawCornerX + 2*(invHUD.wandHUDLength + invHUD.HUDDeltaXBetweenWindows)
                                + invHUD.colorHUDCornerToShadingX, drawCornerY + invHUD.colorHUDCornerToShadingY
                        end
                    end
                    if miscIndex == 2 then
                        -- side buttons
                        mouseX, mouseY = drawCornerX + 2*(invHUD.wandHUDLength + invHUD.HUDDeltaXBetweenWindows)
                            + invHUD.colorHUDCornerToColorButtonsX, drawCornerY + invHUD.colorHUDCornerToColorButtonsY
                            + (cursorIndexS - 1)*(invHUD.colorHUDColorButtonsHeight + invHUD.colorHUDColorButtonsDelta)
                    elseif miscIndex == 3 then
                        -- accept button
                        mouseX, mouseY = drawCornerX + 2*(invHUD.wandHUDLength + invHUD.HUDDeltaXBetweenWindows)
                            + invHUD.colorHUDCornerToApplyX, drawCornerY + invHUD.colorHUDCornerToApplyY
                    else
                        -- options
                        mouseX, mouseY = drawCornerX + 2*(invHUD.wandHUDLength + invHUD.HUDDeltaXBetweenWindows)
                            + invHUD.optionsHUDExternalCornerToOptionsX, drawCornerY + invHUD.optionsHUDExternalCornerToOptionsY
                    end
                end
            end
            
            -- draw wands
            HUDDrawWands(drawCornerX, drawCornerY, playerData, cursorIndex, canSpellSwap, distortion and player:get("artifact_lock_choice") + 1 or -1)
            
            -- draw inventory
            local invCornerX = drawCornerX + invHUD.wandHUDLength + invHUD.HUDDeltaXBetweenWindows
            overHeldSpot = HUDDrawInventory(invCornerX, drawCornerY, playerData.inventory, player, gamepad, mouseX, mouseY, canSpellSwap)
            
            -- draw color customizer
            local colorCornerX = invCornerX + invHUD.invHUDLength + invHUD.HUDDeltaXBetweenWindows
            HUDDrawColorPalette(colorCornerX, drawCornerY, playerData, cursorIndex)
            
            -- draw controller options
            HUDDrawOptions(colorCornerX, drawCornerY, cursorIndex, playerData)
            -- exit out if options is selected
            if cursorIndex == #playerData.wands + #playerData.inventory + 4 and controlStatus.fire(gamepad) == input.PRESSED then
                playerData.openOptions = true
                getSound("inv", "button_click"):play()
                
                playerData.openInventory = false
                
                if playerData.editor.heldThing ~= 0 then
                    dropHeldThing(player, playerData, heldIndex, heldSpell)
                end
                playerData.editor = {}
                player:set("activity", 0)
                return -- no need to do anything else
            end
            
            -- draw held item, if any
            if playerData.editor.heldThing ~= 0 and controlStatus.fire(gamepad) == input.HELD then
                local heldSprite = nil
                if heldIndex >= 5 then
                    heldSprite = playerData.inventory[heldIndex-4].sprites.icon
                elseif heldSpell ~= 0 then
                    heldSprite = playerData.wands[heldIndex].spells[heldSpell].sprites.icon
                else
                    heldSprite = playerData.wands[heldIndex].graphics.sprite
                end
                graphics.color(Color.BLACK)
                graphics.alpha(0.25)
                graphics.rectangle(
                    mouseX + invHUD.mouseHoverDistance - heldSprite.xorigin*2,
                    mouseY + invHUD.mouseHoverDistance - heldSprite.yorigin*2,
                    mouseX + (-heldSprite.xorigin + heldSprite.width)*2,
                    mouseY + (-heldSprite.yorigin + heldSprite.height)*2
                )
                graphics.alpha(1)
                graphics.color(Color.WHITE)
                graphics.drawImage{
                    heldSprite,
                    mouseX + invHUD.mouseHoverDistance,
                    mouseY + invHUD.mouseHoverDistance,
                    scale = 2
                }
            end
            
            -- check if over any info that can be displayed
            local drewSomething = false
            for wandIndex, wand in ipairs(playerData.wands) do
                local wandDeltaY = (wandIndex - 1) * (invHUD.wandHUDHeight + invHUD.HUDDeltaYBetweenWands)
                local x1, x2, y1, y2 = drawCornerX, drawCornerX + invHUD.wandHUDLength,
                  drawCornerY + wandDeltaY, drawCornerY + invHUD.wandHUDHeight + wandDeltaY
                if mouseX >= x1 and mouseX <= x2 and mouseY >= y1 and mouseY <= y2 then
                    if type(wand) == "table" and (not distortion or (distortion and player:get("artifact_lock_choice") + 1 ~= wandIndex)) then
                        local spellCornerX = drawCornerX + invHUD.wandHUDCornerToSpellsX
                        local spellCornerY = drawCornerY + wandDeltaY + invHUD.wandHUDCornerToSpellsY
                        for spellCounter, spell in ipairs(wand.spells) do
                            local spellDeltaX = (spellCounter - 1) * (invHUD.HUDSpellsSize + invHUD.wandHUDSpellsDelta)
                            local xx1, xx2, yy1, yy2 = spellCornerX + spellDeltaX, spellCornerX + invHUD.HUDSpellsSize + spellDeltaX,
                                spellCornerY, spellCornerY + invHUD.HUDSpellsSize
                            if mouseX >= xx1 and mouseX <= xx2 and mouseY >= yy1 and mouseY <= yy2 then
                                -- check for held stuff
                                local spellSlotIndex = wandIndex + spellCounter / 10
                                if canSpellSwap then
                                    if playerData.editor.heldThing ~= 0 then
                                        if controlStatus.fire(gamepad) == input.RELEASED then
                                            if playerData.editor.heldThing ~= spellSlotIndex then
                                                -- swap spells if held thing isnt the same spell slot
                                                reorderItemsOrSpells(player, playerData.editor.heldThing, spellSlotIndex)
                                                resetSkillDescriptions(player)
                                            else
                                                getSound("inv", "item_move_denied"):play()
                                            end
                                            playerData.editor.heldThing = 0
                                        elseif controlStatus.fire(gamepad) == input.HELD then
                                            if heldIndex >= 5 or heldSpell ~= 0 then
                                                overHeldSpot = true
                                                graphics.color(Color.YELLOW)
                                                graphics.alpha(0.2)
                                                graphics.rectangle(xx1,yy1,xx2,yy2)
                                                graphics.alpha(1)
                                            end
                                        end
                                    elseif controlStatus.fire(gamepad) == input.PRESSED and type(spell) == "table" then
                                        -- grab spell if clicked
                                        playerData.editor.heldThing = spellSlotIndex
                                    end
                                end
                                
                                -- draw spell details
                                if type(spell) == "table" and playerData.editor.heldThing == 0 then
                                    drewSomething = true
                                    drawInfoPopup(
                                        mouseX + invHUD.mouseHoverDistance,
                                        mouseY + invHUD.mouseHoverDistance,
                                        spell, player, "inv"
                                    )
                                    break
                                end
                            end
                        end
                    end
                    -- if not hovering over any spell
                    if not drewSomething then
                        
                        -- check for held stuff
                        if playerData.editor.heldThing ~= 0 then
                            if controlStatus.fire(gamepad) == input.RELEASED then
                                if playerData.editor.heldThing ~= wandIndex 
                                  and (not distortion or (distortion and player:get("artifact_lock_choice") + 1 ~= wandIndex)) then
                                    -- swap spells if held thing isnt the same wand slot
                                    reorderItemsOrSpells(player, playerData.editor.heldThing, wandIndex)
                                    resetSkillDescriptions(player)
                                    if playerData.selectedWand == playerData.editor.heldThing then
                                        playerData.selectedWand = wandIndex
                                    end
                                else
                                    getSound("inv", "item_move_denied"):play()
                                end
                                playerData.editor.heldThing = 0
                            elseif controlStatus.fire(gamepad) == input.HELD
                              and (not distortion or (distortion and player:get("artifact_lock_choice") + 1 ~= wandIndex)) then
                                if heldIndex <= 4 and heldSpell == 0 then
                                    overHeldSpot = true
                                    graphics.color(Color.YELLOW)
                                    graphics.alpha(0.2)
                                    graphics.rectangle(x1,y1,x2,y2)
                                    graphics.alpha(1)
                                end
                            end
                        elseif controlStatus.fire(gamepad) == input.PRESSED and type(wand) == "table"
                          and (not distortion or (distortion and player:get("artifact_lock_choice") + 1 ~= wandIndex)) then
                            -- grab wand if clicked
                            playerData.editor.heldThing = wandIndex
                        end
                        
                        if type(wand) == "table" and playerData.editor.heldThing == 0 then
                            -- draw wand details
                            drawInfoPopup(
                                mouseX + invHUD.mouseHoverDistance,
                                mouseY + invHUD.mouseHoverDistance,
                                wand, player, "inv"
                            )
                        end
                    end
                    break
                end
            end
            if not drewSomething then
                local invDeltaX, invDeltaY, invIndex = 0, 0, 0
                for i = 1, 2 do
                    invDeltaY = (invHUD.HUDSpellsSize + invHUD.invHUDSpellsDeltaY) * (i - 1)
                    for j = 1, 8 do
                        invDeltaX = (invHUD.HUDSpellsSize + invHUD.invHUDSpellsDeltaX) * (j - 1)
                        invIndex = j + 8 * (i - 1)
                        
                        if type(playerData.inventory[invIndex]) == "table"
                          and mouseX >= invCornerX + invHUD.invHUDCornerToSpellsX + invDeltaX
                          and mouseX <= invCornerX + invHUD.invHUDCornerToSpellsX + invHUD.HUDSpellsSize - 1 + invDeltaX
                          and mouseY >= drawCornerY + invHUD.invHUDCornerToSpellsY + invDeltaY
                          and mouseY <= drawCornerY + invHUD.invHUDCornerToSpellsY + invHUD.HUDSpellsSize - 1 + invDeltaY then
                            drewSomething = true
                            drawInfoPopup(
                                mouseX + invHUD.mouseHoverDistance,
                                mouseY + invHUD.mouseHoverDistance,
                                playerData.inventory[invIndex],
                                player
                            )
                            break
                        end
                    end
                    if drewSomething then
                        break
                    end
                end
            end
            
            if gamepad == nil and playerData.editor.heldThing ~= 0 and input.checkMouse("left") == input.RELEASED then
                -- hovering over nothing; drop
                -- this never happens using a controller
                dropHeldThing(player, playerData, heldIndex, heldSpell)
            end
            
            -- only go through color stuff if player isnt currently holding anything
            if playerData.editor.heldThing == 0 then
                -- check if touching anything color related
                if gamepad == nil and (mouseX >= colorCornerX + invHUD.colorHUDCornerToColorX + 1
                  and mouseX <= colorCornerX + invHUD.colorHUDCornerToColorX + invHUD.colorHUDColorSize - 1
                  and mouseY >= drawCornerY + invHUD.colorHUDCornerToColorY + 1
                  and mouseY <= drawCornerY + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize - 1)
                  or gamepad ~= nil and (cursorIndexI == #playerData.wands + #playerData.inventory + 1 and cursorIndexS == 1) then
                    -- color palette
                    if controlStatus.fire(gamepad) == input.HELD then
                        if gamepad == nil then
                            playerData.editor[playerData.editor.currentlyEditing].H = (mouseX - (colorCornerX + invHUD.colorHUDCornerToColorX + 1)) * 4
                            playerData.editor[playerData.editor.currentlyEditing].S = (invHUD.colorHUDColorSize - 2 - (mouseY - (drawCornerY + invHUD.colorHUDCornerToColorY + 1))) * 4
                        else
                            local dx, dy = controlStatus.hudMove(gamepad)
                            playerData.editor[playerData.editor.currentlyEditing].H = math.clamp(playerData.editor[playerData.editor.currentlyEditing].H + dx * 4, 0, 252)
                            playerData.editor[playerData.editor.currentlyEditing].S = math.clamp(playerData.editor[playerData.editor.currentlyEditing].S - dy * 4, 0, 252)
                        end
                    end
                elseif gamepad == nil and (mouseX >= colorCornerX + invHUD.colorHUDCornerToColorX + 1
                  and mouseX <= colorCornerX + invHUD.colorHUDCornerToColorX + invHUD.colorHUDColorSize - 1
                  and mouseY >= drawCornerY + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + 1
                  and mouseY <= drawCornerY + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + invHUD.colorHUDColorBrightHeight - 1)
                  or gamepad ~= nil and (cursorIndexI == #playerData.wands + #playerData.inventory + 1 and cursorIndexS == 2) then
                    -- brightness scale
                    if controlStatus.fire(gamepad) == input.HELD then
                        if gamepad == nil then
                            playerData.editor[playerData.editor.currentlyEditing].V = (invHUD.colorHUDColorSize - 2 - (mouseX - (colorCornerX + invHUD.colorHUDCornerToColorX + 1))) * 4
                        else
                            local dx, _ = controlStatus.hudMove(gamepad)
                            playerData.editor[playerData.editor.currentlyEditing].V = math.clamp(playerData.editor[playerData.editor.currentlyEditing].V - dx * 4, 0, 252)
                        end
                    end
                elseif gamepad == nil and (mouseX >= colorCornerX + invHUD.colorHUDCornerToShadingX
                  and mouseX <= colorCornerX + invHUD.colorHUDCornerToShadingX + invHUD.colorHUDShadingSize - 1
                  and mouseY >= drawCornerY + invHUD.colorHUDCornerToShadingY
                  and mouseY <= drawCornerY + invHUD.colorHUDCornerToShadingY + invHUD.colorHUDShadingSize - 1)
                  or gamepad ~= nil and (cursorIndexI == #playerData.wands + #playerData.inventory + 1 and cursorIndexS == 3) then
                    -- shading box
                    if controlStatus.fire(gamepad) == input.PRESSED then
                        playerData.editor.shading = not playerData.editor.shading
                    end
                elseif gamepad == nil and (mouseX >= colorCornerX + invHUD.colorHUDCornerToColorButtonsX
                  and mouseX <= colorCornerX + invHUD.colorHUDCornerToColorButtonsX + invHUD.colorHUDColorButtonsLength - 1
                  and mouseY >= drawCornerY + invHUD.colorHUDCornerToColorButtonsY
                  and mouseY <= drawCornerY + invHUD.colorHUDCornerToColorButtonsY + invHUD.colorHUDColorButtonsHeight
                    + (invHUD.colorHUDColorButtonsHeight + invHUD.colorHUDColorButtonsDelta) * 2 - 1)
                  or gamepad ~= nil and (cursorIndexI == #playerData.wands + #playerData.inventory + 2) then
                    -- color buttons
                    local deltaY = 0
                    for partIndex, part in ipairs(spriteParts) do
                        if gamepad == nil and (mouseY >= drawCornerY + invHUD.colorHUDCornerToColorButtonsY + deltaY
                          and mouseY <= drawCornerY + invHUD.colorHUDCornerToColorButtonsY + invHUD.colorHUDColorButtonsHeight + deltaY)
                          or gamepad ~= nil and (cursorIndexS == partIndex) then
                            if controlStatus.fire(gamepad) == input.PRESSED then
                                playerData.editor.currentlyEditing = part
                            end
                            break
                        end
                        deltaY = deltaY + invHUD.colorHUDColorButtonsHeight + invHUD.colorHUDColorButtonsDelta
                    end
                elseif gamepad == nil and (mouseX >= colorCornerX + invHUD.colorHUDCornerToApplyX
                  and mouseX <= colorCornerX + invHUD.colorHUDCornerToApplyX + invHUD.colorHUDApplyLength - 1
                  and mouseY >= drawCornerY + invHUD.colorHUDCornerToApplyY
                  and mouseY <= drawCornerY + invHUD.colorHUDCornerToApplyY + invHUD.colorHUDApplyHeight - 1)
                  or gamepad ~= nil and (cursorIndexI == #playerData.wands + #playerData.inventory + 3) then
                    -- apply changes button
                    if controlStatus.fire(gamepad) == input.PRESSED then
                        getSound("inv", "button_click"):play()
                        playerData.colors.shading = playerData.editor.shading
                        for _, part in ipairs(spriteParts) do
                            playerData.colors[part] = {}
                            for _, color in ipairs(hsv) do
                                playerData.colors[part][color] = playerData.editor[part][color]
                            end
                        end
                        
                        setPlayerSprites(player)
                        if net.host then
                            packets.casterSetSprite:sendAsHost(net.ALL, nil, player:getNetIdentity(), serializeColors(player))
                        else
                            packets.casterSetSprite:sendAsClient(player:getNetIdentity(), serializeColors(player))
                        end
                    end
                end
            end
            
            if not playerData.editor.wasOverHeldSpot and overHeldSpot then
                getSound("inv", "item_move_over_new_slot"):play()
            end
            playerData.editor.wasOverHeldSpot = overHeldSpot
            
            if gamepad ~= nil then
                playerData.lastCursorIndex.inv = cursorIndex
            end
        elseif playerData.pickWand ~= nil then
            if teleporting then
                playerData.pickWand = nil
                return
            end
        
            cursorIndex = playerData.lastCursorIndex.wandPick
            if gamepad == nil then
                cursorIndex = nil
            end
            local wandInst = playerData.pickWand
            -- check if the wand somehow got thanos'd
            if not wandInst:isValid() then
                player:set("activity", 0):set("activity_type", 0)
                playerData.pickWand = nil
                return
            end
            wandData = wandInst:getData()
            local wand, cost = wandData.wand, wandData.shop
        
            -- draw wand selection screen
            local pickedUpWandX, pickedUpWandY, cancelTextCenterX, cancelTextCenterY, wandListCornerX, wandListCornerY
              = HUDDrawWandSelection(drawCenterX, drawCenterY, hudW, hudH, wand, player, playerData, distortion and player:get("artifact_lock_choice") + 1 or -1)
            
            local cancelTextWidth, cancelTextHeight = graphics.textWidth("Cancel", graphics.FONT_DEFAULT), graphics.textHeight("Cancel", graphics.FONT_DEFAULT)
            
            if gamepad ~= nil then
                local dx, dy = controlStatus.hudMove(gamepad)
                for i = 1, 2 do
                    local turn = (i == 1) and dx or dy
                    local lockedSkill = player:get("artifact_lock_choice") + 1
                    if turn == dx then
                        if cursorIndex > 2 then
                            cursorIndex = math.clamp(cursorIndex + dx, 2 + (lockedSkill > 1 and 1 or 2), 2 + (lockedSkill < 4 and #playerData.wands or 3))
                            if cursorIndex - 2 == lockedSkill then
                                -- landed in locked skill, move one step forward
                                cursorIndex = cursorIndex + dx
                            end
                        end
                    else
                        if cursorIndex <= 2 and dy > 0 or cursorIndex == 2 and dy < 0 then
                            cursorIndex = cursorIndex + dy
                            if cursorIndex - 2 == lockedSkill then
                                -- oop wand 1 is locked, go to next
                                cursorIndex = cursorIndex + 1
                            end
                        elseif cursorIndex > 2 and dy < 0 then
                            cursorIndex = 2
                        end
                    end
                end
                
                if cursorIndex == 1 then
                    mouseX, mouseY = pickedUpWandX, pickedUpWandY
                elseif cursorIndex == 2 then
                    mouseX, mouseY = cancelTextCenterX, cancelTextCenterY
                else
                    mouseX, mouseY = wandListCornerX + (cursorIndex - 3) * (invHUD.pickWandBoxLength + 2), wandListCornerY
                end
            end
            
            local actionDone = false
            for i = 1, 2 do
                -- i == 1: picked wand
                -- i == 2: cancel button
                local x1, x2, y1, y2 = 0, 0, 0, 0
                if i == 1 then
                    x1, x2, y1, y2 = pickedUpWandX, pickedUpWandX + invHUD.pickWandBoxLength,
                      pickedUpWandY, pickedUpWandY + invHUD.pickWandBoxHeight
                else
                    x1, x2, y1, y2 = cancelTextCenterX - cancelTextWidth / 2, cancelTextCenterX + cancelTextWidth / 2,
                      cancelTextCenterY - cancelTextHeight / 2, cancelTextCenterY + cancelTextHeight / 2
                end
                if mouseX >= x1 and mouseX <= x2 and mouseY >= y1 and mouseY <= y2 then
                    -- draw highlight when hovering
                    graphics.color(Color.WHITE)
                    graphics.alpha(0.25)
                    graphics.rectangle(x1, y1, x2, y2)
                    graphics.alpha(1)
                    -- cancel picking wand if pressed
                    if controlStatus.select(gamepad, player) == input.PRESSED or controlStatus.fire(gamepad) == input.PRESSED then
                        player:set("activity", 0):set("activity_type", 0)
                        wandData.beingPicked = false
                        if net.host then
                            packets.lockWandObject:sendAsHost(net.ALL, nil, false, wandData.id)
                        else
                            packets.lockWandObject:sendAsClient(false, wandData.id)
                        end
                        playerData.pickWand = nil
                        playerData.preventFire = 1
                    end
                    
                    -- action done
                    actionDone = true
                    break
                end
            end
            if not actionDone then
                for wandIndex = 1, #playerData.wands do
                    local wandX = wandListCornerX + (wandIndex - 1) * (invHUD.pickWandBoxLength + 2)
                    if mouseX >= wandX and mouseX <= wandX + invHUD.pickWandBoxLength
                      and mouseY >= wandListCornerY and mouseY <= wandListCornerY + invHUD.pickWandBoxHeight
                      and (not distortion or (distortion and player:get("artifact_lock_choice") + 1 ~= wandIndex)) then
                        -- draw highlight when hovering
                        graphics.color(Color.WHITE)
                        graphics.alpha(0.25)
                        graphics.rectangle(
                            wandX, wandListCornerY,
                            wandX + invHUD.pickWandBoxLength, wandListCornerY + invHUD.pickWandBoxHeight
                        )
                        graphics.alpha(1)
                        
                        -- draw wand spells if hovered over (if the wand slot isnt empty)
                        local currPlayerWand = playerData.wands[wandIndex]
                        if type(currPlayerWand) == "table" then
                            local spellCornerX, spellCornerY = wandX + invHUD.wandHUDCornerToSpellsX, wandListCornerY + invHUD.wandHUDCornerToSpellsY
                            for spellCounter, spell in ipairs(currPlayerWand.spells) do
                                if type(spell) == "table" then
                                    local spellDeltaX = (spellCounter - 1) * (invHUD.HUDSpellsSize + invHUD.wandHUDSpellsDelta)
                                    if mouseX >= spellCornerX + spellDeltaX
                                      and mouseX <= spellCornerX + invHUD.HUDSpellsSize + spellDeltaX
                                      and mouseY >= spellCornerY
                                      and mouseY <= spellCornerY + invHUD.HUDSpellsSize then
                                        -- draw spell details
                                        drawInfoPopup(
                                            mouseX + invHUD.mouseHoverDistance,
                                            mouseY + invHUD.mouseHoverDistance,
                                            spell, player, "inv"
                                        )
                                        break
                                    end
                                end
                            end
                        end
                        
                        -- pick wand if pressed
                        if (controlStatus.select(gamepad, player) == input.PRESSED or controlStatus.fire(gamepad) == input.PRESSED) then
                            if misc.getGold() < cost then
                                -- if, for some reason, the player's gold is now less than the amount needed (shouldn't happen
                                --   under normal circunstances but some modder might've had a crappy idea), just cancel out
                                wandData.beingPicked = false
                                if net.host then
                                    packets.lockWandObject:sendAsHost(net.ALL, nil, false, wandData.id)
                                else
                                    packets.lockWandObject:sendAsClient(false, wandData.id)
                                end
                            else
                                if cost > 0 then
                                    -- deduct player gold
                                    misc.setGold(misc.getGold() - cost)
                                    -- play sound
                                    getSound("player", "shop"):play()
                                else
                                    getSound("player", "pickup", "wand"):play()
                                end
                                
                                -- swap wands
                                playerData.wands[wandIndex], wand = wand, playerData.wands[wandIndex]
                                
                                -- if player had no wands at the time, set this one as his selected one
                                if playerData.selectedWand <= 0 then
                                    playerData.selectedWand = wandIndex
                                end
                                
                                -- if swapped wand isn't empty, drop it
                                if type(wand) == "table" then
                                    local _, angle = spawnWandObject(wand, player.x, player.y)
                                    if net.host then
                                        packets.spawnWandObject:sendAsHost(net.ALL, nil, player.x, player.y, angle, serializeWand(wand))
                                    else
                                        packets.spawnWandObject:sendAsClient(player.x, player.y, angle, serializeWand(wand))
                                    end
                                end
                                
                                -- update hotbar
                                resetSkillDescriptions(player)
                                
                                -- destroy shop wand
                                if net.host then
                                    packets.destroyWandObject:sendAsHost(net.ALL, nil, wandData.id)
                                else
                                    packets.destroyWandObject:sendAsClient(wandData.id)
                                end
                                wandInst:destroy()
                            end
                            -- clear remaining stuff
                            player:set("activity", 0):set("activity_type", 0)
                            playerData.pickWand = nil
                            playerData.preventFire = 1
                        end
                        
                        -- action done
                        actionDone = true
                        break
                    end
                end
            end
            if gamepad ~= nil then
                playerData.lastCursorIndex.wandPick = cursorIndex
            end
        elseif playerData.openOptions then
            if teleporting then
                playerData.openOptions = false
                playerData.lastCursorIndex.options = 1
                return
            end
            
            cursorIndex = playerData.lastCursorIndex.options
            
            local controlList = gamepadConfigList()
            
            -- draw background
            graphics.color(Color.BLACK)
            graphics.alpha(0.9)
            graphics.rectangle(0, 0, hudW, hudH)
            graphics.alpha(1)
            
            -- move cursor and check actions
            local somethingTriggered = false
            local _, dy = controlStatus.hudMove(gamepad)
            if cursorIndex > 0 then
                if dy ~= 0 then
                    Sound.find("Click"):play()
                end
                cursorIndex = math.clamp(cursorIndex + dy, 1, #controlList + 1)
                -- skip aiming stick, for now
                if cursorIndex == #controlList - 1 then
                    cursorIndex = cursorIndex + dy
                end
            else
                somethingTriggered = true
                if cursorIndex == -(#controlList + 1) then
                    -- exit to game
                    playerData.openOptions = false
                    player:set("activity", 0):set("activity_type", 0)
                    playerData.lastCursorIndex.options = 1
                    return
                elseif cursorIndex == -#controlList then
                    -- dead zone
                    replaceControls("gamepad", "DEAD_ZONE", ((controlList[#controlList][3] * 10 + 1) % 10) / 10)
                    cursorIndex = -cursorIndex
                else
                    -- every other config
                    for _, button in ipairs(gamepadControlList()) do
                        if input.checkGamepad(button, gamepad) == input.PRESSED then
                            cursorIndex = -cursorIndex
                            Sound.find("Click"):play()
                            replaceControls("gamepad", controlList[cursorIndex][1], button)
                            break
                        end
                    end
                end
            end
            
            -- draw title
            drawOutlineText("GAME PAUSED", hudW/2, 16, Color.WHITE, Color.DARK_GREY,
                graphics.FONT_LARGE, graphics.ALIGN_MIDDLE, graphics.ALIGN_TOP)
            
            -- draw controls
            local drawY = hudH/2 - 16 * #controlList
            for controlIndex, control in ipairs(controlList) do
                local controlKey, controlName, controlValue = control[1], control[2], control[3]
                -- skip aiming stick, for now
                drawOutlineText(
                    controlName,
                    hudW/2, drawY,
                    (controlIndex == #controlList - 1 and Color.DARK_GREY or (controlIndex == math.abs(cursorIndex) and Color.WHITE or Color.LIGHT_GREY)),
                    Color.DARK_GREY,
                    graphics.FONT_DEFAULT, graphics.ALIGN_MIDDLE, graphics.ALIGN_TOP
                )
                local controlText = nil
                if controlIndex == #controlList then
                    controlText = (controlValue * 100) .. "%"
                elseif controlIndex == -cursorIndex then
                    controlText = "PRESS ANY KEY"
                else
                    controlText = getGamepadString(controlValue, player)
                end
                drawOutlineText(
                    controlText,
                    hudW/2 + graphics.textWidth(controlName, graphics.FONT_DEFAULT) / 2 + 8, drawY,
                    (controlIndex == math.abs(cursorIndex) and Color.WHITE or Color.LIGHT_GREY),
                    Color.DARK_GREY,
                    graphics.FONT_DEFAULT, graphics.ALIGN_LEFT, graphics.ALIGN_TOP
                )
                drawY = drawY + 16
            end
            graphics.color(Color.WHITE)
            
            -- draw back button
            drawOutlineText(
                "Back to Game",
                hudW/2, hudH - 32,
                (cursorIndex == #controlList + 1) and Color.WHITE or Color.LIGHT_GREY,
                Color.DARK_GREY,
                graphics.FONT_LARGE, graphics.ALIGN_MIDDLE, graphics.ALIGN_TOP
            )
            
            -- check for click
            if not somethingTriggered and controlStatus.select(gamepad, player) == input.PRESSED then
                cursorIndex = -cursorIndex
            end
            
            playerData.lastCursorIndex.options = cursorIndex
        end
        
        graphics.color(baseColor)
    end
end)

-- registercallback("onStageEntry", function()
    -- local handlerInst = graphics.bindDepth(5000, HUDHandler)
    -- handlerInst:getData().player = misc.players[1]
-- end, 5000)