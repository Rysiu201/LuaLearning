local QBCore = exports['qb-core']:GetCoreObject()

local Config = {
    HarnessUses = 20 -- Ilość użyć uprzęży wyścigowej
}

local seatbeltOn = false
local harnessOn = false
local harnessHp = Config.HarnessUses
local handbrake = 0
local sleep = 0
local harnessData = {}
local newvehicleBodyHealth = 0
local currentvehicleBodyHealth = 0
local frameBodyChange = 0
local lastFrameVehiclespeed = 0
local lastFrameVehiclespeed2 = 0
local thisFrameVehicleSpeed = 0
local tick = 0
local damagedone = false
local modifierDensity = true
local lastVehicle = nil
local lastToggleTime = 0
local toggleCooldown = 500 -- w milisekundach
local veloc

-- Functions

local function EjectFromVehicle()
    print("Ejecting player from vehicle")
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped,false)
    local coords = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, 1.0)
    SetEntityCoords(ped, coords.x, coords.y, coords.z)
    Wait(1)
    SetPedToRagdoll(ped, 5511, 5511, 0, 0, 0, 0)
    SetEntityVelocity(ped, veloc.x*2.5,veloc.y*2.5,veloc.z*2.5)
    local ejectspeed = math.ceil(GetEntitySpeed(ped))
    if GetEntityHealth(ped) - ejectspeed > 0 then
        SetEntityHealth(ped, GetEntityHealth(ped) - ejectspeed)
    elseif GetEntityHealth(ped) ~= 0 then
        SetEntityHealth(ped, 0)
    end
end

local function EjectOtherPlayerFromVehicle()
    print("Ejecting OTHER player from vehicle")
    local ped = PlayerPedId()
    local position = GetEntityCoords(ped)
    SetEntityCoords(ped, position.x, position.y, position.z - 0.47, true, true, true)
    SetEntityVelocity(ped, veloc.x*2.5,veloc.y*2.5,veloc.z*2.5)
    Citizen.Wait(1)
    SetPedToRagdoll(ped, 5511, 5511, 0, 0, 0, 0)
    Citizen.Wait(1000)
    if math.random(1, 3) == 1 then SetEntityHealth(ped, 0) end
    local ejectspeed = math.ceil(GetEntitySpeed(ped))
    if GetEntityHealth(ped) - ejectspeed > 0 then
        SetEntityHealth(ped, GetEntityHealth(ped) - ejectspeed)
    elseif GetEntityHealth(ped) ~= 0 then
        SetEntityHealth(ped, 0)
    end
end

local function ToggleSeatbelt(playSound)
    if not IsPedInAnyVehicle(PlayerPedId(), false) or IsPauseMenuActive() then return end
    local class = GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId()))
    if class == 8 or class == 13 or class == 14 then return end
    seatbeltOn = not seatbeltOn
    SeatBeltLoop()
    print(seatbeltOn)
    TriggerEvent("hud:client:UpdateSeatbelt", seatbeltOn)
end

local function ResetHandBrake()
    if handbrake <= 0 then return end
    handbrake = handbrake - 1
end

function SeatBeltLoop()
    CreateThread(function()
        local ped = PlayerPedId()
        
        -- Czekaj na kolejną klatkę zanim zablokujesz controls
        Wait(0)

        while IsPedInAnyVehicle(ped, false) and (seatbeltOn or harnessOn) do
            DisableControlAction(0, 75, true) -- exit vehicle
            DisableControlAction(27, 75, true)
            Wait(0)
        end

        seatbeltOn = false
        harnessOn = false
        TriggerEvent("hud:client:UpdateSeatbelt", seatbeltOn)
    end)
end

-- Export

function HasHarness()
    return harnessOn
end

exports("HasHarness", HasHarness)


-- Ejection Logic

