local QBCore = exports['qb-core']:GetCoreObject()
local tekerPatlak, sikiKemer, cruiseIsOn, vehIsMovingFwd, alarmset, engineRunning = false, false, false, false, false, false, false
local curSpeed, prevSpeed, cruiseSpeed, speedLimit = 0.0, 0.0, 999.0, 80.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
local compassOn = true
local vehAcc = false
local inVehSetState = false
local clock = ""
local lastBurst = 0
local lastHardBurst = 0

local zoneNames = {
    AIRP = "Międzynarodowe Lotnisko Los Santos",
    ALAMO = "Jezioro Alamo",
    ALTA = "Alta",
    ARMYB = "Fort Zancudo",
    BANHAMC = "Kanion Banham",
    BANNING = "Banning",
    BAYTRE = "Kanion Baytree", 
    BEACH = "Plaża Vespucci",
    BHAMCA = "Kanion Banham",
    BRADP = "Przełęcz Braddock",
    BRADT = "Tunel Braddock",
    BURTON = "Burton",
    CALAFB = "Most Calafia",
    CANNY = "Kanion Raton",
    CCREAK = "Strumień Cassidy",
    CHAMH = "Wzgórza Chamberlain",
    CHIL = "Wzgórza Vinewood",
    CHU = "Chumash",
    CMSW = "Stanowe Góry Chiliad",
    CYPRE = "Dzielnica Cypress",
    DAVIS = "Davis",
    DELBE = "Plaża Del Perro",
    DELPE = "Del Perro",
    DELSOL = "La Puerta",
    DESRT = "Pustynia Grand Senora",
    DOWNT = "Centrum",
    DTVINE = "Centrum Vinewood",
    EAST_V = "Wschodni Vinewood",
    EBURO = "Wzgórza El Burro",
    ELGORL = "Latarnia El Gordo",
    ELYSIAN = "Wyspa Elysian",
    GALFISH = "Galilee",
    GALLI = "Park Galileo",
    golf = "Klub Golfowy GWC",
    GRAPES = "Grapeseed",
    GREATC = "Great Chaparral",
    HARMO = "Harmony",
    HAWICK = "Hawick",
    HORS = "Tor wyścigowy Vinewood",
    HUMLAB = "Laboratoria Humane",
    JAIL = "Więzienie Bolingbroke",
    KOREAT = "Małe Seoul",
    LACT = "Zbiornik Land Act",
    LAGO = "Lago Zancudo",
    LDAM = "Tama Land Act",
    LEGSQU = "Plac Legion",
    LMESA = "La Mesa",
    LOSPUER = "La Puerta",
    MIRR = "Mirror Park",
    MORN = "Morningwood",
    MOVIE = "Richards Majestic",
    MTCHIL = "Góra Chiliad",
    MTGORDO = "Góra Gordo",
    MTJOSE = "Góra Josiah",
    MURRI = "Wzgórza Murrieta",
    NCHU = "North Chumash",
    NOOSE = "N.O.O.S.E.",
    OCEANA = "Ocean Spokojny",
    PALCOV = "Zatoka Paleto",
    PALETO = "Paleto Bay",
    PALFOR = "Las Paleto",
    PALHIGH = "Wzgórza Palomino",
    PALMPOW = "Elektrownia Palmer-Taylor",
    PBLUFF = "Klify Pacyfiku",
    PBOX = "Wzgórze Pillbox",
    PROCOB = "Plaża Procopio",
    RANCHO = "Rancho",
    RGLEN = "Richman Glen",
    RICHM = "Richman",
    ROCKF = "Wzgórza Rockford",
    RTRAK = "Tor Redwood Lights",
    SanAnd = "San Andreas",
    SANCHIA = "Obszar San Chianski",
    SANDY = "Sandy Shores",
    SKID = "Mission Row",
    SLAB = "Stab City",
    STAD = "Arena Maze Bank",
    STRAW = "Strawberry",
    TATAMO = "Góry Tataviam",
    TERMINA = "Terminal",
    TEXTI = "Dzielnica Tekstylna",
    TONGVAH = "Wzgórza Tongva",
    TONGVAV = "Dolina Tongva",
    VCANA = "Kanały Vespucci",
    VESP = "Vespucci",
    VINE = "Vinewood",
    WINDF = "Elektrownia Wiatrowa Ron Alternates",
    WVINE = "Zachodni Vinewood",
    ZANCUDO = "Strumień Zancudo",
    ZP_ORT = "Port Południowego Los Santos",
    ZQ_UAR = "Kamieniołom Davis Quartz"
}

