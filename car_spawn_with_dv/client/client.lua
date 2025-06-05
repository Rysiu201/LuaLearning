--Komenda na spawn wymaganego auta komendą /auto [nazwa samochodu]
function spawn(vehicle)
    local ped = PlayerPedId()                                                                 -- Wczytujemy, że my to my czyli postać PED
    local pos = GetEntityCoords(ped)                                                          -- Wczytujemy coords naszej postaci PED
    local posheading = GetEntityHeading(ped)
    RequestModel(vehicle)                                                                     -- Request gry o podany w args[1] model samochodu

    while not HasModelLoaded(vehicle) do
        Citizen.Wait(500)                                                                     -- Podstawowy Wait
    end
    
    if IsModelAVehicle(vehicle) then
        local samochod = CreateVehicle(vehicle, pos.x, pos.y, pos.z, posheading, true, false) -- Lokalna zmienna przypisana do tworzenia samochodu CreateVehicle
        Citizen.Wait(1)                                                                       -- Oczekiwanie na wsadzenie gracza na miejsce kierwocy (Index -1 zawsze oznacza miejsce kierowcy)
        SetPedIntoVehicle(ped, samochod, -1)                                                  -- Wsadzamy gracza do samochodu 
        SetEntityAsNoLongerNeeded(samochod)                                                   -- Ustawiamy utworzony samochód jako już nie potrzebny żeby się respił (dajemy znać, że już jest i go nie potrzebujemy)
        SetModelAsNoLongerNeeded(vehicle)                                                     -- Ustawiamy argument vehicle (args[1]) jako już nie potrzebny, żeby go nie wczytywał dalej
    else
        TriggerEvent('chat:addMessage', {                                                     -- Trigger Eventu informacji na chacie
            args = {'Nie ma takiego samochodu jak ' .. vehicle}
        })
    end
end
    
RegisterCommand('auto', function(source, args)
    local vehicle = args[1]                                                                   -- Zmienna odpowiadająca za wczytanie do zmiennej naszego argumentu[1]
    spawn(vehicle)
end, false)

-- Funkcja usuwania pojazdu /usun

RegisterCommand('usun', function(source)
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(ped, false)
    cardv(ped, vehicle)
end, false)

function cardv(ped, vehicle)
    local radius = Config.Radius
    if IsPedInVehicle(ped, vehicle, false) and DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)                                                                -- DeleteVehicle =! DeleteEntity
        Citizen.Wait(1000)
    else
        local pedcoords = GetEntityCoords(ped)
        print(radius)
        vehicle = GetClosestVehicle(pedcoords.x, pedcoords.y, pedcoords.z, radius, 0, 70)
        DeleteEntity(vehicle)
    end
end

-- Funkcja na dodawanie sugestii czatu
Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/auto [nazwa samochodu]', 'Zespawnuj auto', {})
    TriggerEvent('chat:addSuggestion', '/usun', 'Usun auto', {})
end)
