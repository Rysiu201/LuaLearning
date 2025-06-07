QBCore = exports['qb-core']:GetCoreObject()
PlayerData = QBCore.Functions.GetPlayerData() -- Setting this for when you restart the resource in game
local inRadialMenu = false
local garaIndex = nil
local jobIndex = nil
local vehicleIndex = nil

local DynamicMenuItems = {}
local FinalMenuItems = {}
-- Functions

local function mdt()
    if QBCore.Functions.GetPlayerData().job.name == "police" then
        mdtid = exports['qb-radialmenu']:AddOption({
            id = 'mdt',
            title = 'Mdt',
            icon = 'tablet',
            type = 'command',
            event = 'mdt',
            shouldClose = true
        }, mdtid)
    else
        if mdtid ~= nil then
            exports['qb-radialmenu']:RemoveOption(mdtid)
            mdtid = nil
        end
    end
end



local function deepcopy(orig) -- modified the deep copy function from http://lua-users.org/wiki/CopyTable
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if not orig.canOpen or orig.canOpen() then
            local toRemove = {}
            copy = {}
            for orig_key, orig_value in next, orig, nil do
                if type(orig_value) == 'table' then
                    if not orig_value.canOpen or orig_value.canOpen() then
                        copy[deepcopy(orig_key)] = deepcopy(orig_value)
                    else
                        toRemove[orig_key] = true
                    end
                else
                    copy[deepcopy(orig_key)] = deepcopy(orig_value)
                end
            end
            for i=1, #toRemove do table.remove(copy, i) --[[ Using this to make sure all indexes get re-indexed and no empty spaces are in the radialmenu ]] end
            if copy and next(copy) then setmetatable(copy, deepcopy(getmetatable(orig))) end
        end
    elseif orig_type ~= 'function' then
        copy = orig
    end
    return copy
end

local function getNearestVeh()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

