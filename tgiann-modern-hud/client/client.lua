--discord.gg/avance
--discord.gg/avance
--discord.gg/avance
--discord.gg/avance
local QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}
isLoggedIn, inVehicle, driverSeat, Show, phoneOpen = false, false, false, false, false
playerPed, vehicle, vehicleClass, Fuel, vehicleClass = 0, 0, 0, 0, 0

local bigMap = false
local onMap = false
local minimap = nil
local hunger = 100
local thirst = 100

DisplayRadar(false)

Citizen.CreateThread(function()
    while true do
        playerPed = PlayerPedId()
        inVehicle = false
        if IsPedInAnyVehicle(playerPed, false)  then
            vehicle = GetVehiclePedIsIn(playerPed, false)
            vehicleClass = GetVehicleClass(vehicle)
            inVehicle = not IsVehicleModel(vehicle, `wheelchair`) and vehicleClass ~= 13 and not IsVehicleModel(vehicle, `windsurf`)
            vehicleClass = GetVehicleClass(vehicle)
            driverSeat = GetPedInVehicleSeat(vehicle, -1) == playerPed
            Fuel = GetVehicleFuelLevel(vehicle)
        end
        SendNUIMessage({
            action = 'tick',
            heal = (GetEntityHealth(playerPed)-100),
            zirh = GetPedArmour(playerPed),
            stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
            oxy = IsPedSwimmingUnderWater(playerPed) and GetPlayerUnderwaterTimeRemaining(PlayerId()) or 100,
            vehicle = inVehicle,
            phoneOpen = phoneOpen
        })
        Citizen.Wait(200)
    end
end)

RegisterCommand("hud", function()
    SendNUIMessage({action = 'hudmenu'})
    SetNuiFocus(true, true)
end, false)

RegisterNUICallback("hudmenuclose", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('hudac', function()
    TriggerEvent("tgiann-hud:ui", true)
end)

RegisterNUICallback('hudkapa', function()
    TriggerEvent("tgiann-hud:ui", false)
end)

RegisterNUICallback('emotechat', function(data)
    TriggerEvent("3dme-chat", data.onOff)
end)

local miniMapUi = false
function UIStuff()
    Citizen.CreateThread(function()
        while Show do
            Citizen.Wait(0)

            if inVehicle and not onMap then
                SetPedConfigFlag(playerPed, 35, false)
                onMap = true
                Wait(900)
                DisplayRadar(true)
                -- circleMap()
            elseif not inVehicle and onMap then
                onMap = false
                Wait(500)
                DisplayRadar(false)
                -- circleMap()
            end

            BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
            ScaleformMovieMethodAddParamInt(3)
            EndScaleformMovieMethod()

            if IsPauseMenuActive() then
                if miniMapUi then
                    SendNUIMessage({action = "bigMap", show = false})
                    miniMapUi = false
                end
            elseif not IsPauseMenuActive() then
                if not miniMapUi then
                    SendNUIMessage({action = "bigMap", show = true})
                    miniMapUi = true
                end
            end
        end
        onMap = false
    end)
end

function circleMap()
    -- RequestStreamedTextureDict("circlemap", false)
    -- while not HasStreamedTextureDictLoaded("circlemap") do
    --     Wait(100)
    -- end

    -- AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

    -- SetMinimapClipType(1)
    -- SetMinimapComponentPosition("minimap", "L", "B", 0.025, -0.03, 0.153, 0.30)
    -- SetMinimapComponentPosition("minimap_mask", "L", "B", 0.135, 0.12, 0.093, 0.164)
    -- SetMinimapComponentPosition("minimap_blur", "L", "B", 0.012, 0.022, 0.256, 0.337)
    -- SetBlipAlpha(GetNorthRadarBlip(), 0)

    -- minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(100)
    SetRadarBigmapEnabled(false, false)
end

RegisterNetEvent('SaltyChat_VoiceRangeChanged')
AddEventHandler('SaltyChat_VoiceRangeChanged', function(seviye)
    if seviye == 2.0 then
        SendNUIMessage({action = 'voice', lvl = "1"})
    elseif seviye == 7.0 then
        SendNUIMessage({action = 'voice', lvl = "2"})
    elseif seviye == 15.0 then
        SendNUIMessage({action = 'voice', lvl = "3"})
    end
end)

local normalKonusmaAktif = false
RegisterNetEvent('SaltyChat_TalkStateChanged')
AddEventHandler('SaltyChat_TalkStateChanged', function(status)
    if status and not normalKonusmaAktif then
        normalKonusmaAktif = true
        SendNUIMessage({action = 'speak', active = true})
    elseif not status and normalKonusmaAktif then
        normalKonusmaAktif = false
        SendNUIMessage({action = 'speak', active = false})
    end
end)

RegisterNetEvent("SaltyChat_PluginStateChanged")
AddEventHandler("SaltyChat_PluginStateChanged", function(state2)
    SendNUIMessage({
        action = 'salty',
        state = state2,
    })
end)

RegisterNetEvent('sunepe-hud:client:sendStatus')
AddEventHandler('sunepe-hud:client:sendStatus', function(data)
    SetPedMaxTimeUnderwater(playerPed, 40.0)
    SendNUIMessage({
        action = "updateStatus",
        st = {yemek = data.hunger, su = data.thirst},
    })
end)

RegisterNetEvent("reka:hud:sendStatus") -- reka:hud:sendStatus
AddEventHandler("reka:hud:sendStatus", function(status)
    SendNUIMessage({
        action = "updateStatus",
        data = {
            yemek = status.hunger,
            su = status.thirst,
        },
    })
end)

RegisterCommand('hudyenile', function()
    QBCore.PlayerData = QBCore.Functions.GetPlayerData()
    TriggerEvent("hud:client:SetMoney")
    SendNUIMessage({action = 'first'})
    UIStuff()
    isLoggedIn = true
    Show = true
    Citizen.Wait(10000)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.PlayerData = QBCore.Functions.GetPlayerData()
    TriggerEvent("hud:client:SetMoney")
    SendNUIMessage({action = 'first'})
    UIStuff()
    isLoggedIn = true
    Show = true
    Citizen.Wait(10000)
end)

function firstLogin()
    QBCore.PlayerData = QBCore.Functions.GetPlayerData()
    TriggerEvent("hud:client:SetMoney")
    UIStuff()
    isLoggedIn = true
    Show = true
    TriggerEvent("tgian-hud:load-data")
end

RegisterNetEvent('tgiann-hud:ui')
AddEventHandler('tgiann-hud:ui', function(open)
    if open then 
        UIStuff()
        Show = true
        SendNUIMessage({action = 'ui', show = true})
    else
        Show = false
        SendNUIMessage({action = 'ui', show = false})
        DisplayRadar(false)
    end
end)

RegisterNetEvent('tgiann-hud:siyahBar') -- Siyah bar
AddEventHandler('tgiann-hud:siyahBar', function(data)
    if data == true then
        SendNUIMessage({action = 'siyahBar', acik = true})
    else
        SendNUIMessage({action = 'siyahBar', acik = false})
    end
end)

RegisterNetEvent('tgiann-hud:open-hud')
AddEventHandler('tgiann-hud:open-hud', function()
    if not Show then
        PlayerData = QBCore.Functions.GetPlayerData()
        TriggerEvent("tgian-hud:load-data")
        SendNUIMessage({action = 'showui'})
        UIStuff()
        isLoggedIn = true
        Show = true
    end
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'showMenu'})
end)

