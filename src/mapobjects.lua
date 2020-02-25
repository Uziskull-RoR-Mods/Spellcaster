-- made by Uziskull

local mapObjSpr = {
    pedestal = Sprite.load("caster_mapobjspr_pedestal", "spr/mapobjects/pedestal", 1, 6, 18),
    pedestalTrigger = Sprite.load("caster_mapobjspr_pedestal_trigger", "spr/mapobjects/pedestal_trigger", 8, 6, 18),
    shop = Sprite.load("caster_mapobjspr_shop", "spr/mapobjects/shop", 1, 31, 11) -- 22, 11)
}

local function getCurrentDiff()
    local diff = misc.hud:get("difficulty")
    local diffList = {"Very Easy", "Easy", "Medium", "Hard", "Very Hard", "Insane", "Impossible", "I SEE YOU", "IM COMING FOR YOU", "HAHAHAHA"}
    for index, text in ipairs(diffList) do
        if text == diff then
            return index + 1
        end
    end
    return 1 -- failsafe
end

pedestalSpawnableTraps = {
    function(x, y, player)
        local inst = Object.find("EfGrenadeEnemy"):create(x, y)
        inst:set("bounces", 2)
    end,
    function(x, y, player)
        local inst = Object.find("EfMissileEnemy"):create(x, y)
        if player ~= nil then
            inst:set("parent", player.id)
                :set("damage", player:get("damage") / 2)
        end
    end
}