local function AddOption(data, id)
    local menuID = id ~= nil and id or (#DynamicMenuItems + 1)
    DynamicMenuItems[menuID] = deepcopy(data)
    return menuID
end

local function RemoveOption(id)
    DynamicMenuItems[id] = nil
end

local function SetupJobMenu()
    local JobMenu = {
        id = 'jobinteractions',
        title = 'İş Eylemleri',
        icon = 'briefcase',
        items = {}
    }
    if Config.JobInteractions[PlayerData.job.name] and next(Config.JobInteractions[PlayerData.job.name]) then
        JobMenu.items = Config.JobInteractions[PlayerData.job.name]
    end

    if #JobMenu.items == 0 then
        if jobIndex then
            RemoveOption(jobIndex)
            jobIndex = nil
        end
    else
        jobIndex = AddOption(JobMenu, jobIndex)
    end
end

local function SetupVehicleMenu()
    local VehicleMenu = {
        id = 'control',
        title = 'Araç Eylemleri',
        icon = 'car',
        type = 'client',
        event = 'vehcontrol:openExternal',
        shouldClose = true,
    }

    local ped = PlayerPedId()
    local Vehicle = GetVehiclePedIsIn(ped) ~= 0 and GetVehiclePedIsIn(ped) or getNearestVeh()
   

    if Vehicle == 0 then                 --fixed for new vehcontrol
        if vehicleIndex then
            RemoveOption(vehicleIndex)
            vehicleIndex = nil
        end
    else
        vehicleIndex = AddOption(VehicleMenu, vehicleIndex)
    end
end

local function SetupSubItems()
    SetupJobMenu()
    SetupVehicleMenu()
--	SetupGaragesMenu()
end

local function selectOption(t, t2)
    for _, v in pairs(t) do
        if v.items then
            local found, hasAction, val = selectOption(v.items, t2)
            if found then return true, hasAction, val end
        else
            if v.id == t2.id and ((v.event and v.event == t2.event) or v.action) and (not v.canOpen or v.canOpen()) then
                return true, v.action, v
            end
        end
    end
    return false
end

local function IsPoliceOrEMS()
    return (PlayerData.job.name == "police" or PlayerData.job.name == "ambulance")
end

local function IsDowned()
    return (PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"])
end

local function SetupRadialMenu()
    FinalMenuItems = {}
    if (IsDowned() and IsPoliceOrEMS()) then
        FinalMenuItems = {
            [1] = {
                id = 'emergencybutton1',
                title = '10-13A',
                icon = 'sad-tear',
                type = 'client',
                event = 'ps-dispatch:client:officerdown',
                shouldClose = true,
            },
            [2] = {
                id = 'emergencybutton2',
                title = '10-13B',
                icon = 'sad-cry',
                type = 'client',
                event = 'ps-dispatch:client:officerdown',
                shouldClose = true,
            },
        }
    else
        SetupSubItems()
        FinalMenuItems = deepcopy(Config.MenuItems)
        for _, v in pairs(DynamicMenuItems) do
            FinalMenuItems[#FinalMenuItems+1] = v
        end
    end
end

local function setRadialState(bool, sendMessage, delay)
    -- Menuitems have to be added only once

    if bool then
        TriggerEvent('qb-radialmenu:client:onRadialmenuOpen')
        SetupRadialMenu()
    else
        TriggerEvent('qb-radialmenu:client:onRadialmenuClose')
    end

    SetNuiFocus(bool, bool)
    if sendMessage then
        SendNUIMessage({
            action = "ui",
            radial = bool,
            items = FinalMenuItems
        })
    end
    if delay then Wait(500) end
    inRadialMenu = bool
end

-- Command

RegisterCommand('radialmenu', function()
    if ((IsDowned() and IsPoliceOrEMS()) or not IsDowned()) and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() and not inRadialMenu then
        setRadialState(true, true)
        SetCursorLocation(0.5, 0.5)
    end
end)

RegisterKeyMapping('radialmenu', Lang:t("general.command_description"), 'keyboard', 'F3')

-- Events

-- Sets the metadata when the player spawns
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

-- Sets the playerdata to an empty table when the player has quit or did /logout
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

-- This will update all the PlayerData that doesn't get updated with a specific event other than this like the metadata
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('qb-radialmenu:client:noPlayers', function()
    QBCore.Functions.Notify(Lang:t("error.no_people_nearby"), 'error', 2500)
end)

RegisterNetEvent('qb-radialmenu:client:openDoor', function(data)
    local string = data.id
    local replace = string:gsub("door", "")
    local door = tonumber(replace)
    local ped = PlayerPedId()
    local closestVehicle = GetVehiclePedIsIn(ped) ~= 0 and GetVehiclePedIsIn(ped) or getNearestVeh()
    if closestVehicle ~= 0 then
        if closestVehicle ~= GetVehiclePedIsIn(ped) then
            local plate = QBCore.Functions.GetPlate(closestVehicle)
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('qb-radialmenu:trunk:server:Door', false, plate, door)
                else
                    SetVehicleDoorShut(closestVehicle, door, false)
                end
            else
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('qb-radialmenu:trunk:server:Door', true, plate, door)
                else
                    SetVehicleDoorOpen(closestVehicle, door, false, false)
                end
            end
        else
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                SetVehicleDoorShut(closestVehicle, door, false)
            else
                SetVehicleDoorOpen(closestVehicle, door, false, false)
            end
        end
    else
        QBCore.Functions.Notify(Lang:t("error.no_vehicle_found"), 'error', 2500)
    end
end)

RegisterNetEvent('qb-radialmenu:client:setExtra', function(data)
    local string = data.id
    local replace = string:gsub("extra", "")
    local extra = tonumber(replace)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh ~= nil then
        if GetPedInVehicleSeat(veh, -1) == ped then
            SetVehicleAutoRepairDisabled(veh, true) -- Forces Auto Repair off when Toggling Extra [GTA 5 Niche Issue]
            if DoesExtraExist(veh, extra) then
                if IsVehicleExtraTurnedOn(veh, extra) then
                    SetVehicleExtra(veh, extra, 1)
                    QBCore.Functions.Notify(Lang:t("error.extra_deactivated", {extra = extra}), 'error', 2500)
                else
                    SetVehicleExtra(veh, extra, 0)
                    QBCore.Functions.Notify(Lang:t("success.extra_activated", {extra = extra}), 'success', 2500)
                end
            else
                QBCore.Functions.Notify(Lang:t("error.extra_not_present", {extra = extra}), 'error', 2500)
            end
        else
            QBCore.Functions.Notify(Lang:t("error.not_driver"), 'error', 2500)
        end
    end
end)

RegisterNetEvent('qb-radialmenu:trunk:client:Door', function(plate, door, open)
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh ~= 0 then
        local pl = QBCore.Functions.GetPlate(veh)
        if pl == plate then
            if open then
                SetVehicleDoorOpen(veh, door, false, false)
            else
                SetVehicleDoorShut(veh, door, false)
            end
        end
    end
end)

RegisterNetEvent('qb-radialmenu:client:ChangeSeat', function(data)
    local Veh = GetVehiclePedIsIn(PlayerPedId())
    local IsSeatFree = IsVehicleSeatFree(Veh, data.id)
    local speed = GetEntitySpeed(Veh)
    local HasHarnass = exports['qb-smallresources']:HasHarness()
    if not HasHarnass then
        local kmh = speed * 3.6
        if IsSeatFree then
            if kmh <= 100.0 then
                SetPedIntoVehicle(PlayerPedId(), Veh, data.id)
                QBCore.Functions.Notify(Lang:t("info.switched_seats", {seat = data.title}))
            else
                QBCore.Functions.Notify(Lang:t("error.vehicle_driving_fast"), 'error')
            end
        else
            QBCore.Functions.Notify(Lang:t("error.seat_occupied"), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t("error.race_harness_on"), 'error')
    end
end)

-- NUI Callbacks

RegisterNUICallback('closeRadial', function(data, cb)
    setRadialState(false, false, data.delay)
    cb('ok')
end)

RegisterNUICallback('selectItem', function(inData, cb)
    local itemData = inData.itemData
    local found, action, data = selectOption(FinalMenuItems, itemData)
    if data and found then
        if action then
            action(data)
        elseif data.type == 'client' then
            TriggerEvent(data.event, data)
        elseif data.type == 'server' then
            TriggerServerEvent(data.event, data)
        elseif data.type == 'command' then
            ExecuteCommand(data.event)
        elseif data.type == 'qbcommand' then
            TriggerServerEvent('QBCore:CallCommand', data.event, data)
        end
    end
    cb('ok')
end)

RegisterNetEvent('ters-duz')
AddEventHandler('ters-duz', function()
    local playerped = PlayerPedId()
    if not IsPedInAnyVehicle(playerped) then
        local PlayerCoords = GetEntityCoords(playerped)
        local arac, mesafe = QBCore.Functions.GetClosestVehicle(PlayerCoords)
        if mesafe < 5 then
            QBCore.Functions.Progressbar("ters-duz", "Araç Çevriliyor", 5000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                SetVehicleOnGroundProperly(arac)
            end, function() -- Cancel
            end)
        else
            QBCore.Functions.Notify("Yakınlarda Araç Yok") 
        end
	else
		QBCore.Functions.Notify("Araç İçindeki İken Bu İşlemi Gerçekleştiremezsin") 
	end
end)

RegisterNetEvent('tgiann-menuv3:arac-cek')
AddEventHandler('tgiann-menuv3:arac-cek', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle, mesafe = QBCore.Functions.GetClosestVehicle(coords)
    if mesafe < 8 then
        if not inVehicle then
            if DoesEntityExist(vehicle) then
                deleteVeh(vehicle)
            end
        end
    end
end)

function GetClosestPlayerMenu()
	local player, distance = QBCore.Functions.GetClosestPlayer()
	if distance ~= -1 and distance <= 3.0 then
		return true, GetPlayerServerId(player)
	else
		return false
	end
end

RegisterNetEvent("ehliyet:bak")
AddEventHandler("ehliyet:bak", function()
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
end)

RegisterNetEvent("ehliyet:ver")
AddEventHandler("ehliyet:ver", function()
	local found, player = GetClosestPlayerMenu()
	if found then
    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), player, 'driver')
	else
		QBCore.Functions.Notify("Yakında Oyuncu Yok", "error")
	end
end)

RegisterNetEvent("kimlik:bak")
AddEventHandler("kimlik:bak", function()
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent("kimlik:ver")
AddEventHandler("kimlik:ver", function()
	local found, player = GetClosestPlayerMenu()
	if found then
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), player)
	else
		QBCore.Functions.Notify("Yakında Oyuncu Yok", "error")
	end
end)