RegisterNetEvent("tgiann-hud:hizsabitle")
AddEventHandler("tgiann-hud:hizsabitle", function(args)
    if args[1] == nil then args[1] = 1 end
    if driverSeat and tonumber(args[1]) > 0 then
        if not IsVehicleTyreBurst(vehicle, 0) and not IsVehicleTyreBurst(vehicle, 1) and not IsVehicleTyreBurst(vehicle, 4) and not IsVehicleTyreBurst(vehicle, 5) then 
            cruiseIsOn = true
            cruiseSpeed = (tonumber(args[1] + 2) / 3.6)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if inVehicle then 
            time = 50
            SendNUIMessage({
                action = "CusalsetSpeedo",
                speed = math.floor(prevSpeed * 3.6)
            })
            SendNUIMessage({
                action = "CusalsetSpeedNumbers",
                speed = math.floor(prevSpeed * 3.6)
            })
        end
        Citizen.Wait(time)
    end
end)

local offRoad = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if isLoggedIn then
            local hours = GetClockHours()
            local mins = GetClockMinutes()
            if string.len(tostring(hours)) == 1 then hours = '0'..hours end
            if string.len(tostring(mins)) == 1 then mins = '0'..mins end
            clock = hours .. ':' .. mins

            local street = ""
            local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
            local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
            local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
            local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
            local zone = tostring(GetNameOfZone(x, y, z))
            
            if not zone then
                zone = "UNKNOWN"
                zoneNames['UNKNOWN'] = zone
            elseif not zoneNames[zone] then
                local undefinedZone = zone .. " " .. x .. " " .. y .. " " .. z
                zoneNames[zone] = "Nieznana lokalizacja"
            end

            street = zoneNames[zone]
            
            if intersectStreetName ~= nil and intersectStreetName ~= "" then
                street = currentStreetName .. " | " .. intersectStreetName .. " | [" .. zoneNames[zone] .. "]"
            elseif currentStreetName ~= nil and currentStreetName ~= "" then
                street = currentStreetName .. " | [" .. zoneNames[zone] .. "]"
            else
                street = "[".. zoneNames[tostring(zone)] .. "]"
            end

            if inVehicle then 
                if not inVehSetState then
                    inVehSetState = true
                    SendNUIMessage({
                        action = "CusalsetUI",
                        state = true
                    })
                    SendNUIMessage({
                        action = "inVeh",
                        data = true
                    })
                end

                -- araç arazi vs
                if DoesEntityExist(vehicle) then
                    local wheel_action = GetVehicleWheelType(vehicle)
                    if wheel_type ~= 3 and wheel_type ~= 4 and wheel_type ~= 6 then -- If have Off-road/Suv's/Motorcycles wheel grip its equal
                        if not cruiseIsOn then
                            local maxSpeed = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
                            SetEntityMaxSpeed(vehicle, maxSpeed)
                        end
        
                        local material_id = GetVehicleWheelSurfaceMaterial(vehicle, 1)
                        if material_id == 4 or material_id == 1 or material_id == 3 then -- All road (sandy/los santos/paleto bay)
                            offRoad = 0
                            SetVehicleGravityAmount(vehicle, 9.8000001907349) -- On road
                        else
                            offRoad = offRoad + 1
                            if offRoad > 4 then
                                SetVehicleGravityAmount(vehicle, 5.8000001907349) -- Off road
                            end
                        end
                    else
                        if not cruiseIsOn then
                            local maxSpeed = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
                            SetEntityMaxSpeed(vehicle, maxSpeed*0.7)
                        end
                    end
                end
                
                SendNUIMessage({
                    action = "CusalsetFuel",
                    fuel = Fuel, 
                })

                local p1,p2,lightsOn = GetVehicleLightsState(vehicle)
                if not engineRunning then
                    SendNUIMessage({
                        action = "CusalsetCarIcon",
                        iconName = "engine",
                        iconColor = "rgba(155, 155, 155, 0.5)",
                    })
                    if cruiseIsOn then
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "cruise",
                            iconColor = "rgba(0, 255, 0, 0.5)",
                        })
                    else
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "cruise",
                            iconColor = "rgba(155, 155, 155, 0.5)",
                        })
                    end
                    
                    if (GetVehicleDoorAngleRatio(vehicle, 0) > 0 or GetVehicleDoorAngleRatio(vehicle, 1) > 0 or GetVehicleDoorAngleRatio(vehicle, 2) > 0 or GetVehicleDoorAngleRatio(vehicle, 3) > 0) then
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "doors",
                            iconColor = "rgba(0, 255, 0, 0.5)",
                        })
                    else
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "doors",
                            iconColor = "rgba(155, 155, 155, 0.5)",
                        })
                    end

                    if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "trunk",
                            iconColor = "rgba(0, 255, 0, 0.5)",
                        })
                    else
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "trunk",
                            iconColor = "rgba(155, 155, 155, 0.5)",
                        })
                    end 

                    if lightsOn then
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "light",
                            iconColor = "rgba(0, 255, 0, 0.5)",
                        })
                    else
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "light",
                            iconColor = "rgba(155, 155, 155, 0.5)",
                        })
                    end 

                    SendNUIMessage({
                        action = "carHud",
                        street = street,
                        compass = degreesToIntercardinalDirection(),
                        time = clock,
                        engine = true,
                        yukseklik = (GetVehicleClass(vehicle) == 15 or GetVehicleClass(vehicle) == 16) and GetEntityHeightAboveGround(vehicle) or false,
                        engineHealth = GetVehicleEngineHealth(vehicle),
                    })
                else
                    SendNUIMessage({
                        action = "CusalsetCarIcon",
                        iconName = "engine",
                        iconColor = "rgba(0, 255, 0, 0.5)",
                    })
                    if cruiseIsOn then
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "cruise",
                            iconColor = "rgba(0, 255, 0, 0.5)",
                        })
                    else
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "cruise",
                            iconColor = "rgba(155, 155, 155, 0.5)",
                        })
                    end
                    
                    if (GetVehicleDoorAngleRatio(vehicle, 0) > 0 or GetVehicleDoorAngleRatio(vehicle, 1) > 0 or GetVehicleDoorAngleRatio(vehicle, 2) > 0 or GetVehicleDoorAngleRatio(vehicle, 3) > 0) then
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "doors",
                            iconColor = "rgba(0, 255, 0, 0.5)",
                        })
                    else
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "doors",
                            iconColor = "rgba(155, 155, 155, 0.5)",
                        })
                    end

                    if GetVehicleDoorAngleRatio(vehicle, 5) > 0 then
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "trunk",
                            iconColor = "rgba(0, 255, 0, 0.5)",
                        })
                    else
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "trunk",
                            iconColor = "rgba(155, 155, 155, 0.5)",
                        })
                    end 

                    if lightsOn then
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "light",
                            iconColor = "rgba(0, 255, 0, 0.5)",
                        })
                    else
                        SendNUIMessage({
                            action = "CusalsetCarIcon",
                            iconName = "light",
                            iconColor = "rgba(155, 155, 155, 0.5)",
                        })
                    end 

                    SendNUIMessage({
                        action = "carHud",
                        street = street,
                        compass = degreesToIntercardinalDirection(),
                        time = clock,
                        engine = true,
                        yukseklik = (GetVehicleClass(vehicle) == 15 or GetVehicleClass(vehicle) == 16) and GetEntityHeightAboveGround(vehicle) or false,
                        engineHealth = GetVehicleEngineHealth(vehicle),
                    }) 
                end
            else
                if inVehSetState then
                    inVehSetState = false
                    SendNUIMessage({
                        action = "CusalsetUI",
                        state = false
                    })
                    SendNUIMessage({
                        action = "inVeh",
                        data = false
                    })
                else
                    SendNUIMessage({
                        action = "clockStreet",
                        time = clock,
                        street = street,
                        compass = degreesToIntercardinalDirection(),
                    })
                end
            end
        end

    end