local pedestalObj = Object.new("caster_mapobj_pedestal")
pedestalObj.sprite = mapObjSpr.pedestal
pedestalObj:addCallback("step", function(self)
    mapobjData = self:getData()
    if mapobjData.trap == 3 then
        self.subimage = mapObjSpr.pedestalTrigger.frames
    elseif mapobjData.trap == 2 then
        if self.sprite ~= mapObjSpr.pedestalTrigger then
            self.sprite = mapObjSpr.pedestalTrigger
        end
        mapobjData.trapanim = mapobjData.trapanim + 1
        self.subimage = math.floor(mapobjData.trapanim / 5)
        if mapobjData.trapanim == 5 * mapObjSpr.pedestalTrigger.frames then
            mapobjData.trap = 3
        end
    elseif not mapobjData.wandInst:isValid() and mapobjData.trap == 1 then
        -- trigger trap
        mapobjData.trap = 2
        self.sprite = mapObjSpr.pedestalTrigger
        
        -- spawn something idk
        if not net.online or (net.online and net.host) then
            local diff = getCurrentDiff()
            local spawnIndex = math.random(#pedestalSpawnableTraps)
            local nearestPlayer = Object.find("P"):findNearest(self.x, self.y)
            for i = 1, diff * 3 do
                pedestalSpawnableTraps[spawnIndex](self.x, self.y, nearestPlayer)
            end
            if nearestPlayer ~= nil then
                nearestPlayer = nearestPlayer:getNetIdentity()
            end
            packets.trapSpawnObj:sendAsHost(net.ALL, nil, diff, spawnIndex, self.x, self.y, nearestPlayer)
        end
    end
end)

local shopObj = Object.new("caster_mapobj_shop")
shopObj.sprite = mapObjSpr.shop
shopObj:addCallback("draw", function(self)
    mapobjData = self:getData()
    for i, thing in pairs(mapobjData.items) do
        -- check if thing has already been picked up
        if thing ~= nil and thing:isValid() then
            local thingData = thing:getData()
            graphics.color(Color.ROR_YELLOW)
            graphics.print(
                thingData.shop,
                self.x + 23 * (i - 2), self.y - self.sprite.height * 2 - 5,
                graphics.FONT_DAMAGE, graphics.ALIGN_MIDDLE, graphics.ALIGN_BOTTOM
            )
        end
    end
end)

function createMapObj(obj, x, y, ...)
    local self = obj:create(x, y)
    mapobjData = self:getData()
    local data = {...}
    
    if obj == pedestalObj then
        local genWand, genTrap = nil, 0
        if #data > 0 then
            local wandT = {}
            for i = 1, data[2] do
                table.insert(wandT, data[2 + i])
            end
            genWand = deserializeWand(wandT)
            genTrap = data[1]
        else
            genWand = generateRandomWand()
            genTrap = math.random(5) == 1 and 1 or 0
        end
    
        local wandInst = wandObj:create(self.x, self.y - self.sprite.height)
        wandInst.depth = self.depth - 1
        wandData = wandInst:getData()
        wandData.wand = genWand
        wandData.shop = 0
        
        mapobjData.wandInst = wandInst
        mapobjData.trap = genTrap
        mapobjData.trapanim = 0
    elseif obj == shopObj then
        mapobjData.sellSpells = false
        local things = nil
        if #data > 0 then
            mapobjData.sellSpells = data[1]
            things = {}
            local currCounter = 2
            for i = 1, 3 do
                local thing = {table.unpack(data, currCounter + 1, currCounter + data[currCounter])}
                table.insert(things, mapobjData.sellSpells and deserializeSpell(thing) or deserializeWand(thing))
                currCounter = currCounter + data[currCounter] + 1
            end
        else
            mapobjData.sellSpells = math.random(2) == 1
            if mapobjData.sellSpells then
                things = {getRandomWeightedSpell(), getRandomWeightedSpell(), getRandomWeightedSpell()}
            else
                things = {generateRandomWand(), generateRandomWand(), generateRandomWand()}
            end
        end
        
        mapobjData.items = {}
        for i = 1, 3 do
            if mapobjData.sellSpells then
                local spellInst = spellObj:create(self.x + 23 * (i - 2), self.y - self.sprite.height)
                spellInst.depth = self.depth - 1
                spellData = spellInst:getData()
                spellData.spell = things[i]
                spellData.shop = math.ceil(50 * ((2 * misc.director:get("enemy_buff")) - 1))
                
                mapobjData.items[i] = spellInst
            else
                local wandInst = wandObj:create(self.x + 23 * (i - 2), self.y - self.sprite.height)
                wandInst.depth = self.depth - 1
                wandData = wandInst:getData()
                wandData.wand = things[i]
                wandData.shop = math.ceil(50 * ((2 * misc.director:get("enemy_buff")) - 1))
                
                mapobjData.items[i] = wandInst
            end
        end
    end
    return self
end

--==== networking ====--

function serializeMapObj(createdMapObj)
    local obj = createdMapObj:getObject()
    mapobjData = createdMapObj:getData()
    if obj == pedestalObj then
        local serializedWand = {serializeWand(wandData.wand)}
        return mapobjData.trap, #serializedWand, table.unpack(serializedWand)
    elseif obj == shopObj then
        local sellSpells = mapobjData.sellSpells
        local concatWands = {sellSpells}
        for i = 1, 3 do
            local thing = nil
            if sellSpells then
                thing = {serializeSpell(mapobjData.items[i]:getData().spell)}
            else
                thing = {serializeWand(mapobjData.items[i]:getData().wand)}
            end
            local thingLen = #thing
            table.insert(concatWands, thingLen)
            for j = 1, thingLen do
                table.insert(concatWands, thing[j])
            end
        end
        return table.unpack(concatWands)
    end
end

-- syncing map objects is kinda rough since its basically a race condition between client/server
-- "solution": keep a stage counter, everytime the objects sync you set this
-- make server send info and client request it, whichever reaches first will sync it and lock the other one out
syncStageCounter = -1

-- reset counter after every playthrough
registercallback("onGameStart", function()
    syncStageCounter = -1
end, 5000)

-- client callback
registercallback("onStageEntry", function()
    local currentStage = misc.director:get("stages_passed")
    if syncStageCounter ~= currentStage then
        syncStageCounter = currentStage
        packets.syncMapObjects:sendAsClient()
    end
end)

-- list containing current map objects
-- for syncing purposes
currentMapObjectList = {}

-- server callback
registercallback("onStageEntry", function()
    if not net.online or (net.online and net.host) then
        local casterExists = false
        for _, player in ipairs(misc.players) do
            if player:getSurvivor() == caster then
                casterExists = true
                break
            end
        end
        if casterExists then
            local spawnLimit = math.random(3, 5)
            
            currentMapObjectList = {}
            local floorList = Object.find("B", "vanilla"):findAll()
            for i = 1, spawnLimit do
                local index = math.random(#floorList)
                
                local spObj = shopObj
                if math.random(2) == 1 then
                    spObj = pedestalObj
                end
                
                local dummyObj = spObj:create(floorList[index].x, floorList[index].y - 1)
                
                local attempts = 20
                while attempts > 0 and (dummyObj:collidesMap(dummyObj.x, dummyObj.y)
                  or dummyObj:collidesWith(shopObj, dummyObj.x, dummyObj.y)
                  or dummyObj:collidesWith(pedestalObj, dummyObj.x, dummyObj.y)) do
                    attempts = attempts - 1
                    index = math.random(#floorList)
                    dummyObj.x, dummyObj.y = floorList[index].x, floorList[index].y
                    --log("tried again")
                end
                local createdObj = createMapObj(spObj, dummyObj.x, dummyObj.y)
                dummyObj:destroy()
                
                local serializedObj = {serializeMapObj(createdObj)}
                local objData = {spObj, createdObj.x, createdObj.y, #serializedObj, table.unpack(serializedObj)}
                for j = 1, #objData do
                    currentMapObjectList[#currentMapObjectList + 1] = objData[j]
                end
            end
            packets.syncMapObjects:sendAsHost(net.ALL, nil, false, table.unpack(currentMapObjectList))
        end
    end
end)