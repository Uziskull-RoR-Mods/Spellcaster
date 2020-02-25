-- made by Uziskull

local controls = {
    keyboard = {
        INVENTORY_KEY = "i",
        MOUSE_FIRE = "left"
    },
    gamepad = {
        INVENTORY_KEY = "shoulderlb",
        FIRE_KEY = "shoulderrb",
        SCROLL_UP = "shoulderl", SCROLL_DOWN = "shoulderr",
        AIM_STICK_HORIZONTAL = "rh", AIM_STICK_VERTICAL = "rv",
        DEAD_ZONE = 0
    }
}

local lastAxis = {x = 1, y = 0}
local HOLDING_FRAMES_AXIS, HOLDING_FRAMES_SCROLL = 10, 15
local holdingAxis, holdingScroll = 0, 0

local function computeEffectiveAxis(axis)
    return (axis / math.abs(axis))*(math.max(math.abs(axis) - controls.gamepad.DEAD_ZONE, 0))/(1 - controls.gamepad.DEAD_ZONE)
end

controlStatus = {
    inventory = function(gamepad)
        if gamepad ~= nil then
            return input.checkGamepad(controls.gamepad.INVENTORY_KEY, gamepad)
        else
            return input.checkKeyboard(controls.keyboard.INVENTORY_KEY)
        end
    end,
    fire = function(gamepad)
        if gamepad ~= nil then
            return input.checkGamepad(controls.gamepad.FIRE_KEY, gamepad)
        else
            return input.checkMouse(controls.keyboard.MOUSE_FIRE)
        end
    end,
    select = function(gamepad, player)
        if gamepad ~= nil then
            return input.checkControl("jump", player)
        else
            return input.checkMouse(controls.keyboard.MOUSE_FIRE)
        end
    end,
    scroll = function(gamepad)
        if gamepad ~= nil then
            if input.checkGamepad(controls.gamepad.SCROLL_UP, gamepad) == input.HELD
              or input.checkGamepad(controls.gamepad.SCROLL_DOWN, gamepad) == input.HELD then
                holdingScroll = (holdingScroll + 1) % HOLDING_FRAMES_SCROLL
            else
                holdingScroll = 0
            end
            if input.checkGamepad(controls.gamepad.SCROLL_UP, gamepad) == input.HELD and holdingScroll == 0
              or input.checkGamepad(controls.gamepad.SCROLL_UP, gamepad) == input.PRESSED then
                return -1
            elseif input.checkGamepad(controls.gamepad.SCROLL_DOWN, gamepad) == input.HELD and holdingScroll == 0
              or input.checkGamepad(controls.gamepad.SCROLL_DOWN, gamepad) == input.PRESSED then
                return 1
            else
                return 0
            end
        else
            return input.getMouseScroll()
        end
    end,
    mouse = function(gamepad, player)
        if gamepad ~= nil then
            local jx, jy = input.getGamepadAxis(controls.gamepad.AIM_STICK_HORIZONTAL, gamepad),
                input.getGamepadAxis(controls.gamepad.AIM_STICK_VERTICAL, gamepad)
            if math.sqrt(jx*jx + jy*jy) <= controls.gamepad.DEAD_ZONE then
                jx, jy = lastAxis.x, lastAxis.y
            else
                lastAxis.x, lastAxis.y = jx, jy
            end
            -- note: it's unnecessary to multiply by anything, but fractional numbers are spoopy so you never know
            return player.x + 10 * computeEffectiveAxis(jx),
                player.y + 10 * computeEffectiveAxis(jy)
        else
            return input.getMousePos()
        end
    end,
    -- ehhhh this one's iffy, but whatever really
    escape = function(gamepad)
        if gamepad ~= nil then
            return input.checkGamepad("start", gamepad)
        else
            return input.checkKeyboard("Escape")
        end
    end,
    -- gamepad only, for hud selection shennanigans
    hudMove = function(gamepad)
        local PERCENTAGE_NEEDED = 0.20
        if gamepad ~= nil then
            local jx, jy = input.getGamepadAxis(controls.gamepad.AIM_STICK_HORIZONTAL, gamepad),
                input.getGamepadAxis(controls.gamepad.AIM_STICK_VERTICAL, gamepad)
            jx, jy = computeEffectiveAxis(jx), computeEffectiveAxis(jy)
            if (math.abs(jx) > PERCENTAGE_NEEDED and math.abs(jy) <= PERCENTAGE_NEEDED)
              or (math.abs(jy) > PERCENTAGE_NEEDED and math.abs(jx) <= PERCENTAGE_NEEDED) then
                holdingAxis = (holdingAxis + 1) % HOLDING_FRAMES_AXIS
            else
                holdingAxis = 0
            end
            if jx > PERCENTAGE_NEEDED and holdingAxis == 0 then
                jx = 1
            elseif jx < -PERCENTAGE_NEEDED and holdingAxis == 0 then
                jx = -1
            else
                jx = 0
            end
            if jy > PERCENTAGE_NEEDED and holdingAxis == 0 then
                jy = 1
            elseif jy < -PERCENTAGE_NEEDED and holdingAxis == 0 then
                jy = -1
            else
                jy = 0
            end
            return jx, jy
        end
    end
}