RegisterNetEvent('kimlikislemleri')
AddEventHandler('kimlikislemleri', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    exports["qb-menu"]:openMenu({
        {
            header = "Kimlik İşlemleri",
        },
        {
            header = "Kimliğine Bak",
            txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname,
            params = {
                event = "kimlik:bak",
                args = {
                    message = "Kimliğine bakmana yarar."
                }
            }
        },
        {
            header = "Kimliğini Ver",
            txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname,
            params = {
                event = "kimlik:ver",
                args = {
                    message = "Kimliğini yanındakine verir."
                }
            }
        },
        {
            header = "Ehliyetine Bak",
            txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname,
            params = {
                event = "ehliyet:bak",
                args = {
                    message = "Ehliyetine bakmana yarar."
                }
            }
        },
        {
            header = "Ehliyetini Ver",
            txt = "" .. PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname,
            params = {
                event = "ehliyet:ver",
                args = {
                    message = "Ehliyetini yanındakine verir."
                }
            }
        },
        
    })
end)

function deleteVeh(veh)
	SetVehicleHasBeenOwnedByPlayer(veh, true)
	NetworkRequestControlOfEntity(veh)
	TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

	QBCore.Functions.Progressbar("arac_cek", "Araç Çekiliyor...", 3000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
		DeleteEntity(veh)
		DeleteVehicle(veh)
		SetEntityAsNoLongerNeeded(veh)
        ClearPedTasksImmediately(PlayerPedId()) 
	end, function() -- Cancel
		ClearPedTasksImmediately(PlayerPedId()) 
	end)