end)

RegisterNetEvent("tgiann-hud:car:eject-other-player-car-client")
AddEventHandler("tgiann-hud:car:eject-other-player-car-client", function(velocity)
    ejectPlayer()
end)

-- Secondary thread to update strings
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4000)
        if inVehicle and vehIsMovingFwd and driverSeat and engineRunning and vehicleClass ~= 13 and vehicleClass ~= 8 and vehicleClass ~= 21 and vehicleClass ~= 14 and vehicleClass ~= 16 and vehicleClass ~= 15 then
            TriggerEvent('InteractSound_CL:PlayOnOne', 'alarm', 0.5)
        end
    end
end)

-- CODE --
local zone = "Unknown";
local time = "12:00"
local busy = false
local VehicleNormalMaxSpeed = false
local lastsikiKemer = false

Citizen.CreateThread(function()
    RegisterKeyMapping('+cruise', 'Pojazd (Tempomat)', 'keyboard', 'y')
end)

RegisterCommand("+cruise", function()
    if driverSeat and engineRunning then
        if not cruiseIsOn and vehIsMovingFwd then
            QBCore.Functions.Notify("Tempomat włączony", "success")
            cruiseSpeed = prevSpeed
            cruiseIsOn = not cruiseIsOn
        elseif cruiseIsOn then
            QBCore.Functions.Notify("Tempomat wyłączony", "error")
            cruiseIsOn = not cruiseIsOn
        end
    end
end, false)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        if isLoggedIn then
            if inVehicle then
                time = 1
                engineRunning = GetIsVehicleEngineRunning(vehicle)
                prevSpeed = curSpeed
                curSpeed = GetEntitySpeed(vehicle)
                vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                vehAcc = (prevSpeed - curSpeed) / GetFrameTime() > 981

                -- Zmieniono ten fragment:
                if vehIsMovingFwd and prevSpeed * 2.236936 > 85.0 and vehAcc then
                    if GetGameTimer() - lastHardBurst > 10000 then -- 10s cooldown
                        if math.random(1, 6) == 1 then
                            print('Przebijanie')
                            tyreBrustSet(true)
                            lastHardBurst = GetGameTimer()
                            print(lastHardBurst)
                        end
                    end
                else
                    prevVelocity = GetEntityVelocity(vehicle)
                end

                if not GetPedConfigFlag(playerPed, 184, 1) then SetPedConfigFlag(playerPed, 184, true) end
                if GetIsTaskActive(playerPed, 165) then
                    if GetSeatPedIsTryingToEnter(playerPed) == -1 then
                        if GetPedConfigFlag(playerPed, 184, 1) then
                            SetPedIntoVehicle(playerPed, vehicle, 0)
                            SetVehicleCloseDoorDeferedAction(vehicle, 0)
                        end
                    end
                end
 
                -- When playerPed in driver seat, handle cruise control
                if driverSeat and engineRunning then
                    -- if IsEntityInAir(vehicle) then
                    --     DisableControlAction(2, 59)
                    --     DisableControlAction(2, 60)
                    -- end

                    local cruiseOn = cruiseIsOn and cruiseSpeed or tekerPatlak and 50.0
                    if not VehicleNormalMaxSpeed and not cruiseOn then
                        VehicleNormalMaxSpeed = true
                        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
                        SetEntityMaxSpeed(vehicle, maxSpeed)
                    elseif cruiseOn and VehicleNormalMaxSpeed  then
                        VehicleNormalMaxSpeed = false
                        maxSpeed = cruiseOn
                    end
                    
                    if prevSpeed > maxSpeed then
                        SetEntityMaxSpeed(vehicle, prevSpeed-0.5)
                    end

                    if vehicleClass ~= 13 and vehicleClass ~= 8 and vehicleClass ~= 14 then
                        if vehIsMovingFwd and vehAcc then
                            local kmh = prevSpeed * 2.236936
                            if kmh > 75.0 and GetGameTimer() - lastBurst > 10000 then -- 10s cooldown
                                if math.random(1, 6) == 1 then -- 10% szans
                                    tyreBrustSet(true)
                                    lastBurst = GetGameTimer()
                                end
                            end
                            -- Możesz tu odkomentować jeśli chcesz:
                            -- TriggerEvent(...)
                            -- ejectPlayer()
                        end
                    end

                    if IsVehicleTyreBurst(vehicle, 0) or IsVehicleTyreBurst(vehicle, 1) or IsVehicleTyreBurst(vehicle, 4) or IsVehicleTyreBurst(vehicle, 5) then 
                        tekerPatlak = true
                    else
                        tekerPatlak = false
                    end

                    prevVelocity = GetEntityVelocity(vehicle)
                else
                    cruiseIsOn = false
                end

            else
                inVehicle = false
                cruiseIsOn = false
                vehAcc = false
                prevSpeed = 0
                vehIsMovingFwd = false
                curSpeed = 0
            end
        end
        Citizen.Wait(time)
    end
