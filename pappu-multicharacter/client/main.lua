local cam = nil
local charPed = nil
local extraPed = nil
local activeChar = nil
local extraChar = nil
local arrowActive = false
local loadScreenCheckState = false
local QBCore = exports['qb-core']:GetCoreObject()
local cached_player_skins = {}

local randommodels = { -- models possible to load when choosing empty slot
    'mp_m_freemode_01',
    'mp_f_freemode_01',
}

-- Joaat function definition
local function joaat(key)
    local str = string.upper(key)
    local hash, i = 0, 1
    while i <= #str do
        hash = hash + string.byte(str, i)
        hash = hash + (hash << 10)
        hash = hash ~ (hash >> 6)
        i = i + 1
    end
    hash = hash + (hash << 3)
    hash = hash ~ (hash >> 11)
    hash = hash + (hash << 15)
    return hash
end

-- Main Thread

CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            TriggerEvent('pappu-multicharacter:client:chooseChar')
            return
        end
    end
end)

-- Functions

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end


local function initializePedModel(model, data)
    CreateThread(function()
        if not model then
            model = joaat(randommodels[math.random(#randommodels)])
        end
        loadModel(model)
        charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
        SetPedComponentVariation(charPed, 0, 0, 0, 2)
        FreezeEntityPosition(charPed, false)
        SetEntityInvincible(charPed, true)
        PlaceObjectOnGroundProperly(charPed)
        SetBlockingOfNonTemporaryEvents(charPed, true)
        if data then
            TriggerEvent('qb-clothing:client:loadPlayerClothing', data, charPed)
        end
    end)
end

local function spawnPreviewPed(cData, coords, isExtra)
    CreateThread(function()
        local model
        local data
        if cData then
            if not cached_player_skins[cData.citizenid] then
                local temp_model = promise.new()
                local temp_data = promise.new()
                QBCore.Functions.TriggerCallback('pappu-multicharacter:server:getSkin', function(m, d)
                    temp_model:resolve(m)
                    temp_data:resolve(d)
                end, cData.citizenid)
                model = Citizen.Await(temp_model)
                data = Citizen.Await(temp_data)
                cached_player_skins[cData.citizenid] = {model = model, data = data}
            else
                model = cached_player_skins[cData.citizenid].model
                data = cached_player_skins[cData.citizenid].data
            end
        end

        model = model ~= nil and tonumber(model) or joaat(randommodels[math.random(#randommodels)])
        loadModel(model)
        local ped = CreatePed(2, model, coords.x, coords.y, coords.z - 0.98, coords.w, false, true)
        SetPedComponentVariation(ped, 0, 0, 0, 2)
        FreezeEntityPosition(ped, false)
        SetEntityInvincible(ped, true)
        PlaceObjectOnGroundProperly(ped)
        SetBlockingOfNonTemporaryEvents(ped, true)
        if data then
            data = json.decode(data)
            TriggerEvent('qb-clothing:client:loadPlayerClothing', data, ped)
        end
        if isExtra then
            local RandomAnimins = {
                "WORLD_HUMAN_HANG_OUT_STREET",
                "WORLD_HUMAN_STAND_IMPATIENT",
                "WORLD_HUMAN_STAND_MOBILE",
                "WORLD_HUMAN_SMOKING_POT",
                "WORLD_HUMAN_LEANING",
                "WORLD_HUMAN_DRUG_DEALER_HARD",
                "WORLD_HUMAN_MUSCLE_FLEX",
                "WORLD_HUMAN_STAND_MOBILE_UPRIGHT",
                "WORLD_HUMAN_CLIPBOARD",
                "WORLD_HUMAN_AA_SMOKE",
                "WORLD_HUMAN_DRINKING",
                "WORLD_HUMAN_CHEERING",
                "WORLD_HUMAN_HUMAN_STATUE",
                "WORLD_HUMAN_STUPOR",
                "WORLD_HUMAN_TOURIST_MOBILE",
                "WORLD_HUMAN_JOG_STANDING",
                "WORLD_HUMAN_PUSH_UPS",
                "WORLD_HUMAN_SIT_UPS",
                "WORLD_HUMAN_YOGA",
                "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS",
                "WORLD_HUMAN_PROSTITUTE_LOW_CLASS",
                "WORLD_HUMAN_CAR_PARK_ATTENDANT",
                "WORLD_HUMAN_GUARD_STAND",
                "WORLD_HUMAN_BINOCULARS",
                "WORLD_HUMAN_PAPARAZZI"
            }
            local PlayAnimin = RandomAnimins[math.random(#RandomAnimins)]
            SetPedCanPlayAmbientAnims(ped, true)
            TaskStartScenarioInPlace(ped, PlayAnimin, 0, true)
        end

        if isExtra then
            extraPed = ped
        else
            charPed = ped
        end
    end)
end

local function spawnPreviewPeds(characters)
    if DoesEntityExist(charPed) then DeleteEntity(charPed) end
    if DoesEntityExist(extraPed) then DeleteEntity(extraPed) end
    charPed = nil
    extraPed = nil
    activeChar = characters[1]
    extraChar = characters[2]
    if activeChar then
        spawnPreviewPed(activeChar, Config.PedCoords, false)
    else
        spawnPreviewPed(nil, Config.PedCoords, false)
    end
    if extraChar then
        spawnPreviewPed(extraChar, Config.SecondPedCoords, true)
    elseif characters[1] then
        spawnPreviewPed(characters[1], Config.PedCoords, false)
    else
        spawnPreviewPed(nil, Config.PedCoords, false)
    end
    if characters[2] then
        spawnPreviewPed(characters[2], Config.SecondPedCoords, true)
    end
    if not arrowActive then
        arrowActive = true
        CreateThread(function()
            while arrowActive do
                if charPed and DoesEntityExist(charPed) then
                    local c = GetEntityCoords(charPed)
                    DrawMarker(2, c.x, c.y, c.z + 1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 148, 0, 211, 200, false, true, 2, false, nil, nil, false)
                    DrawMarker(27, c.x, c.y, c.z + 1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 148, 0, 211, 200, false, true, 2, false, nil, nil, false)
                end
                Wait(0)
            end
        end)
    end
end

local function skyCam(bool)
    TriggerEvent('qb-weathersync:client:DisableSync')
    if bool then
        DoScreenFadeIn(1000)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        FreezeEntityPosition(PlayerPedId(), false)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Config.CamCoords.x, Config.CamCoords.y, Config.CamCoords.z, 0.0 ,0.0, Config.CamCoords.w, 60.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    else
        SetTimecycleModifier('default')
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(PlayerPedId(), false)
    end
end

local function openCharMenu(bool)
    QBCore.Functions.TriggerCallback("pappu-multicharacter:server:GetNumberOfCharacters", function(result)
        local translations = {}
        for k in pairs(Lang.fallback and Lang.fallback.phrases or Lang.phrases) do
            if k:sub(0, ('ui.'):len()) then
                translations[k:sub(('ui.'):len() + 1)] = Lang:t(k)
            end
        end
        SetNuiFocus(bool, bool)
        SendNUIMessage({
            action = "ui",
            customNationality = Config.customNationality,
            toggle = bool,
            nChar = result,
            enableDeleteButton = Config.EnableDeleteButton,
            translations = translations
        })
        skyCam(bool)
        if not loadScreenCheckState then
            ShutdownLoadingScreenNui()
            loadScreenCheckState = true
        end
    end)
end

-- Events

RegisterNetEvent('pappu-multicharacter:client:closeNUIdefault', function() -- This event is only for no starting apartments
    if not IsScreenFadedOut() then DoScreenFadeOut(500) end
    if DoesEntityExist(charPed) then DeleteEntity(charPed) end
    if DoesEntityExist(extraPed) then DeleteEntity(extraPed) end
    arrowActive = false
    SetNuiFocus(false, false)
    DoScreenFadeOut(500)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), Config.DefaultSpawn.x, Config.DefaultSpawn.y, Config.DefaultSpawn.z)
    --TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    --TriggerEvent('QBCore:Client:OnPlayerLoaded')
    TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
    TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
    Wait(500)
    openCharMenu()
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(250)
    local coords = vector3(-763.2816, 330.0418, 199.4865)
    local interior = GetInteriorAtCoords(coords)
    TriggerEvent('qb-weathersync:client:EnableSync')
    local PlayerId = PlayerId()
    local ped = PlayerPedId()
    DoScreenFadeOut(250)
    SetEntityHeading(PlayerPedId(), 180.0)
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent("qb-clothing:enterCreationBucket")
    Wait(1500)
    DoScreenFadeIn(150)
    TriggerEvent('qb-clothes:client:CreateFirstCharacter', coords)
end)

RegisterNetEvent('pappu-multicharacter:client:closeNUI', function()
    if DoesEntityExist(charPed) then DeleteEntity(charPed) end
    if DoesEntityExist(extraPed) then DeleteEntity(extraPed) end
    arrowActive = false
    SetNuiFocus(false, false)
end)

RegisterNetEvent('pappu-multicharacter:client:chooseChar', function()
    SetNuiFocus(false, false)
    DoScreenFadeOut(10)
    Wait(1000)
    local interior = GetInteriorAtCoords(Config.Interior.x, Config.Interior.y, Config.Interior.z - 18.9)
    LoadInterior(interior)
    while not IsInteriorReady(interior) do
        Wait(1000)
    end
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), Config.HiddenCoords.x, Config.HiddenCoords.y, Config.HiddenCoords.z)
    Wait(1500)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    openCharMenu(true)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    print('working #pappu-multicharacter')
end)


RegisterNetEvent('pappu-multicharacter:client:spawnLastLocation', function(coords, cData)
    QBCore.Functions.TriggerCallback('apartments:GetOwnedApartment', function(result)
        if result then
            TriggerEvent("apartments:client:SetHomeBlip", result.type)
            local ped = PlayerPedId()
            SetEntityCoords(ped, coords.x, coords.y, coords.z)
            SetEntityHeading(ped, coords.w)
            FreezeEntityPosition(ped, false)
            SetEntityVisible(ped, true)
            local PlayerData = QBCore.Functions.GetPlayerData()
            local insideMeta = PlayerData.metadata["inside"]
            DoScreenFadeOut(500)

            if insideMeta.house then
                TriggerEvent('qb-houses:client:LastLocationHouse', insideMeta.house)
            elseif insideMeta.apartment.apartmentType and insideMeta.apartment.apartmentId then
                TriggerEvent('qb-apartments:client:LastLocationHouse', insideMeta.apartment.apartmentType, insideMeta.apartment.apartmentId)
            else
                SetEntityCoords(ped, coords.x, coords.y, coords.z)
                SetEntityHeading(ped, coords.w)
                FreezeEntityPosition(ped, false)
                SetEntityVisible(ped, true)
            end

            TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
            TriggerEvent('QBCore:Client:OnPlayerLoaded')
            Wait(2000)
            DoScreenFadeIn(250)
        end
    end, cData.citizenid)
end)

-- NUI Callbacks

RegisterNUICallback('closeUI', function(_, cb)
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('pappu-multicharacter:server:loadUserData', cData)
    openCharMenu(false)
    SetEntityAsMissionEntity(charPed, true, true)
    if DoesEntityExist(charPed) then DeleteEntity(charPed) end
    if DoesEntityExist(extraPed) then DeleteEntity(extraPed) end
    arrowActive = false
    if Config.SkipSelection then
        SetNuiFocus(false, false)
        skyCam(false)
    else
        openCharMenu(false)
    end
    cb("ok")
end)

RegisterNUICallback('disconnectButton', function(_, cb)
    SetEntityAsMissionEntity(charPed, true, true)
    if DoesEntityExist(charPed) then DeleteEntity(charPed) end
    if DoesEntityExist(extraPed) then DeleteEntity(extraPed) end
    arrowActive = false
    TriggerServerEvent('pappu-multicharacter:server:disconnect')
    cb("ok")
end)

-- NUI Callbacks

RegisterNUICallback('closeUI', function(_, cb)
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('pappu-multicharacter:server:loadUserData', cData)
    openCharMenu(false)
    SetEntityAsMissionEntity(charPed, true, true)
    if DoesEntityExist(charPed) then DeleteEntity(charPed) end
    if DoesEntityExist(extraPed) then DeleteEntity(extraPed) end
    arrowActive = false
    if Config.SkipSelection then
        SetNuiFocus(false, false)
        skyCam(false)
    else
        openCharMenu(false)
    end
    cb("ok")
end)

RegisterNUICallback('disconnectButton', function(_, cb)
    SetEntityAsMissionEntity(charPed, true, true)
    if DoesEntityExist(charPed) then DeleteEntity(charPed) end
    if DoesEntityExist(extraPed) then DeleteEntity(extraPed) end
    arrowActive = false
    TriggerServerEvent('pappu-multicharacter:server:disconnect')
    cb("ok")
end)

RegisterNUICallback('selectCharacter', function(data, cb)
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('pappu-multicharacter:server:loadUserData', cData)
    openCharMenu(false)
    SetEntityAsMissionEntity(charPed, true, true)
    if DoesEntityExist(charPed) then DeleteEntity(charPed) end
    if DoesEntityExist(extraPed) then DeleteEntity(extraPed) end
    arrowActive = false
    cb("ok")
end)

RegisterNUICallback('cDataPed', function(nData, cb)
    local cData = nData.cData
    local previous = activeChar
    activeChar = cData
    extraChar = previous
    spawnPreviewPeds({activeChar, extraChar})
    cb("ok")
    SetEntityAsMissionEntity(charPed, true, true)
    if DoesEntityExist(charPed) then DeleteEntity(charPed) end
    if cData ~= nil then
        if not cached_player_skins[cData.citizenid] then
            local temp_model = promise.new()
            local temp_data = promise.new()

            QBCore.Functions.TriggerCallback('pappu-multicharacter:server:getSkin', function(model, data)
                temp_model:resolve(model)
                temp_data:resolve(data)
            end, cData.citizenid)

            local resolved_model = Citizen.Await(temp_model)
            local resolved_data = Citizen.Await(temp_data)

            cached_player_skins[cData.citizenid] = {model = resolved_model, data = resolved_data}
        end

        local model = cached_player_skins[cData.citizenid].model
        local data = cached_player_skins[cData.citizenid].data

        model = model ~= nil and tonumber(model) or false

        if model ~= nil then
            CreateThread(function()
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Wait(0)
                end
                charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
                local RandomAnimins = {
                    "WORLD_HUMAN_HANG_OUT_STREET",
                    "WORLD_HUMAN_STAND_IMPATIENT",
                    "WORLD_HUMAN_STAND_MOBILE",
                    "WORLD_HUMAN_SMOKING_POT",
                    "WORLD_HUMAN_LEANING",
                    "WORLD_HUMAN_DRUG_DEALER_HARD",
                    "WORLD_HUMAN_MUSCLE_FLEX",
                    "WORLD_HUMAN_STAND_MOBILE_UPRIGHT",
                    "WORLD_HUMAN_CLIPBOARD",
                    "WORLD_HUMAN_AA_SMOKE",
                    "WORLD_HUMAN_DRINKING",
                    "WORLD_HUMAN_CHEERING",
                    "WORLD_HUMAN_HUMAN_STATUE",
                    "WORLD_HUMAN_STUPOR",
                    "WORLD_HUMAN_TOURIST_MOBILE",
                    "WORLD_HUMAN_JOG_STANDING",
                    "WORLD_HUMAN_PUSH_UPS",
                    "WORLD_HUMAN_SIT_UPS",
                    "WORLD_HUMAN_YOGA",
                    "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS",
                    "WORLD_HUMAN_PROSTITUTE_LOW_CLASS",
                    "WORLD_HUMAN_CAR_PARK_ATTENDANT",
                    "WORLD_HUMAN_GUARD_STAND",
                    "WORLD_HUMAN_BINOCULARS",
                    "WORLD_HUMAN_PAPARAZZI"
                }
                local PlayAnimin = RandomAnimins[math.random(#RandomAnimins)]
                SetPedCanPlayAmbientAnims(charPed, true)
                TaskStartScenarioInPlace(charPed, PlayAnimin, 0, true)
                SetPedComponentVariation(charPed, 0, 0, 0, 2)
                FreezeEntityPosition(charPed, false)
                SetEntityInvincible(charPed, true)
                PlaceObjectOnGroundProperly(charPed)
                SetBlockingOfNonTemporaryEvents(charPed, true)
                data = json.decode(data)
                TriggerEvent('qb-clothing:client:loadPlayerClothing', data, charPed)
            end)
        else
            initializePedModel()
        end
        cb("ok")
    else
        initializePedModel()
        cb("ok")
    end
end)

RegisterNUICallback('setupCharacters', function(_, cb)
    QBCore.Functions.TriggerCallback("pappu-multicharacter:server:setupCharacters", function(result)
        cached_player_skins = {}
        SendNUIMessage({
            action = "setupCharacters",
            characters = result
        })
        spawnPreviewPeds(result)
        cb("ok")
    end)
end)

RegisterNUICallback('removeBlur', function(_, cb)
    SetTimecycleModifier('default')
    cb("ok")
end)

RegisterNUICallback('createNewCharacter', function(data, cb)
    local cData = data
    DoScreenFadeOut(150)
    if cData.gender == "Mężczyzna" then
        cData.gender = 0
    elseif cData.gender == "Kobieta" then
        cData.gender = 1
    end
    TriggerServerEvent('pappu-multicharacter:server:createCharacter', cData)
    Wait(500)
    cb("ok")
end)

RegisterNUICallback('removeCharacter', function(data, cb)
    print(data.citizenid)
    TriggerServerEvent('pappu-multicharacter:server:deleteCharacter', data.citizenid)
    TriggerEvent('pappu-multicharacter:client:chooseChar')
    print('usunieta')
    cb("ok")
end)
