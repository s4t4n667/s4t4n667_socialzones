lib.locale()
local config = require('config')

local lastPayment = {}
local cooldown = config.payPeriod * 60

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

RegisterNetEvent('s4t4n667_socialzones:payPlayer', function()
    local src = source
    local currentTime = os.time()

    if lastPayment[src] and (currentTime - lastPayment[src]) < cooldown then
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = string.format(locale('zone.wait_for_payment'), config.payPeriod), duration = 5000})
        return
    end

    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local payAmount = nil

    for _, zone in pairs(config.socialZones) do
        if coords.z >= zone.minZ and coords.z <= zone.maxZ then
            if isPlayerInZone(coords.x, coords.y, zone.points) then
                payAmount = zone.payAmount
                break
            end
        end
    end

    if not payAmount then
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = locale('zone.not_in'), duration = 5000})
        return
    end

    exports.ox_inventory:AddItem(src, 'money', payAmount)

    lastPayment[src] = currentTime
end)