local cam = nil
local arrowActive = false
local arrowPed = nil
local spawnedPeds = {}
local spawnedData = {}
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

local function safeDelete(entity)
    if not DoesEntityExist(entity) then return end

    NetworkRequestControlOfEntity(entity)
    local attempts = 0
    while not NetworkHasControlOfEntity(entity) and attempts < 50 do
        Wait(0)
        NetworkRequestControlOfEntity(entity)
        attempts = attempts + 1
    end

    SetEntityAsMissionEntity(entity, false, true)
    DeleteEntity(entity)
end


local function spawnPreviewPed(cData, coords, anim)
local function spawnPreviewPed(cData, coords)
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
    local chosenAnim = anim or Config.PreviewAnimations[math.random(#Config.PreviewAnimations)]
    SetPedCanPlayAmbientAnims(ped, true)
    TaskStartScenarioInPlace(ped, chosenAnim, 0, true)
    return ped
end

local function spawnPreviewPeds(characters)
    for _, ped in pairs(spawnedPeds) do
        safeDelete(ped)
    end
    spawnedPeds = {}
    spawnedData = {}

    local available = {}
    for i, v in ipairs(Config.PreviewSlots) do
        available[i] = v
    local anim = Config.PreviewAnimations[math.random(#Config.PreviewAnimations)]
    SetPedCanPlayAmbientAnims(ped, true)
    TaskStartScenarioInPlace(ped, anim, 0, true)
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
        -- extra ped performs ambient scenario
    else
        -- main ped idle
    end
    return ped
end

local function spawnPreviewPeds(characters)
    for _, ped in pairs(spawnedPeds) do
        safeDelete(ped)
    end
    spawnedPeds = {}
    spawnedData = {}

    local available = {}
    for i, v in ipairs(Config.PreviewSlots) do
        available[i] = v
    end

    for _, cData in ipairs(characters) do
        if #available == 0 then break end
        local idx = math.random(#available)
        local coords = table.remove(available, idx)
        local ped = spawnPreviewPed(cData, coords)
        spawnedPeds[cData.cid] = ped
        spawnedData[cData.cid] = cData
    end
end

local function startArrow(ped)
    arrowPed = ped
    if not arrowActive then
        arrowActive = true
        CreateThread(function()
            while arrowActive do
                if arrowPed and DoesEntityExist(arrowPed) then
                    local c = GetEntityCoords(arrowPed)
                    DrawMarker(27, c.x, c.y, c.z + 1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 148, 0, 211, 200, false, true, 2, false, nil, nil, false)
                end
                Wait(0)
            end
        end)
    end
    for _, cData in ipairs(characters) do
        if #available == 0 then break end
        local idx = math.random(#available)
        local slot = table.remove(available, idx)
        local ped = spawnPreviewPed(cData, slot.coords, slot.anim)
        spawnedPeds[cData.cid] = ped
        spawnedData[cData.cid] = cData
    end
end

local function startArrow(ped)
    arrowPed = ped
    if not arrowActive then
        arrowActive = true
        CreateThread(function()
            while arrowActive do
                if arrowPed and DoesEntityExist(arrowPed) then
                    local c = GetEntityCoords(arrowPed)
                    DrawMarker(2, c.x, c.y, c.z + 1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 148, 0, 211, 200, false, true, 2, false, nil, nil, false)
                    DrawMarker(27, c.x, c.y, c.z + 1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 148, 0, 211, 200, false, true, 2, false, nil, nil, false)
                end
                Wait(0)
            end
        end)
    end
local function clearPreview()
    for _, ped in pairs(spawnedPeds) do
        safeDelete(ped)
    end
    spawnedPeds = {}
    spawnedData = {}
    arrowActive = false
    arrowPed = nil
    spawnIdx = spawnIdx + 1
    local myIdx = spawnIdx
    CreateThread(function()
        local oldChar = charPed
        local oldExtra = extraPed
        safeDelete(oldChar)
        safeDelete(oldExtra)
        charPed = nil
        extraPed = nil
        activeChar = characters[1]
        extraChar = characters[2]
        local myChar = spawnPreviewPed(activeChar, Config.PedCoords, false)
        if myIdx ~= spawnIdx then
            safeDelete(myChar)
            return
        end
        charPed = myChar
        local myExtra
        if extraChar then
            myExtra = spawnPreviewPed(extraChar, Config.SecondPedCoords, true)
            if myIdx ~= spawnIdx then
                safeDelete(myChar)
                safeDelete(myExtra)
                return
            end
            extraPed = myExtra
        end
        if not arrowActive then
            arrowActive = true
            CreateThread(function()
                while arrowActive do
                    if charPed and DoesEntityExist(charPed) then
                        local c = GetEntityCoords(charPed)
                        DrawMarker(2, c.x, c.y, c.z + 1.2, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.2, 0.2, 0.2, 148, 0, 211, 200, true, true, 1, false, nil, nil, false)
                    end
                    Wait(0)
                end
            end)
        end
    end)
end

local function clearPreview()
    for _, ped in pairs(spawnedPeds) do
        safeDelete(ped)
    end
    spawnedPeds = {}
    spawnedData = {}
    arrowActive = false
    arrowPed = nil
end

local function skyCam(bool)
    TriggerEvent('qb-weathersync:client:DisableSync')
    if bool then
        DoScreenFadeIn(1000)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        FreezeEntityPosition(PlayerPedId(), false)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Config.CamCoords.x, Config.CamCoords.y, Config.CamCoords.z, -40.0 ,0.0, Config.CamCoords.w, 75.00, false, 0)
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
    clearPreview()
    safeDelete(charPed)
    charPed = nil
    safeDelete(extraPed)
    extraPed = nil
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
    clearPreview()
    safeDelete(charPed)
    charPed = nil
    safeDelete(extraPed)
    extraPed = nil
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

RegisterNUICallback('closeUI', function(data, cb)
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('pappu-multicharacter:server:loadUserData', cData)
    openCharMenu(false)
    clearPreview()
    SetEntityAsMissionEntity(charPed, true, true)
    safeDelete(charPed)
    charPed = nil
    safeDelete(extraPed)
    extraPed = nil
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
    clearPreview()
    SetEntityAsMissionEntity(charPed, true, true)
    safeDelete(charPed)
    charPed = nil
    safeDelete(extraPed)
    extraPed = nil
    arrowActive = false
    TriggerServerEvent('pappu-multicharacter:server:disconnect')
    cb("ok")
end)

RegisterNUICallback('selectCharacter', function(data, cb)
    local cData = data.cData
    DoScreenFadeOut(10)
    TriggerServerEvent('pappu-multicharacter:server:loadUserData', cData)
    openCharMenu(false)
    clearPreview()
    SetEntityAsMissionEntity(charPed, true, true)
    safeDelete(charPed)
    charPed = nil
    safeDelete(extraPed)
    extraPed = nil
    arrowActive = false
    cb("ok")
end)

RegisterNUICallback('cDataPed', function(nData, cb)
    local cData = nData.cData
    if cData and cData.cid and spawnedPeds[cData.cid] then
        startArrow(spawnedPeds[cData.cid])
    else
        arrowPed = nil
    end
    local previous = activeChar
    activeChar = cData
    extraChar = previous
    spawnPreviewPeds({activeChar, extraChar})
    cb("ok")
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

