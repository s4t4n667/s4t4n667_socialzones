lib.locale()
local config = require('config')
lib.versionCheck('s4t4n667/s4t4n667_socialzones')

local defaultPayPeriod = config.defaultPayPeriod
local defaultMoneyType = config.defaultMoneyType
local allowedMoneyTypes = { money = true, black_money = true }
local lastPayment = {}

local function isPlayerInZone(x, y, points)
    local inside = false
    local j = #points
    for i = 1, #points do
        local xi, yi = points[i].x, points[i].y
        local xj, yj = points[j].x, points[j].y

        if ((yi > y) ~= (yj > y)) and (x < (xj - xi) * (y - yi) / (yj - yi) + xi) then
            inside = not inside
        end
        j = i
    end
    return inside
end

local function getPlayerMetadata(src)
    if GetResourceState('qbx_core') == 'started' then
        local player = exports.qbx_core:GetPlayer(src)
        return player and player.PlayerData.metadata
    elseif GetResourceState('qb-core') == 'started' then
        local player = exports['qb-core']:GetCoreObject().Functions.GetPlayer(src)
        return player and player.PlayerData.metadata
    end
end

local function isPlayerDead(src)
    local state = Player(src).state
    if state.isDead or state.dead then return true end

    local metadata = getPlayerMetadata(src)
    if metadata and (metadata.isdead or metadata.inlaststand) then return true end

    return GetEntityHealth(GetPlayerPed(src)) <= 0
end

RegisterNetEvent('s4t4n667_socialzones:payPlayer', function(zoneIndex)
    local src = source
    local currentTime = os.time()

    if not config.payWhenDead and isPlayerDead(src) then return end

    local currentZone = type(zoneIndex) == 'number' and config.socialZones[zoneIndex]
    local coords = GetEntityCoords(GetPlayerPed(src))

    if not currentZone
        or coords.z < currentZone.minZ or coords.z > currentZone.maxZ
        or not isPlayerInZone(coords.x, coords.y, currentZone.points) then
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = locale('zone.not_in'), duration = 5000, position = config.notifications.position})
        return
    end

    local payPeriod = currentZone.payPeriod or defaultPayPeriod

    if lastPayment[src] and (currentTime - lastPayment[src]) < payPeriod * 60 then
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = string.format(locale('zone.wait_for_payment'), payPeriod), duration = 5000, position = config.notifications.position})
        return
    end

    if not exports.ox_inventory:AddItem(src, allowedMoneyTypes[currentZone.moneyType] and currentZone.moneyType or defaultMoneyType, currentZone.payAmount) then return end

    lastPayment[src] = currentTime

    if currentZone.payNotify == false then return end

    TriggerClientEvent('ox_lib:notify', src, {
        title = currentZone.name,
        description = string.format(locale('zone.paid'), currentZone.payAmount),
        icon = (currentZone.icon and currentZone.icon ~= '') and currentZone.icon or 'money-bill',
        iconColor = (currentZone.iconColor and currentZone.iconColor ~= '') and currentZone.iconColor or '#51A231',
        position = config.notifications.position,
    })
end)

AddEventHandler('playerDropped', function()
    lastPayment[source] = nil
end)