RegisterNetEvent('QBCore:Client:EnteredVehicle', function()
    local playerPed = PlayerPedId()
    while IsPedInAnyVehicle(playerPed, false) do
        Wait(0)
        local currentVehicle = GetVehiclePedIsIn(playerPed, false)
        if currentVehicle and currentVehicle ~= false and currentVehicle ~= 0 then
            SetPedHelmet(playerPed, false)
            lastVehicle = GetVehiclePedIsIn(playerPed, false)
            if GetVehicleEngineHealth(currentVehicle) < 0.0 then
                SetVehicleEngineHealth(currentVehicle, 0.0)
            end
            if (GetVehicleHandbrake(currentVehicle) or (GetVehicleSteeringAngle(currentVehicle)) > 25.0 or (GetVehicleSteeringAngle(currentVehicle)) < -25.0) then
                if handbrake == 0 then
                    handbrake = 100
                    ResetHandBrake()
                else
                    handbrake = 100
                end
            end

            thisFrameVehicleSpeed = GetEntitySpeed(currentVehicle) * 3.6
            currentvehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
            if currentvehicleBodyHealth == 1000 and frameBodyChange ~= 0 then
                frameBodyChange = 0
            end
            if frameBodyChange ~= 0 then
                if lastFrameVehiclespeed > 110 and thisFrameVehicleSpeed < (lastFrameVehiclespeed * 0.75) and not damagedone then
                    if frameBodyChange > 18.0 then
                        if not seatbeltOn and not IsThisModelABike(currentVehicle) then
                            if math.random(math.ceil(lastFrameVehiclespeed)) > 60 then
                                if not harnessOn then
                                    local seatPlayerId = {}
                                    for i=1, GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) do
                                        if i ~= 1 then
                                            if not IsVehicleSeatFree(vehicle, i-2) then 
                                                local otherPlayerId = GetPedInVehicleSeat(vehicle, i-2) 
                                                local playerHandle = NetworkGetPlayerIndexFromPed(otherPlayerId)
                                                local playerServerId = GetPlayerServerId(playerHandle)
                                                table.insert(seatPlayerId, playerServerId)
                                            end
                                        end
                                    end
                                    EjectFromVehicle()
                                    if #seatPlayerId > 0 then
                                        TriggerServerEvent("seatbelt:eject-other-player-car-client", seatPlayerId)
                                    end
                                else
                                    harnessHp = harnessHp - 1
                                    TriggerServerEvent('seatbelt:DoHarnessDamage', harnessHp, harnessData)
                                end
                            end
                        elseif (seatbeltOn or harnessOn) and not IsThisModelABike(currentVehicle) then
                            if lastFrameVehiclespeed > 160 then
                                if math.random(math.ceil(lastFrameVehiclespeed)) > 150 then
                                    if not harnessOn then
                                        harnessHp = harnessHp - 1
                                        TriggerServerEvent('seatbelt:DoHarnessDamage', harnessHp, harnessData)
                                    else
                                        harnessHp = harnessHp - 1
                                        TriggerServerEvent('seatbelt:DoHarnessDamage', harnessHp, harnessData)
                                    end
                                end
                            end
                        end
                    else
                        if not seatbeltOn and not IsThisModelABike(currentVehicle) then
                            if math.random(math.ceil(lastFrameVehiclespeed)) > 60 then
                                if not harnessOn then
                                    local seatPlayerId = {}
                                    for i=1, GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) do
                                        if i ~= 1 then
                                            if not IsVehicleSeatFree(vehicle, i-2) then 
                                                local otherPlayerId = GetPedInVehicleSeat(vehicle, i-2) 
                                                local playerHandle = NetworkGetPlayerIndexFromPed(otherPlayerId)
                                                local playerServerId = GetPlayerServerId(playerHandle)
                                                table.insert(seatPlayerId, playerServerId)
                                            end
                                        end
                                    end
                                    EjectFromVehicle()
                                    if #seatPlayerId > 0 then
                                        TriggerServerEvent("seatbelt:eject-other-player-car-client", seatPlayerId)
                                    end
                                else
                                    harnessHp = harnessHp - 1
                                    TriggerServerEvent('seatbelt:DoHarnessDamage', harnessHp, harnessData)
                                end
                            end
                        elseif (seatbeltOn or harnessOn) and not IsThisModelABike(currentVehicle) then
                            if lastFrameVehiclespeed > 160 then
                                if math.random(math.ceil(lastFrameVehiclespeed)) > 200 then
                                    if not harnessOn then
                                        harnessHp = harnessHp - 1
                                        TriggerServerEvent('seatbelt:DoHarnessDamage', harnessHp, harnessData)
                                    else
                                        harnessHp = harnessHp - 1
                                        TriggerServerEvent('seatbelt:DoHarnessDamage', harnessHp, harnessData)
                                    end
                                end
                            end
                        end
                    end
                    damagedone = true
                    SetVehicleEngineOn(currentVehicle, false, true, true)
                end
                if currentvehicleBodyHealth < 350.0 and not damagedone then
                    damagedone = true
                    SetVehicleEngineOn(currentVehicle, false, true, true)
                    Wait(1000)
                end
            end
            if lastFrameVehiclespeed < 100 then
                Wait(100)
                tick = 0
            end
            frameBodyChange = newvehicleBodyHealth - currentvehicleBodyHealth
            if tick > 0 then
                tick = tick - 1
                if tick == 1 then
                    lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 3.6
                end
            else
                if damagedone then
                    damagedone = false
                    frameBodyChange = 0
                    lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 3.6
                end
                lastFrameVehiclespeed2 = GetEntitySpeed(currentVehicle) * 3.6
                if lastFrameVehiclespeed2 > lastFrameVehiclespeed then
                    lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 3.6
                end
                if lastFrameVehiclespeed2 < lastFrameVehiclespeed then
                    tick = 25
                end

            end
            if tick < 0 then
                tick = 0
            end
            newvehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
            if not modifierDensity then
                modifierDensity = true
            end
            veloc = GetEntityVelocity(currentVehicle)
        else
            if lastVehicle then
                SetPedHelmet(playerPed, true)
                Wait(200)
                newvehicleBodyHealth = GetVehicleBodyHealth(lastVehicle)
                if not damagedone and newvehicleBodyHealth < currentvehicleBodyHealth then
                    damagedone = true
                    SetVehicleEngineOn(lastVehicle, false, true, true)
                    Wait(1000)
                end
                lastVehicle = nil
            end
            lastFrameVehiclespeed2 = 0
            lastFrameVehiclespeed = 0
            newvehicleBodyHealth = 0
            currentvehicleBodyHealth = 0
            frameBodyChange = 0
            Wait(2000)
            break
        end
    end
end)



RegisterNetEvent("seatbelt:eject-other-player-car-client")
AddEventHandler("seatbelt:eject-other-player-car-client", function()
    EjectOtherPlayerFromVehicle()
end)

-- Register Key

RegisterCommand('+seatbelt', function()
    local now = GetGameTimer()
    if now - lastToggleTime < toggleCooldown then return end
    lastToggleTime = now

    if not IsPedInAnyVehicle(PlayerPedId(), false) or IsPauseMenuActive() then return end
    local class = GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId()))
    if class == 8 or class == 13 or class == 14 then return end
    ToggleSeatbelt(true)
end, false)

RegisterCommand('-seatbelt', function() end, false)

RegisterKeyMapping('+seatbelt', 'Pojazd (Pas bezpieczeństwa)', 'keyboard', 'b')