lib.locale()
local config = require('config')

local timer = nil
local defaultPayPeriod = config.defaultPayPeriod
local insideZones = {}

local function getActiveZone()
    local index = insideZones[#insideZones]
    return index, index and config.socialZones[index]
end

local function isDead()
    local state = LocalPlayer.state
    return state.isDead or state.dead or IsEntityDead(cache.ped)
end

local function startPayTimer()
    if timer then return end

    timer = Citizen.CreateThread(function()
        local elapsed = 0
        while #insideZones > 0 do
            Wait(1000)
            if config.payWhenDead or not isDead() then
                elapsed += 1
            end
            local index, zone = getActiveZone()
            if zone and elapsed >= (zone.payPeriod or defaultPayPeriod) * 60 then
                elapsed = 0
                TriggerServerEvent('s4t4n667_socialzones:payPlayer', index)
            end
        end
        timer = nil
    end)
end

local function removeInsideZone(index)
    for i = #insideZones, 1, -1 do
        if insideZones[i] == index then
            table.remove(insideZones, i)
        end
    end
end

for index, zone in ipairs(config.socialZones) do
    local hasIcon = zone.icon and zone.icon ~= ''
    local hasColor = zone.iconColor and zone.iconColor ~= ''
    local iconIn = hasIcon and zone.icon or 'check'
    local colorIn = hasColor and zone.iconColor or config.notifications.enterColor
    local iconOut = hasIcon and zone.icon or 'xmark'
    local colorOut = hasColor and zone.iconColor or config.notifications.leaveColor

    local centreZ = (zone.minZ + zone.maxZ) / 2
    local points = {}
    for i, point in ipairs(zone.points) do
        points[i] = vec3(point.x, point.y, centreZ)
    end

    lib.zones.poly({
        name = zone.name,
        points = points,
        thickness = zone.maxZ - zone.minZ,
        debug = config.debug,
        onEnter = function()
            removeInsideZone(index)
            insideZones[#insideZones + 1] = index
            lib.notify({ title = zone.name, description = locale('zone.enter'), icon = iconIn, iconColor = colorIn, position = config.notifications.position })
            startPayTimer()
        end,
        onExit = function()
            removeInsideZone(index)
            lib.notify({ title = zone.name, description = locale('zone.leave'), icon = iconOut, iconColor = colorOut, position = config.notifications.position })
        end,
    })
end
