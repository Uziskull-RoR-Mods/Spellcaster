-- made by Uziskull

local CONST_MAX_FUEL_INCREASE = 20

--==== scepter boost ====--
caster:addCallback("scepter", function(player)
    playerData = player:getData()
    -- TODO: actually make some sort of wand selection instead of boosting every wand lmfao
    for i = 1, #playerData.wands do
        if type(playerData.wands[i]) == "table" and not playerData.wands[i].boosted then
            playerData.wands[i] = scepterBoostWand(playerData.wands[4])
        end
    end
    
    -- TODO: if you end up changing icon to make it "boosted", call this
    --resetSkillDescriptions(player)
end)

registercallback("onItemPickup", function(item, player)
    if player:getSurvivor() == caster then
        playerData = player:getData()
        local itemObj = item:getObject()
        if itemObj == Object.find("Jetpack") then
            -- Rusty Jetpack
            -- boost max fuel
            playerData.maxFuel = playerData.maxFuel + CONST_MAX_FUEL_INCREASE
        end
    end
end)

registercallback("onUseItemUse", function(player, item)
    if player:getSurvivor() == caster then
        playerData = player:getData()
        if item == Item.find("Gigantic Amethyst") then
            -- Gigantic Amethyst (honestly should make you go faster)
            -- reset every wand cooldown
            for _, wand in ipairs(playerData.wands) do
                if type(wand) == "table" then
                    wand.cooldown, wand.spellDelay = 0, 0
                end
            end
        end
    end
end)