--Komenda na spawn wymaganego auta komendą /auto [nazwa samochodu]

RegisterCommand('auto', function(source, args)
    local vehicle = args[1] -- Zmienna odpowiadająca za wczytanie do zmiennej naszego argumentu[1]
    local ped = PlayerPedId() -- Wczytujemy, że my to my czyli postać PED
    local pos = GetEntityCoords(ped) -- Wczytujemy coords naszej postaci PED
    local posheading = GetEntityHeading(ped)

    RequestModel(vehicle) -- Request gry o podany w args[1] model samochodu

    while not HasModelLoaded(vehicle) do
        Citizen.Wait(500) -- Podstawowy Wait
    end
    
    if IsModelAVehicle(vehicle) then
        local samochod = CreateVehicle(vehicle, pos.x, pos.y, pos.z, posheading, true, false) -- Lokalna zmienna przypisana do tworzenia samochodu CreateVehicle
        Citizen.Wait(1000)                                                                    -- Oczekiwanie na wsadzenie gracza na miejsce kierwocy (Index -1 zawsze oznacza miejsce kierowcy)
        SetPedIntoVehicle(ped, samochod, -1)                                                  -- Wsadzamy gracza do samochodu 
        SetEntityAsNoLongerNeeded(samochod)                                                   -- Ustawiamy utworzony samochód jako już nie potrzebny żeby się respił (dajemy znać, że już jest i go nie potrzebujemy)
        SetModelAsNoLongerNeeded(vehicle)                                                     -- Ustawiamy argument vehicle (args[1]) jako już nie potrzebny, żeby go nie wczytywał dalej
    else
        TriggerEvent('chat:addMessage', {                                                     -- Trigger Eventu informacji na chacie
            args = {'Nie ma takiego samochodu jak ' .. vehicle}
        })
    end
end, false)


--/\/\/\/\/\/\/\/\/\/\/\/\
--Powyższy skrypt można zrobić "poprawniej" i powinien wyglądać tak
--Dlaczego jest poprawny? Jest robiony na funkcji dzięki temu teraz
--jak będziemy chcieli użyć funkcji spawnienia samochodu to możemy również
--uzyj jej w innej funkcji wywoławczej:

function carspawn(car)
    local vehicle = car -- Zmienna odpowiadająca za wczytanie do zmiennej naszego argumentu[1]
    local ped = PlayerPedId() -- Wczytujemy, że my to my czyli postać PED
    local pos = GetEntityCoords(ped) -- Wczytujemy coords naszej postaci PED
    local posheading = GetEntityHeading(ped)

    RequestModel(vehicle) -- Request gry o podany w args[1] model samochodu

    while not HasModelLoaded(vehicle) do
        Citizen.Wait(500) -- Podstawowy Wait
    end
    
    if IsModelAVehicle(vehicle) then
        local samochod = CreateVehicle(vehicle, pos.x, pos.y, pos.z, posheading, true, false) -- Lokalna zmienna przypisana do tworzenia samochodu CreateVehicle
        Citizen.Wait(1000)                                                                    -- Oczekiwanie na wsadzenie gracza na miejsce kierwocy (Index -1 zawsze oznacza miejsce kierowcy)
        SetPedIntoVehicle(ped, samochod, -1)                                                  -- Wsadzamy gracza do samochodu 
        SetEntityAsNoLongerNeeded(samochod)                                                   -- Ustawiamy utworzony samochód jako już nie potrzebny żeby się respił (dajemy znać, że już jest i go nie potrzebujemy)
        SetModelAsNoLongerNeeded(vehicle)                                                     -- Ustawiamy argument vehicle (args[1]) jako już nie potrzebny, żeby go nie wczytywał dalej
    else
        TriggerEvent('chat:addMessage', {                                                     -- Trigger Eventu informacji na chacie
            args = {'Nie ma takiego samochodu jak ' .. vehicle}
        })
    end
end

RegisterCommand('auto', function(source, args) -- Komenda /auto [nazwa auta]
    carspawn(args[1])
end, false)

RegisterCommand('samochod', function(source, args) -- Komenda /samochod [args1 - nie bierze udzialu] [nazwa samochodu]
    carspawn(args[2])
end, false)
