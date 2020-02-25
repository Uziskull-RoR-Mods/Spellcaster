------------------------------------------------------------------------
--  _          _ _                 -- If you're reading this, it      --
-- | |        | | |                -- means you had the curiosity to  --
-- | |__   ___| | | ___            -- come and check this out. And    --
-- | '_ \ / _ \ | |/ _ \           -- for that, I am grateful.        --
-- | | | |  __/ | | (_) |          --                                 --
-- |_| |_|\___|_|_|\___/           -- This code is pretty messy, but  --
--   __      _                _ _  -- I hope it gives you some ideas! --
--  / _|    (_)              | | | --                                 --
-- | |_ _ __ _  ___ _ __   __| | | -- May this code inspire you to do --
-- |  _| '__| |/ _ \ '_ \ / _` | | -- ever more complex and creative  --
-- | | | |  | |  __/ | | | (_| |_| -- things!                         --
-- |_| |_|  |_|\___|_| |_|\__,_(_) --                                 --
--                                 --    -- Uziskull                  --
------------------------------------------------------------------------

--==== global variables and functions ====--
emptySprite = Sprite.load("caster_empty_sprite", "spr/empty", 1, 0, 0)

--=== useful function that saturn should include in rorml but he won't because he sucks ===--
function drawOutlineText(text, x, y, colorText, colorOutline, font, halign, valign)
    colorText = colorText or Color.WHITE
    colorOutline = colorOutline or Color.DARK_GREY
    local currColor = graphics.getColor()
    
    graphics.color(colorOutline)
    for i = -1, 1 do
        for j = -1, 1 do
            if i ~= 0 or j ~= 0 then graphics.print(text, x + i, y + j, font, halign, valign) end
        end
    end
    
    graphics.color(colorText)
    graphics.print(text, x, y, font, halign, valign)

    graphics.color(currColor)
end

function roundNumber(number, decimal)
    return tonumber(string.format("%." .. (decimal or 0) .. "f", number))
end

function normalizeVector(vec)
    local len = math.sqrt(vec[1] * vec[1] + vec[2] * vec[2])
    return {vec[1] / len, vec[2] / len}
end

function shuffleCopy(t1)
  local size = #t1
  local t2 = {}
  for i = 1, size do
    t2[i] = t1[i]
  end
  for i = size, 1, -1 do
    local rand = math.random(i)
    t2[i], t2[rand] = t2[rand], t2[i]
  end
  return t2
end

function withinPickupRange(player, thing)
    -- range is ~~24x24~~ 30x30
    local thingCenterX, thingCenterY = thing.x - thing.sprite.xorigin + thing.sprite.width / 2, thing.y - thing.sprite.yorigin + thing.sprite.height / 2
    return math.abs(player.x - thingCenterX) <= 15 and math.abs(player.y - thingCenterY) <= 15
end

function getPlayerIndex(player)
    local index = 1
    for i, p in ipairs(misc.players) do
        if p == player then
            index = i
            break
        end
    end
    return index
end

--==== loading dummy functions ====--

function drawInfoPopup(x, y, thing, player, isWandPick) end             -- replaced by "hud"'s implementation
function setPlayerSprites(player, ...) end                              -- replaced by "caster"'s implementation
function shootWand(actor, wand, actorX, actorY, targetX, targetY) end   -- replaced by "wands"'s implementation

--==== loading actual stuff ====--

DEBUG_MODE = modloader.checkFlag("spellcaster_debug_mode")

casterSurvivorID = #Survivor.findAll("Vanilla")
for _, modspace in ipairs(modloader.getMods()) do
    casterSurvivorID = casterSurvivorID + #Survivor.findAll(modspace)
end
caster = Survivor.new("Spellcaster")
projObj = Object.new("caster_spell_projectile")
spellObj = Object.new("caster_spell_object")
wandObj = Object.new("caster_wand_object")

-- require("semver")  TODO: check version for online shennanigans

require("src/hotkeys")
loadConfig()
require("src/sounds")

require("src/net")

require("src/spells")
require("src/wands")
require("src/mapobjects")
require("src/pickup")
require("src/caster")
require("src/hud")

require("src/lobby")