local koltukdegistirengel = true

Citizen.CreateThread(function()
    local PlayerPed = PlayerPedId()
    local Arac = GetVehiclePedIsIn(PlayerPed, false)

	while true do
		if IsPedInAnyVehicle(PlayerPed, false) and koltukdegistirengel then
    		if GetPedInVehicleSeat(Arac, 0) == PlayerPed then
				if GetIsTaskActive(PlayerPed, 165) then
					SetPedIntoVehicle(PlayerPed, Arac, 0)
				end
			end
		end
        Citizen.Wait(100)
	end
end)



function round(value, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end



RegisterCommand("siedzenie", function(source, args)
    local PlayerPed = PlayerPedId()
    local Arac = GetVehiclePedIsIn(PlayerPed, false)
    
    if args[1] == nil then
        Koltuk = -1
    else
        Koltuk = round(tonumber(args[1]-2))
    end
    if IsPedInAnyVehicle(PlayerPed, false) then
        if IsVehicleSeatFree(Arac, Koltuk) then 
            SetPedIntoVehicle(PlayerPed, Arac, Koltuk)
        else
            TriggerEvent('QBCore:Notify', "Miejsce zajęte","error")
        end
    end
end)