end)

function tyreBrustSet(engine)
    local lastVehicle = GetPlayersLastVehicle(playerPed)
    local rand = math.random(1, 100)
    local burstCount = 0

    if rand <= 80 then -- 80% szans na 1 oponę
        local tyre = math.random(0, 5)
        SetVehicleTyreBurst(lastVehicle, tyre, true, 100.0)
        burstCount = 1
    elseif rand <= 90 then -- 15% na 2 opony
        SetVehicleTyreBurst(lastVehicle, 0, true, 100.0)
        SetVehicleTyreBurst(lastVehicle, 4, true, 100.0)
        burstCount = 2
    elseif rand <= 95 then -- 4% na 3 opony
        SetVehicleTyreBurst(lastVehicle, 0, true, 100.0)
        SetVehicleTyreBurst(lastVehicle, 1, true, 100.0)
        SetVehicleTyreBurst(lastVehicle, 4, true, 100.0)
        burstCount = 3
    elseif rand <= 96 then -- 1% szans na 4 opony
        SetVehicleTyreBurst(lastVehicle, 0, true, 100.0)
        SetVehicleTyreBurst(lastVehicle, 1, true, 100.0)
        SetVehicleTyreBurst(lastVehicle, 4, true, 100.0)
        SetVehicleTyreBurst(lastVehicle, 5, true, 100.0)
        burstCount = 4
    end

    -- Wyłącz silnik tylko jeśli coś zostało przebite
    if burstCount > 0 and engine then
        TriggerEvent("iens:motortamiret", lastVehicle, 10.0)
    end
