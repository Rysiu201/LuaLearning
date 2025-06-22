local zones = json.decode(LoadResourceFile(GetCurrentResourceName(), "zones.json"))
local QBCore = exports['qb-core']:GetCoreObject()
local AllWeapons = json.decode(LoadResourceFile(GetCurrentResourceName(), "weapons.json"))
local vehiclesCars = {0,1,2,3,4,5,6,7,8,9,10,11,12,17,18,19,20};
local isTalking = false
local Playerid = PlayerId()
local ServerId = 0
function Startup()
	ServerId = GetPlayerServerId(Playerid)
	SendNUIMessage({ action = 'ui', config = Config.ui })
	SendNUIMessage({ action = 'setFont', url = Config.font.url, name = Config.font.name })
	SendNUIMessage({ action = 'setLogo', value = Config.serverLogo })
	SendNUIMessage({ action = 'setVoiceDistance', value = LocalPlayer.state.proximity and LocalPlayer.state.proximity.mode or "Normal" })
	SendNUIMessage({ action = 'setMoney', id = 'plyId', value = tostring(ServerId)  })
end

function trewDate()
	local timeString = nil
	local weekDay = Translate('weekDay_' .. GetClockDayOfWeek())
	local month = Translate('month_' .. GetClockMonth())
	local day = Translate('day_' .. GetClockDayOfMonth())
	local year = GetClockYear()
	local hour = GetClockHours()
	local minutes = GetClockMinutes()
	local time = nil
	local AmPm = ''


	if Config.date.AmPm then
		if hour >= 13 and hour <= 24 then
			hour = hour - 12
			AmPm = 'PM'
		else
			if hour == 0 or hour == 24 then
				hour = 12
			end
			AmPm = 'AM'
		end

	end

	if hour <= 9 then
		hour = '0' .. hour
	end
	if minutes <= 9 then
		minutes = '0' .. minutes
	end

	time = hour .. ':' .. minutes .. ' ' .. AmPm

	local date_format = Locales[Config.Locale]['date_format'][Config.date.format]

	if Config.date.format == 'default' then
		timeString = string.format(
			date_format,
			day, month, year
		)
	elseif Config.date.format == 'simple' then
		timeString = string.format(
			date_format,
			day, month
		)

	elseif Config.date.format == 'simpleWithHours' then
		timeString = string.format(
			date_format,
			time, day, month
		)	
	elseif Config.date.format == 'withWeekday' then
		timeString = string.format(
			date_format,
			weekDay, day, month, year
		)
	elseif Config.date.format == 'withHours' then
		timeString = string.format(
			date_format,
			time, day, month, year
		)
	elseif Config.date.format == 'withWeekdayAndHours' then
		timeString = string.format(
			date_format,
			time, weekDay, day, month, year
		)
	end

	return timeString
end

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	Startup()
end)

-- Vehicle Info
local vehicleCruiser
local vehicleSignalIndicator = 'off'
local seatbeltEjectSpeed = 45.0 
local seatbeltEjectAccel = 100.0
local seatbeltIsOn = false
local currSpeed = 0.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}

-- From ESX Legacy/ESX Infinity
function RegisterInput(command_name, label, input_group, key, on_press)
    RegisterCommand(command_name, on_press)
    RegisterKeyMapping(command_name, label, input_group, key)
    TriggerEvent('chat:removeSuggestion', '/'.. command_name)
end

