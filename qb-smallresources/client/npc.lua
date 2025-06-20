Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		DisableControlAction(1, 140, true)
        if not IsPlayerTargettingAnything(PlayerId()) then
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end

		SetVehicleDensityMultiplierThisFrame(Config.VehicleDensity)
		SetPedDensityMultiplierThisFrame(Config.PedDensity) 
		SetRandomVehicleDensityMultiplierThisFrame(Config.RandomVehicleDensity) 
		SetParkedVehicleDensityMultiplierThisFrame(Config.RandomParkedVehicleDensity)
		SetScenarioPedDensityMultiplierThisFrame(Config.ScenarioPedDensityMin, Config.ScenarioPedDensityMax) 
		SetGarbageTrucks(Config.GarbageTruck) 
		SetRandomBoats(Config.RandomBoats) 
		SetCreateRandomCops(Config.RandomCops) 
		SetCreateRandomCopsNotOnScenarios(Config.RandomCopsNotScenario)
		SetCreateRandomCopsOnScenarios(Config.RandomCopsOnScenario)
		
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	end
end)