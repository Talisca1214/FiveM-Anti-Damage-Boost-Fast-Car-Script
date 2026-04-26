local unarmedHashMask = joaat('WEAPON_UNARMED') & 0xFFFFFFFF

local maxUnarmedWeaponDamage = 35.0

local vehicleKmhLimits = {
    [joaat('blista')] = 400.0,
}

AddEventHandler('weaponDamageEvent', function(sender, data)
    if not sender or type(data) ~= 'table' then
        return
    end
    local weaponType = data.weaponType or data.weaponHash
    if type(weaponType) ~= 'number' then
        return
    end
    if (weaponType & 0xFFFFFFFF) ~= unarmedHashMask then
        return
    end
    local dmg = data.weaponDamage
    if type(dmg) ~= 'number' then
        return
    end
    if dmg <= maxUnarmedWeaponDamage then
        return
    end
    CancelEvent()
    local name = GetPlayerName(sender) or ('id:' .. tostring(sender))
    DropPlayer(sender, 'Damage Boost Rpfini Silip Tekrar Giriş Sağlayınız')
end)

CreateThread(function()
    while true do
        Wait(750)
        local players = GetPlayers()
        for i = 1, #players do
            local src = tonumber(players[i])
            if src then
                local ped = GetPlayerPed(src)
                if ped and ped ~= 0 then
                    local veh = GetVehiclePedIsIn(ped, false)
                    if veh and veh ~= 0 then
                        if GetPedInVehicleSeat(veh, -1) == ped then
                            local model = GetEntityModel(veh)
                            local limitKmh = vehicleKmhLimits[model]
                            if limitKmh then
                                local ms = GetEntitySpeed(veh)
                                if type(ms) == 'number' then
                                    local kmh = ms * 3.6
                                    if kmh > limitKmh then
                                        local name = GetPlayerName(src) or ('id:' .. tostring(src))
                                        DropPlayer(src, 'Blista Fast Car Rpfini Silip Tekrar Giriş Sağlayınız')
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)