end


--[[function ejectPlayer()
    local position = GetEntityCoords(playerPed)
    SetEntityCoords(playerPed, position.x, position.y, position.z - 0.47, true, true, true)
    SetEntityVelocity(playerPed, prevVelocity.x, prevVelocity.y, prevVelocity.z)
    Citizen.Wait(1)
    SetPedToRagdoll(playerPed, 1000, 1000, 0, 0, 0, 0)
    Citizen.Wait(1000)
    if math.random(1, 3) == 1 then SetEntityHealth(playerPed, 0) end
end--]]

--[[RegisterNetEvent("CarFuelAlarm")
AddEventHandler("CarFuelAlarm",function()
    if not alarmset then
        alarmset = true
        local i = 5
        TriggerEvent("DoLongHudText", "Mało Paliwa.",1)
        while i > 0 do
            PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
            i = i - 1
            Citizen.Wait(300)
        end
        Citizen.Wait(60000)
        alarmset = false
    end
end)--]]

function degreesToIntercardinalDirection()
    local playerHeadingDegrees = 360.0 - GetEntityHeading(playerPed)
    local dgr = playerHeadingDegrees - 180 / 2
	local dgr = dgr % 360.0

	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return "N"   -- Północ
	elseif dgr >= 22.5 and dgr < 67.5 then
		return "NE"  -- Północny Wschód
	elseif dgr >= 67.5 and dgr < 112.5 then
		return "E"   -- Wschód
	elseif dgr >= 112.5 and dgr < 157.5 then
		return "SE"  -- Południowy Wschód
	elseif dgr >= 157.5 and dgr < 202.5 then
		return "S"   -- Południe
	elseif dgr >= 202.5 and dgr < 247.5 then
		return "SW"  -- Południowy Zachód
	elseif dgr >= 247.5 and dgr < 292.5 then
		return "W"   -- Zachód
	elseif dgr >= 292.5 and dgr < 337.5 then
		return "NW"  -- Północny Zachód
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        HideHudComponentThisFrame(6) -- VEHICLE_NAME
        HideHudComponentThisFrame(7) -- AREA_NAME
        HideHudComponentThisFrame(8) -- VEHICLE_CLASS
        HideHudComponentThisFrame(9) -- STREET_NAME
        HideHudComponentThisFrame(3) -- CASH
        HideHudComponentThisFrame(4) -- MP_CASH
    end
end)