end


RegisterNetEvent('bedoflex:hijack')
AddEventHandler('bedoflex:hijack', function()
    local playerPed = PlayerPedId()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle()
    local coords = GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
        TriggerEvent("QBCore:Notify",'Bu işlemi aracın içerisinde yapamazsın')
        return
    end
    if distance < 3 then
        if DoesEntityExist(vehicle) then
            isBusy = true
            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
            Citizen.CreateThread(function()
                Citizen.Wait(10000)

                SetVehicleDoorsLocked(vehicle, 1)
                SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                ClearPedTasksImmediately(playerPed)
                TriggerEvent("QBCore:Notify",'Araç kilidi açıldı')
                isBusy = false
            end)
        else
            TriggerEvent("QBCore:Notify", 'Yakınında araç yok')
        end
    else
        TriggerEvent("QBCore:Notify", 'Yakınında araç yok')
    end
end)

RegisterNetEvent('bedoflex:mechimpound')
AddEventHandler('bedoflex:mechimpound', function()
    local playerPed = PlayerPedId()

    if IsPedSittingInAnyVehicle(playerPed) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if GetPedInVehicleSeat(vehicle, -1) == playerPed then
            TriggerEvent("QBCore:Notify", 'Araç haczedildi')
            QBCore.Functions.DeleteVehicle(vehicle)
        else
            TriggerEvent("QBCore:Notify", 'Bu işlemi yapabilmek için sürücü koltuğunda olmalısın')
        end
    else
        local vehicle, distance = QBCore.Functions.GetClosestVehicle()

        if distance < 3 then
            if DoesEntityExist(vehicle) then
                TriggerEvent("QBCore:Notify", 'Araç haczedildi')
                QBCore.Functions.DeleteVehicle(vehicle)
            else
                TriggerEvent("QBCore:Notify", 'Aracın yakınında olman gerekiyor')
            end
        else
            TriggerEvent("QBCore:Notify", 'Aracın yakınında olman gerekiyor')
        end
    end
end)

RegisterNetEvent('bedoflex:mechrepair')
AddEventHandler('bedoflex:mechrepair', function()
    local playerPed = PlayerPedId()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle()
    local coords = GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
        TriggerEvent("QBCore:Notify", 'Bu işlemi aracın içerisinde yapamazsın')
        return
    end

    if distance < 3 then
        if DoesEntityExist(vehicle) then
            isBusy = true
            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
            QBCore.Functions.Progressbar("tamir", "Aracı tamir ediyorsun", 20000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                SetVehicleFixed(vehicle)
                SetVehicleDeformationFixed(vehicle)
                SetVehicleUndriveable(vehicle, false)
                SetVehicleEngineOn(vehicle, true, true)
                ClearPedTasksImmediately(playerPed)
                TriggerEvent("QBCore:Notify", 'Araç tamir edildi')
                isBusy = false
            end, function()
                ClearPedTasks(PlayerPedId())
                QBCore.Functions.Notify("İptal edildi", "error")
                isBusy = false
            end)
        else
            TriggerEvent("QBCore:Notify", 'Yakınında araç yok')
        end
    else
        TriggerEvent("QBCore:Notify", 'Yakınında araç yok')
    end
end)

RegisterNetEvent('bedoflex:mechclean')
AddEventHandler('bedoflex:mechclean', function()
    local playerPed = PlayerPedId()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle()
    local coords = GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
        TriggerEvent("QBCore:Notify",'Bu işlemi aracın içerisinde yapamazsın')
        return
    end
    if distance < 3 then
        if DoesEntityExist(vehicle) then
            isBusy = true
            TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
            Citizen.CreateThread(function()
                Citizen.Wait(10000)

                SetVehicleDirtLevel(vehicle, 0)
                ClearPedTasksImmediately(playerPed)
                TriggerEvent("QBCore:Notify", 'Araç temizlendi')
                isBusy = false
            end)
        else
            TriggerEvent("QBCore:Notify", 'Yakınında araç yok')
        end
    else
        TriggerEvent("QBCore:Notify", 'Yakınında araç yok')
    end
end)

exports('AddOption', AddOption)
exports('RemoveOption', RemoveOption)