CreateThread(function()
	Startup()
	while not LocalPlayer.state.isLoggedIn do
		Wait(0)
	end
	while true do
		Wait(200)
		local player = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(player, false)
		local position = GetEntityCoords(player)
		local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
		local vehicleInfo

		if IsPauseMenuActive() then -- ESC Key
			if not isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = false })
			end
		else
			if isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = true })
			end
		end
		if IsPedInAnyVehicle(player, false) and vehicleIsOn then
			local vehicleClass = GetVehicleClass(vehicle)

			if not Config.ui.showMinimapOnFoot and Config.ui.showMinimapInVehicle then
				DisplayRadar(true)
			end

			-- Vehicle Speed
			local vehicleSpeedSource = GetEntitySpeed(vehicle)
			local vehicleSpeed
			if Config.vehicle.speedUnit == 'MPH' then
				vehicleSpeed = math.ceil(vehicleSpeedSource * 2.237)
			else
				vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)
			end

			-- Vehicle Gradient Speed
			local vehicleNailSpeed

			if vehicleSpeed > Config.vehicle.maxSpeed then
				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(Config.vehicle.maxSpeed * 205) / Config.vehicle.maxSpeed) )
			else
				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(vehicleSpeed * 205) / Config.vehicle.maxSpeed) )
			end

                        -- Vehicle Fuel and Gear
                        local vehicleFuel
                        vehicleFuel = GetVehicleFuelLevel(vehicle)

                        -- Detect if vehicle uses electric power
                        local modelName = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
                        local isElectric = has_value(Config.electricVehicles, modelName)

			local vehicleGear = GetVehicleCurrentGear(vehicle)

			if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
				vehicleGear = 'N'
			elseif vehicleSpeed > 0 and vehicleGear == 0 then
				vehicleGear = 'R'
			end

			-- Vehicle Lights
			local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
			local vehicleIsLightsOn
			if vehicleLights == 1 and vehicleHighlights == 0 then
				vehicleIsLightsOn = 'normal'
			elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
				vehicleIsLightsOn = 'high'
			else
				vehicleIsLightsOn = 'off'
			end

			-- Vehicle Siren
			local vehicleSiren

			if IsVehicleSirenOn(vehicle) then
				vehicleSiren = true
			else
				vehicleSiren = false
			end

			-- Vehicle Seatbelt
			if has_value(vehiclesCars, vehicleClass) and vehicleClass ~= (8 or 13 or 14) then

				local prevSpeed = currSpeed
                currSpeed = vehicleSpeedSource

                SetPedConfigFlag(PlayerPedId(), 32, true)

                if not seatbeltIsOn then
                	--[[local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                    local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                    if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then

                        SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
                        SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                        SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
                    else
                        -- Update previous velocity for ejecting player
                        prevVelocity = GetEntityVelocity(vehicle)
                    end--]]

                else

                	DisableControlAction(0, 75)

                end
			end

			vehicleInfo = {
				action = 'updateVehicle',
				status = true,
				speed = vehicleSpeed,
				nail = vehicleNailSpeed,
				gear = vehicleGear,
                fuel = vehicleFuel,
                electric = isElectric,
				lights = vehicleIsLightsOn,
				signals = vehicleSignalIndicator,
				cruiser = vehicleCruiser,
				type = vehicleClass,
				siren = vehicleSiren,
				seatbelt = {},

				config = {
					speedUnit = Config.vehicle.speedUnit,
					maxSpeed = Config.vehicle.maxSpeed
				}
			}

			vehicleInfo['seatbelt']['status'] = seatbeltIsOn
		else
			vehicleCruiser = false
			vehicleNailSpeed = 0
			vehicleSignalIndicator = 'off'

			vehicleInfo = {
				action = 'updateVehicle',

				status = false,
				nail = vehicleNailSpeed,
				seatbelt = { status = seatbeltIsOn },
				cruiser = vehicleCruiser,
				signals = vehicleSignalIndicator,
                                type = 0,
                                electric = false,
			}

			if not Config.ui.showMinimapOnFoot then
				DisplayRadar(false)
			end

		end

		SendNUIMessage(vehicleInfo)
	
		if Config.ui.showLocation then
			local player = PlayerPedId()
			local position = GetEntityCoords(player)
			local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
			local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))

			local locationMessage = nil

			if zoneNameFull then 
				locationMessage = streetName .. ', ' .. zoneNameFull
			else
				locationMessage = streetName
			end

			locationMessage = string.format(
				Locales[Config.Locale]['you_are_on_location'],
				locationMessage
			)

			SendNUIMessage({ action = 'setText', id = 'location', value = locationMessage })
		end

		if Config.ui.showVoice then
			if NetworkIsPlayerTalking(Playerid) and not isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			elseif not NetworkIsPlayerTalking(Playerid) and isTalking then
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			end
		end
	end
end)

