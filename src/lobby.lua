-- made by Uziskull

local function colorHUD(inst, frames)
    local instData = inst:getData()
    local hudW, hudH = graphics.getGameResolution()
    local mouseX, mouseY = input.getMousePos()
    if frames == 1 then
        -- fake a playerData table
        instData.inventory, instData.wands = {}, {}
        for i = 1, 16 do instData.inventory[#instData.inventory] = 0 end
        for i = 1, 4  do instData.wands[#instData.wands] = 0         end
        instData.colors = getSavedColors()
        instData.editor = {
            currentlyEditing = spriteParts[1],
            shading = instData.colors.shading,
            heldThing = 0,
            wasOverHeldSpot = false
        }
        for _, part in ipairs(spriteParts) do
            instData.editor[part] = {}
            for _, color in ipairs(hsv) do
                instData.editor[part][color] = instData.colors[part][color]
            end
        end
        
        -- drop down
        instData.dropDown = true
    end
    if frames == 1 or instData.prevHudW ~= nil and instData.prevHudW ~= hudW then
        inst.x, inst.y = hudW - invHUD.colorHUDLength - 16, 64
        instData.heldX, instData.heldY = nil, nil
    end
    if instData.heldX ~= nil and instData.heldY ~= nil then
        inst.x, inst.y = mouseX - instData.heldX, mouseY - instData.heldY
    end
    
    local prePlayer = Object.find("PrePlayer"):find(1)
    if prePlayer ~= nil and prePlayer:get("class") == casterSurvivorID then
        local gamepad = nil
        
        -- draw stuff
        graphics.color(hud.lightFillColor)
        graphics.rectangle(inst.x, inst.y - 16, inst.x + invHUD.colorHUDLength - 1, inst.y - 1)
        graphics.color(hud.borderColor)
        graphics.rectangle(inst.x, inst.y - 16, inst.x + invHUD.colorHUDLength - 1, inst.y - 1)
        drawOutlineText("Color Picker", inst.x + 5, inst.y - 7, nil, nil, nil, nil, graphics.ALIGN_CENTER)
        graphics.color(hud.indentColor)
        graphics.triangle(
            inst.x + invHUD.colorHUDLength - 8 - 4, inst.y - (instData.dropDown and 0 or 8) - 4,
            inst.x + invHUD.colorHUDLength - 4,     inst.y - (instData.dropDown and 0 or 8) - 4,
            inst.x + invHUD.colorHUDLength - 4 - 4, inst.y - (instData.dropDown and 8 or 0) - 4
        )
        if instData.dropDown then
            HUDDrawColorPalette(inst.x, inst.y, instData, -1)--cursorIndex)
        end
        
        -- input
        if mouseX >= inst.x and mouseX <= inst.x + invHUD.colorHUDLength and mouseY >= inst.y - 16 and mouseY <= inst.y then
            if controlStatus.fire(gamepad) == input.PRESSED then
                instData.dropDown = not instData.dropDown
                instData.heldX, instData.heldY = mouseX - inst.x, mouseY - inst.y
            elseif controlStatus.fire(gamepad) == input.RELEASED or controlStatus.fire(gamepad) == input.NEUTRAL then
                instData.heldX, instData.heldY = nil, nil
            end
        elseif instData.dropDown then
            -- check if touching anything color related
            if mouseX >= inst.x + invHUD.colorHUDCornerToColorX + 1
              and mouseX <= inst.x + invHUD.colorHUDCornerToColorX + invHUD.colorHUDColorSize - 1
              and mouseY >= inst.y + invHUD.colorHUDCornerToColorY + 1
              and mouseY <= inst.y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize - 1 then
                -- color palette
                if controlStatus.fire(gamepad) == input.HELD then
                    if gamepad == nil then
                        instData.editor[instData.editor.currentlyEditing].H = (mouseX - (inst.x + invHUD.colorHUDCornerToColorX + 1)) * 4
                        instData.editor[instData.editor.currentlyEditing].S = (invHUD.colorHUDColorSize - 2 - (mouseY - (inst.y + invHUD.colorHUDCornerToColorY + 1))) * 4
                    else
                        local dx, dy = controlStatus.hudMove(gamepad)
                        instData.editor[instData.editor.currentlyEditing].H = math.clamp(instData.editor[instData.editor.currentlyEditing].H + dx * 4, 0, 252)
                        instData.editor[instData.editor.currentlyEditing].S = math.clamp(instData.editor[instData.editor.currentlyEditing].S - dy * 4, 0, 252)
                    end
                end
            elseif mouseX >= inst.x + invHUD.colorHUDCornerToColorX + 1
              and mouseX <= inst.x + invHUD.colorHUDCornerToColorX + invHUD.colorHUDColorSize - 1
              and mouseY >= inst.y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + 1
              and mouseY <= inst.y + invHUD.colorHUDCornerToColorY + invHUD.colorHUDColorSize + invHUD.colorHUDColorDelta + invHUD.colorHUDColorBrightHeight - 1 then
                -- brightness scale
                if controlStatus.fire(gamepad) == input.HELD then
                    if gamepad == nil then
                        instData.editor[instData.editor.currentlyEditing].V = (invHUD.colorHUDColorSize - 2 - (mouseX - (inst.x + invHUD.colorHUDCornerToColorX + 1))) * 4
                    else
                        local dx, _ = controlStatus.hudMove(gamepad)
                        instData.editor[instData.editor.currentlyEditing].V = math.clamp(instData.editor[instData.editor.currentlyEditing].V - dx * 4, 0, 252)
                    end
                end
            elseif mouseX >= inst.x + invHUD.colorHUDCornerToShadingX
              and mouseX <= inst.x + invHUD.colorHUDCornerToShadingX + invHUD.colorHUDShadingSize - 1
              and mouseY >= inst.y + invHUD.colorHUDCornerToShadingY
              and mouseY <= inst.y + invHUD.colorHUDCornerToShadingY + invHUD.colorHUDShadingSize - 1 then
                -- shading box
                if controlStatus.fire(gamepad) == input.PRESSED then
                    instData.editor.shading = not instData.editor.shading
                end
            elseif mouseX >= inst.x + invHUD.colorHUDCornerToColorButtonsX
              and mouseX <= inst.x + invHUD.colorHUDCornerToColorButtonsX + invHUD.colorHUDColorButtonsLength - 1
              and mouseY >= inst.y + invHUD.colorHUDCornerToColorButtonsY
              and mouseY <= inst.y + invHUD.colorHUDCornerToColorButtonsY + invHUD.colorHUDColorButtonsHeight
                + (invHUD.colorHUDColorButtonsHeight + invHUD.colorHUDColorButtonsDelta) * 2 - 1 then
                -- color buttons
                local deltaY = 0
                for partIndex, part in ipairs(spriteParts) do
                    if mouseY >= inst.y + invHUD.colorHUDCornerToColorButtonsY + deltaY
                      and mouseY <= inst.y + invHUD.colorHUDCornerToColorButtonsY + invHUD.colorHUDColorButtonsHeight + deltaY then
                        if controlStatus.fire(gamepad) == input.PRESSED then
                            instData.editor.currentlyEditing = part
                        end
                        break
                    end
                    deltaY = deltaY + invHUD.colorHUDColorButtonsHeight + invHUD.colorHUDColorButtonsDelta
                end
            elseif mouseX >= inst.x + invHUD.colorHUDCornerToApplyX
              and mouseX <= inst.x + invHUD.colorHUDCornerToApplyX + invHUD.colorHUDApplyLength - 1
              and mouseY >= inst.y + invHUD.colorHUDCornerToApplyY
              and mouseY <= inst.y + invHUD.colorHUDCornerToApplyY + invHUD.colorHUDApplyHeight - 1 then
                -- apply changes button
                if controlStatus.fire(gamepad) == input.PRESSED then
                    getSound("inv", "button_click"):play()
                    instData.colors.shading = instData.editor.shading
                    for _, part in ipairs(spriteParts) do
                        instData.colors[part] = {}
                        for _, color in ipairs(hsv) do
                            instData.colors[part][color] = instData.editor[part][color]
                        end
                    end
                    
                    setPlayerSprites(inst)
                end
            end
        end
    end
end

registercallback("globalRoomStart", function(room)
    if room:getOrigin() ~= "Vanilla" then return end
    if room:getName() == "SelectMult" then
        graphics.bindDepth(-10, colorHUD)
    end
end)