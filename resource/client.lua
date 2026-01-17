lib.locale()
local config = require('config')

local inZone = false
local timer = nil
local currentZonePay = 0

function startPayTimer()
    if timer then return end

    timer = Citizen.CreateThread(function()
        while inZone do
            Wait(config.payPeriod * 60000)
            if currentZonePay > 0 then
                TriggerServerEvent('s4t4n667_socialzones:payPlayer', currentZonePay)
            end
        end
        timer = nil
    end)
end

Citizen.CreateThread(function()
    for _, zone in pairs(config.socialZones) do
        local poly = PolyZone:Create(
            zone.points, 
            {
                name = zone.name,
                minZ = zone.minZ,
                maxZ = zone.maxZ,
                debugPoly = config.debug,
            }
        )
        poly:onPlayerInOut(function(isInside)
            local notifyIconIN = (zone.icon and zone.icon ~= '' and zone.icon) or 'check'
            local notifyColorIN = (zone.iconColor and zone.iconColor ~= '' and zone.iconColor) or '#51A231'
            local notifyIconOUT = (zone.icon and zone.icon ~= '' and zone.icon) or 'xmark'
            local notifyColorOUT = (zone.iconColor and zone.iconColor ~= '' and zone.iconColor) or '#8C2425'

            inZone = isInside
            if isInside then
                currentZonePay = zone.payAmount
                lib.notify({ title = zone.name, description = locale('zone.enter'), icon = notifyIconIN, iconColor = notifyColorIN })
                startPayTimer()
            else
                currentZonePay = 0
                lib.notify({ title = zone.name, description = locale('zone.leave'), icon = notifyIconOUT, iconColor = notifyColorOUT })
            end
        end)
    end
end)