CreateThread(function()
	while not LocalPlayer.state.isLoggedIn do
		Wait(0)
	end
	while true do
		Wait(2000)
		local PlayerData = QBCore.Functions.GetPlayerData()
		local playerStatus 
		local showPlayerStatus = 0
		playerStatus = { action = 'setStatus', status = {} }

		if Config.ui.showHealth then
			showPlayerStatus = (showPlayerStatus+1)

			playerStatus.isdead = IsPedDeadOrDying(PlayerPedId(), true)

			playerStatus['status'][showPlayerStatus] = {
				name = 'health',
				value = GetEntityHealth(PlayerPedId()) - 100
			}

		end

		if Config.ui.showDate then
			SendNUIMessage({ action = 'setText', id = 'date', value = trewDate() })
		end

		if Config.ui.showArmor then
			showPlayerStatus = (showPlayerStatus+1)

			playerStatus['status'][showPlayerStatus] = {
				name = 'armor',
				value = GetPedArmour(PlayerPedId()),
			}
		end

		if Config.ui.showStamina  then
			showPlayerStatus = (showPlayerStatus+1)

			playerStatus['status'][showPlayerStatus] = {
				name = 'stamina',
				value = 100 - GetPlayerSprintStaminaRemaining(Playerid),
			}
		end

		if showPlayerStatus > 0 then
			SendNUIMessage(playerStatus)
		end

	if PlayerData and PlayerData.job then
  	   local job
  	   local Crypto = PlayerData.money.crypto
  	   local bank = PlayerData.money.bank
	   local money = PlayerData.money.cash

        if PlayerData.job.label == PlayerData.job.grade.name then
          job = PlayerData.job.grade.name
        else
          job = PlayerData.job.label .. ': ' .. PlayerData.job.grade.name
        end

		SendNUIMessage({ action = 'setText', id = 'job', value = job })
		SendNUIMessage({ action = 'setMoney', id = 'wallet', value = money })
		SendNUIMessage({ action = 'setMoney', id = 'bank', value = bank })
		SendNUIMessage({ action = 'setMoney', id = 'blackMoney', value = Crypto })

  		if PlayerData.job.isboss then
  			if (Config.ui.showSocietyMoney) then
  				SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
  			end
			  QBCore.Functions.TriggerCallback('qb-bossmenu:server:GetAccount', function(cb)
				SendNUIMessage({ action = 'setMoney', id = 'society', value = tostring(cb) })
			end, PlayerData.job.name)
  		else
  			SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
  		end
  	end

  	local playerStatus 
  	local showPlayerStatus = 0
  	playerStatus = { action = 'setStatus', status = {} }

  	if Config.ui.showHunger then
  		showPlayerStatus = (showPlayerStatus+1)
		playerStatus['status'][showPlayerStatus] = {
			name = 'hunger',
			value = math.floor(PlayerData.metadata["hunger"])
		}
  	end

  	if Config.ui.showThirst then
  		showPlayerStatus = (showPlayerStatus+1)
		playerStatus['status'][showPlayerStatus] = {
			name = 'thirst',
			value = math.floor(PlayerData.metadata["thirst"])
		}
  	end

	if Config.ui.showStress then
		showPlayerStatus = (showPlayerStatus+1)
	  	playerStatus['status'][showPlayerStatus] = {
		  name = 'stress',
		  value = math.floor(PlayerData.metadata["stress"] > 1 and (PlayerData.metadata["stress"] / PlayerData.metadata["stress"]) * 100 or 1)
	  }
	end

  	if showPlayerStatus > 0 then
  	    SendNUIMessage(playerStatus)
  	end

	  if Config.ui.showVoice then
		AddEventHandler('pma-voice:setTalkingMode', function()
			SendNUIMessage({ action = 'setVoiceDistance', value = LocalPlayer.state.proximity and LocalPlayer.state.proximity.mode or "Normal" })
		end)
	  end
    end
end)

-- Weapons
if Config.ui.showWeapons then
	CreateThread(function()
		while not LocalPlayer.state.isLoggedIn do
			Wait(0)
		end
			while true do
				local Sleep = 800

				local player = PlayerPedId()
				local status = {}

				if IsPedArmed(player, 7) then
					Sleep = 100
					local weapon = GetSelectedPedWeapon(player)
					local ammoTotal = GetAmmoInPedWeapon(player,weapon)
					local bool,ammoClip = GetAmmoInClip(player,weapon)
					local ammoRemaining = math.floor(ammoTotal - ammoClip)
					
					status['armed'] = true

					for key,value in pairs(AllWeapons) do

						for keyTwo,valueTwo in pairs(AllWeapons[key]) do
							if weapon == joaat('weapon_'..keyTwo) then
								status['weapon'] = keyTwo


								if key == 'melee' then
									SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon_bullets' })
									SendNUIMessage({ action = 'element', task = 'disable', value = 'bullets' })
								else
									if keyTwo == 'stungun' then
										SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon_bullets' })
										SendNUIMessage({ action = 'element', task = 'disable', value = 'bullets' })
									else
										SendNUIMessage({ action = 'element', task = 'enable', value = 'weapon_bullets' })
										SendNUIMessage({ action = 'element', task = 'enable', value = 'bullets' })
									end
								end

							end
						end

					end

					SendNUIMessage({ action = 'setText', id = 'weapon_clip', value = ammoClip })
					SendNUIMessage({ action = 'setText', id = 'weapon_ammo', value = ammoRemaining })

				else
					if status['armed'] then
						status['armed'] = false
						SendNUIMessage({ action = 'updateWeapon', status = status })
					end
				end

				SendNUIMessage({ action = 'updateWeapon', status = status })
				Wait(Sleep)
			end
	end)