function gamepadConfigList()
    --return pairs(controls.gamepad)
    
    -- for now, let's return a very specific table
    return {
        {"INVENTORY_KEY", "Open/Close Inventory:", controls.gamepad.INVENTORY_KEY},
        {"FIRE_KEY", "Fire Wand:", controls.gamepad.FIRE_KEY},
        {"SCROLL_UP", "Prev. Wand:", controls.gamepad.SCROLL_UP},
        {"SCROLL_DOWN", "Next Wand:", controls.gamepad.SCROLL_DOWN},
        {"AIM_STICK", "Aim Stick:", "stickr"},
        {"DEAD_ZONE", "Deadzone:", controls.gamepad.DEAD_ZONE}
    }
end

function replaceControls(type, key, value)
    controls[type][key] = value
end

local gamepadTypeCache = nil
registercallback("onGameStart", function()
    gamepadTypeCache = nil
end)

local joystickSymbols = {
    face1 =         {"¢", "®", "º"},
    face2 =         {"£", "¯", "»"},
    face3 =         {"¤", "°", "¼"},
    face4 =         {"¥", "±", "½"},
    shoulderl =     {"¦", "²", "¾"},
    shoulderr =     {"§", "³", "¿"},
    shoulderlb =    {"¨", "´", "À"},
    shoulderrb =    {"©", "µ", "Á"},
    stickl =        {"ª", "¶", "Â"},
    stickr =        {"«", "·", "Ã"},
    select =        {"¬", "¸", "Ä"},
    start =         {"­", "¹", "Å"}
}

function getGamepadString(control, player)
    if gamepadTypeCache == nil then
        local jumpSym = input.getControlString("jump", player)
        for _, syms in pairs(joystickSymbols) do
            for type = 1, 3 do
                if syms[type] == jumpSym then
                    gamepadTypeCache = type
                    break
                end
            end
            if gamepadTypeCache ~= nil then
                break
            end
        end
    end
    return joystickSymbols[control][gamepadTypeCache]
end

function gamepadControlList()
    local t = {}
    for k, _ in pairs(joystickSymbols) do
        t[#t + 1] = k
    end
    return t
end

function loadConfig()
    -- for k1, t in pairs(controls) do
        -- for k2, _ in pairs(t) do
            -- local savedValue = save.read(k1.."-"..k2)
            -- if savedValue ~= nil then
                -- t[k2] = savedValue
            -- end
        -- end
    -- end
    
    -- only gamepad bois need configurable controls, the others can suck it
    for key, _ in pairs(controls.gamepad) do
        local savedValue = save.read("gamepad-"..key)
        if savedValue ~= nil then
            controls.gamepad[key][2] = savedValue
        end
    end
end

function saveConfig()
    -- for k1, t in pairs(controls) do
        -- for k2, value in pairs(t) do
            -- save.write(k1.."-"..k2, value)
        -- end
    -- end
    
    -- only gamepad bois need configurable controls, the others can suck it
    for key, value in pairs(controls.gamepad) do
        save.write("gamepad-"..key, value[2])
    end
end