-- made by Uziskull

--==== packets ====--
packets = {
    -- map objects
    syncMapObjects = net.Packet("caster_mapObj_sync", function(sender, clientRequested, ...)
        if net.host then
            -- client requested map objects
            packets.syncMapObjects:sendAsHost(net.DIRECT, sender, true, table.unpack(currentMapObjectList))
        else
            -- server sent map objects
            local currentStage = misc.director:get("stages_passed")
            if syncStageCounter ~= currentStage or clientRequested then
                syncStageCounter = currentStage
                local data = {...}
                local counter = 1
                while data[counter] ~= nil do
                    createMapObj(data[counter], data[counter+1], data[counter+2], table.unpack(data, counter+4, counter+4 + data[counter+3] - 1))
                    counter = counter+4 + data[counter+3]
                end
            end
        end
    end),
    trapSpawnObj = net.Packet("caster_mapObj_trap_spawnObj", function(_, diff, spawnIndex, x, y, nearestPlayer)
        if nearestPlayer ~= nil then
            nearestPlayer = nearestPlayer:resolve()
        end
        for i = 1, diff * 3 do
            pedestalSpawnableTraps[spawnIndex](x, y, nearestPlayer)
        end
    end),
    
    -- pickup
    spawnPickups = net.Packet("caster_pickup_spawn", function(_, x, y)
        spawnPickups(x, y)
    end),
    destroyPickup = net.Packet("caster_pickup_destroy", function(sender, pickupObj, id)
        for _, pickupInst in ipairs(pickupObj:findAll()) do
            if pickupInst:getData().id == id then
                pickupInst:destroy()
                break
            end
        end
        if net.host then
            packets.destroyPickup:sendAsHost(net.EXCLUDE, sender, pickupObj, id)
        end
    end),
    
    -- caster
    casterSetSprite = net.Packet("caster_caster_setSprite", function(sender, netTarget, ...)
        local target = netTarget:resolve()
        if target ~= nil then
            local args = {...}
            setPlayerSprites(target, table.unpack(args))
            if net.host then
                packets.casterSetSprite:sendAsHost(net.EXCLUDE, sender, netTarget, table.unpack(args))
            end
        end
    end),
    
    -- wands
    shootWand = net.Packet("caster_wand_shoot", function(sender, netActor, actorX, actorY, targetX, targetY, ...)
        local actor = netActor:resolve()
        if actor ~= nil then
            local args = {...}
            local wand = deserializeWand(args)
            shootWand(actor, wand, actorX, actorY, targetX, targetY)
            if net.host then
                packets.shootWand:sendAsHost(net.EXCLUDE, sender, netActor, actorX, actorY, targetX, targetY, table.unpack(args))
            end
        end
    end),
    spawnWandObject = net.Packet("caster_wand_spawnObj", function(sender, x, y, angle, ...)
        local args = {...}
        local wand = deserializeWand(args)
        spawnWandObject(wand, x, y, angle)
        if net.host then
            packets.spawnWandObject:sendAsHost(net.EXCLUDE, sender, x, y, angle, table.unpack(args))
        end
    end),
    destroyWandObject = net.Packet("caster_wand_destroyObj", function(sender, id)
        for _, wandInst in ipairs(wandObj:findAll()) do
            if wandInst:getData().id == id then
                wandInst:destroy()
                break
            end
        end
        if net.host then
            packets.destroyWandObject:sendAsHost(net.EXCLUDE, sender, id)
        end
    end),
    lockWandObject = net.Packet("caster_wand_lockObj", function(sender, lock, id)
        for _, wandInst in ipairs(wandObj:findAll()) do
            wandData = wandInst:getData()
            if wandData.id == id then
                wandData.beingPicked = lock
                break
            end
        end
        if net.host then
            packets.lockWandObject:sendAsHost(net.EXCLUDE, sender, lock, id)
        end
    end),
    
    -- spells
    spawnSpellObject = net.Packet("caster_spell_spawnObj", function(sender, x, y, ...)
        local args = {...}
        local spell = deserializeSpell(args)
        spawnSpellObject(spell, x, y)
        if net.host then
            packets.spawnSpellObject:sendAsHost(net.EXCLUDE, sender, x, y, table.unpack(args))
        end
    end),
    destroySpellObject = net.Packet("caster_spell_destroyObj", function(sender, id)
        for _, spellInst in ipairs(spellObj:findAll()) do
            if spellInst:getData().id == id then
                spellInst:destroy()
                break
            end
        end
        if net.host then
            packets.destroySpellObject:sendAsHost(net.EXCLUDE, sender, id)
        end
    end),
}