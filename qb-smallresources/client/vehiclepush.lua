QBCore = exports['qb-core']:GetCoreObject()
local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        Citizen.Wait(200)
    end
    coreLoaded = true
end)

local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)

local cVehicle = nil
local Dimensions = nil
local cDistance =  nil
local cVehicleCoords = nil
local IsInFront =  nil
local Hold = 0

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) and coreLoaded then
            local closestVehicle, Distance = QBCore.Functions.GetClosestVehicle()
            if Distance < 4.5 then
                cVehicle = closestVehicle
                cVehicleCoords = GetEntityCoords(cVehicle)
                Dimensions = GetModelDimensions(GetEntityModel(cVehicle), First, Second)
                cDistance = Distance
                if GetDistanceBetweenCoords(cVehicleCoords + GetEntityForwardVector(cVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(cVehicleCoords + GetEntityForwardVector(cVehicle) * -1, GetEntityCoords(ped), true) then
                    IsInFront = false
                else
                    IsInFront = true
                end
            else
                cVehicle = nil
                Dimensions = nil
                cDistance =  nil
                cVehicleCoords = nil
                IsInFront =  nil
                Hold = 0
            end
        end
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do 
        local time = 1000
        if cVehicle then
            local ped = PlayerPedId()
            time = 1

            if IsControlPressed(0, 21) and not IsPedJumping(Ped) and IsVehicleSeatFree(cVehicle, -1) and not IsEntityAttachedToEntity(Ped, cVehicle) and IsControlPressed(0, 38) then
                Citizen.Wait(100)
                Hold = Hold + 1
            else
                Hold = 0
            end

            if Hold >= 5 then
                if IsControlPressed(0, 21) and not IsPedJumping(ped) and IsVehicleSeatFree(cVehicle, -1) and not IsEntityAttachedToEntity(ped, cVehicle) and IsControlPressed(0, 38) then
                    NetworkRequestControlOfEntity(cVehicle)
                    local coords = GetEntityCoords(ped)
                    if IsInFront then    
                        AttachEntityToEntity(PlayerPedId(), cVehicle, GetPedBoneIndex(6286), 0.0, Dimensions.y * -1 + 0.1 , Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
                    else
                        AttachEntityToEntity(PlayerPedId(), cVehicle, GetPedBoneIndex(6286), 0.0, Dimensions.y - 0.3, Dimensions.z  + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
                    end

                    RequestAnimDict('missfinale_c2ig_11')
                    while not HasAnimDictLoaded("missfinale_c2ig_11") do
                        Citizen.Wait(2)
                    end
                    TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)

                    local currentVehicle = cVehicle
                    while true do
                        Citizen.Wait(5)
                        if IsDisabledControlPressed(0, 34) then
                            TaskVehicleTempAction(PlayerPedId(), currentVehicle, 11, 1000)
                        end

                        if IsDisabledControlPressed(0, 9) then
                            TaskVehicleTempAction(PlayerPedId(), currentVehicle, 10, 1000)
                        end

                        if IsInFront then
                            SetVehicleForwardSpeed(currentVehicle, -1.0)
                        else
                            SetVehicleForwardSpeed(currentVehicle, 1.0)
                        end

                        if not IsDisabledControlPressed(0, 21) then
                            DetachEntity(ped, false, false)
                            StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
                            ClearPedTasks(ped)
                            FreezeEntityPosition(ped, false)
                            break
                        end
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)