end

RegisterInput("cruise", "Cruise Control", "keyboard", Config.vehicle.keys.cruiser, function()
	local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player, false)
	local vehicleSpeedSource = GetEntitySpeed(vehicle)
	if  GetPedInVehicleSeat(vehicle, -1) ~= player then
		return
	end
	if vehicleCruiser == 'on' then
		vehicleCruiser = 'off'
		SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel"))
		
	else
		vehicleCruiser = 'on'
		SetEntityMaxSpeed(vehicle, vehicleSpeedSource)
	end
end)


-- Seatbelt state updated from seatbelt.lua

RegisterNetEvent('hud:client:UpdateSeatbelt', function(state)
    seatbeltIsOn = state
end)

RegisterInput("leftindicator", "Left Indicator", "keyboard", Config.vehicle.keys.signalLeft, function()
	local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player, false)
	local vehicleClass = GetVehicleClass(vehicle)
	if has_value(vehiclesCars, vehicleClass) ~= true then
		return
	end
	if vehicleSignalIndicator == 'off' then
		vehicleSignalIndicator = 'left'
	else
		vehicleSignalIndicator = 'off'
	end

	TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
end)

RegisterInput("rightindicator", "Right Indicator", "keyboard", Config.vehicle.keys.signalRight, function()
	local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player, false)
	local vehicleClass = GetVehicleClass(vehicle)
	if has_value(vehiclesCars, vehicleClass) ~= true then
		return
	end
	if vehicleSignalIndicator == 'off' then
		vehicleSignalIndicator = 'right'
	else
		vehicleSignalIndicator = 'off'
	end

	TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
end)

RegisterInput("bothindicator", "Both Indicators", "keyboard", Config.vehicle.keys.signalBoth, function()
	local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player, false)
	local vehicleClass = GetVehicleClass(vehicle)
	if has_value(vehiclesCars, vehicleClass) ~= true then
		return
	end
	if vehicleSignalIndicator == 'off' then
		vehicleSignalIndicator = 'both'
	else
		vehicleSignalIndicator = 'off'
	end

	TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
end)

AddEventHandler('trew_hud_ui:setCarSignalLights', function(status)
	local driver = GetVehiclePedIsIn(PlayerPedId(), false)
	local hasTrailer,vehicleTrailer = GetVehicleTrailerVehicle(driver)
	local leftLight
	local rightLight

	if status == 'left' then
		leftLight = false
		rightLight = true
		if hasTrailer then driver = vehicleTrailer end
	elseif status == 'right' then
		leftLight = true
		rightLight = false
		if hasTrailer then driver = vehicleTrailer end

	elseif status == 'both' then
		leftLight = true
		rightLight = true
		if hasTrailer then driver = vehicleTrailer end
	else
		leftLight = false
		rightLight = false
		if hasTrailer then driver = vehicleTrailer end
	end

	SetVehicleIndicatorLights(driver, 0, leftLight)
	SetVehicleIndicatorLights(driver, 1, rightLight)
end)

local toggleui = false
RegisterCommand('toggleui', function()
	if not toggleui then
		SendNUIMessage({ action = 'element', task = 'disable', value = 'job' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'bank' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'blackMoney' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'wallet' })
	else
		if (Config.ui.showJob) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'job' })
		end
		if (Config.ui.showSocietyMoney) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
		end
		if (Config.ui.showBankMoney) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'bank' })
		end
		if (Config.ui.showCrypto) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'blackMoney' })
		end
		if (Config.ui.showWalletMoney) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'wallet' })
		end
	end

	toggleui = not toggleui
end)

exports('createStatus', function(args)
	local statusCreation = { action = 'createStatus', status = args['status'], color = args['color'], icon = args['icon'] }
	SendNUIMessage(statusCreation)
end)

exports('setStatus', function(args)
	local playerStatus = { action = 'setStatus', status = {
		{ name = args['name'], value = args['value'] }
	}}
	SendNUIMessage(playerStatus)
end)

if Config.ui.showMinimapHealth then 
	Citizen.CreateThread(function()
		local minimap = RequestScaleformMovie("minimap")
		SetBigmapActive(true, false)
		Wait(0)
		SetBigmapActive(false, false)
		while true do
			local Sleep = 500
			if not IsRadarHidden() then
				Sleep = 0
				BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
				ScaleformMovieMethodAddParamInt(3)
				EndScaleformMovieMethod()
			end
			Wait(Sleep)
		end
	
	end)
end