RegisterNUICallback('close-ayar-menu', function()
    SetNuiFocus(false, false)
end)

local disSes = false
Citizen.CreateThread(function()
    RegisterKeyMapping('+raidoSpeaker', 'Tryb głośnika radia', 'keyboard', 'F5')
end)

RegisterCommand("+raidoSpeaker", function()
    disSes = not disSes
    TriggerServerEvent("ls-radio:set-disses", disSes)
    SendNUIMessage({action = 'disSes', disSes = disSes})
end, false)

RegisterNUICallback('set-emotechat', function(data)
    TriggerEvent("3dme-chat", data.status)
end)

RegisterNetEvent('tgiann-hud:parasut')
AddEventHandler('tgiann-hud:parasut', function()
	GiveWeaponToPed(playerPed, `gadget_parachute`, 1, false, false)
	SetPedComponentVariation(playerPed, 5, 8, 3, 0)
end)

RegisterNetEvent('phone:open')
AddEventHandler('phone:open', function(bool)
    phoneOpen = bool
    if not phoneOpen then Citizen.Wait(500) end
    SendNUIMessage({action = 'phone', phoneOpen = phoneOpen})
end)

CreateThread(function()
	SendNUIMessage({
		action = "UsingVoiceHud"
	})
end)

local Talking = false
Citizen.CreateThread(function()
	while true do
		if NetworkIsPlayerTalking(PlayerId()) then
			if not Talking then
				Talking = true
				SendNUIMessage({
					action = "talking"
				})
			end
		else
			if Talking then
				Talking = false
				SendNUIMessage({
					action = "Nottalking"
				})
			end
		end
		Citizen.Wait(200)
	end
end)

RegisterNetEvent('pma-voice:setTalkingMode')
AddEventHandler('pma-voice:setTalkingMode', function(voiceMode)
	SendNUIMessage({
		action = "pmavoice",
		value = voiceMode
	})
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 500
        SendNUIMessage({
            action = "HungerUpdate",
            hunger = hunger
        })
        SendNUIMessage({
            action = "ThirstUpdate",
            thirst = thirst
        })
        Citizen.Wait(sleep)
    end
end)

RegisterCommand('armor', function(source, args, rawCommand)
    SetPedArmour(PlayerPedId(), 5)
end, false)

RegisterCommand('armordel', function(source, args, rawCommand)
    SetPedArmour(PlayerPedId(), -5)
end, false)