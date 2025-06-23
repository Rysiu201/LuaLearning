Config = {}

-- Czy używać qb-target (interakcje celowania)
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Ustaw w server.cfg: setr UseTarget true/false

-- Konfiguracja podnoszenia rąk
Config.HandsUp = {
    command = 'hu',  -- komenda na ręce w górę
    keybind = 'X',   -- domyślny przycisk
}

-- Gęstość ruchu na serwerze (NPC i pojazdy)
Config.VehicleDensity = 1.0 -- Gęstość ruchu pojazdów
Config.PedDensity = 1.0 -- Gęstość pieszych NPC
Config.RandomVehicleDensity = 1.0 -- Losowe pojazdy poruszające się
Config.RandomParkedVehicleDensity = 1.0 -- Losowo zaparkowane pojazdy
Config.ScenarioPedDensityMin = 1.0 -- Minimalna gęstość NPC w scenariuszach
Config.ScenarioPedDensityMax = 1.0 -- Maksymalna gęstość NPC w scenariuszach
Config.GarbageTruck = true -- Aktywacja śmieciarek
Config.RandomBoats = true -- Aktywacja losowych łodzi
Config.RandomCops = false -- Aktywacja losowych policjantów na ulicach
Config.RandomCopsNotScenario = false -- Blokada policjantów poza scenariuszami
Config.RandomCopsOnScenario = false -- Blokada policjantów w scenariuszach

-- Discord Rich Presence (Podstawowa)
Config.appid ='' -- Application ID z discord developer portal
Config.logo = 'logo' -- Nazwa dużej ikony
Config.logotext = 'Aether RP 💖' -- Tekst po najechaniu myszką
Config.maxPlayers = 7
Config.minilogo = 'logo' -- Nazwa małej ikony
Config.minilogotext = 'Aether RP 💖' 
Config.Buttons = {
    [1] = {text = "Aether RP", link = "https://discord.gg/GSeQ747HsC"},
    [2] = {text = "Aether RP", link = "https://github.com/atomikk0"}
}

-- Lokacje Kawiarni (kafeler)
Config.Kafeler = {
    {title="[Firma] Uwu Cafe", colour=8, id=93, x = -581.352, y = -1067.76, z = 22.344},
    {title="[Firma] Bean Machine", colour=56, id=93, x = -626.261, y = 233.7969, z = 81.881},
    {title="[Firma] Gölbar", colour=31, id=93, x = -462.273, y = 4396.182, z = 32.007},
    {title="[Firma] Beach Club", colour=46, id=93, x = -1515.24, y = -1492.04, z = 6.2435},
    {title="[Firma] BurgerShot", colour=2, id=106, x = -1196.96, y = -885.365, z = 13.974},
}

-- Posiadłości (malikane)
Config.Malikane = { 
    {title="Posiadłość prywatna", colour=46, id=438, x = -134.935, y = 903.0156, z = 235.77},
    {title="Posiadłość prywatna", colour=46, id=438, x = -832.794, y = -33.7934, z = 38.520},
    {title="Posiadłość prywatna", colour=46, id=438, x = -2603.76, y = 1681.114, z = 141.86},
    {title="Posiadłość prywatna", colour=46, id=438, x = -2661.90, y = 1307.419, z = 147.11},
    {title="Posiadłość prywatna", colour=46, id=438, x = 1383.191, y = 1151.386, z = 114.33},
    {title="Posiadłość prywatna", colour=46, id=438, x = -1489.96, y = -50.6151, z = 54.642},
    {title="Posiadłość prywatna", colour=46, id=438, x = -1805.68, y = 453.0935, z = 128.30},
    {title="Posiadłość prywatna", colour=46, id=438, x = -1539.57, y = 128.4533, z = 56.780},
    {title="Posiadłość prywatna", colour=46, id=438, x = -827.292, y = 176.0278, z = 70.388},
    {title="Posiadłość prywatna", colour=46, id=438, x = 17.57020, y = 538.6045, z = 175.16},
    {title="Padilla Posiadłość", colour=46, id=438, x = -3195.24, y = 806.9776, z = 8.9343},
}

-- Blipy frakcyjne
Config.Blips = {
    [1] = {coord = vector3(104.07, -1938.06, 20.8), text = "Ballas", color = 27, sprite = 310, scale = 0.6},
    [2] = {coord = vector3(324.75, -2032.29, 20.68), text = "Vagos", color = 5, sprite = 310, scale = 0.6},
    [3] = {coord = vector3(-134.77, -1593.88, 34.22), text = "The Families", color = 25, sprite = 310, scale = 0.6},
    [4] = {coord = vector3(975.51, -120.1, 74.26), text = "Lost MC", color = 40, sprite = 310, scale = 0.6},
}

-- Kucanie i czołganie
Config.CrouchKeybindEnabled = true -- Czy włączyć kucanie na klawisz
Config.CrouchKeybind = 'LCONTROL' -- Klawisz kucania
Config.CrouchOverride = true -- Jeśli true: wciskając LCONTROL od razu kuca; jeśli false: musi być tryb skradania
Config.CrouchKeypressTimer = 1000 -- Czas w ms do wejścia w kucanie

Config.CrawlKeybindEnabled = true -- Czy włączyć czołganie na klawisz
Config.CrawlKeybind = 'RCONTROL' -- Klawisz czołgania

-- Lokalizacja tekstów dla kucania i czołgania
Config.Localization = {
    ['crouch_keymapping'] = "Kucnij",
    ['crouch_chat_suggestion'] = "Komenda na kucanie",
    ['crawl_keymapping'] = "Czołgaj się",
    ['crawl_chat_suggestion'] = "Komenda na czołganie"
}

-- Pokazywanie ID nad głową
Config.key = 19 -- Klawisz ALT (https://docs.fivem.net/docs/game-references/controls/)
Config.which = "steamv2" -- Co pokazywać nad głową: steam, steamv2, license, licensev2, name
Config.commandName = "id" -- Komenda do ręcznego pokazywania ID
Config.drawDistance = 4 -- Odległość widoczności

-- Lornetka
Config.Binoculars = {
    fov_max = 70.0, -- maksymalne FOV (najmniej zoomu)
    fov_min = 5.0, -- minimalne FOV (maksymalny zoom)
    zoomspeed = 10.0, -- prędkość zoomowania
    speed_lr = 8.0, -- prędkość obrotu w lewo/prawo
    speed_ud = 8.0, -- prędkość obrotu góra/dół
    storeBinoclarKey = 177 -- przycisk ESC do schowania lornetki
}

-- Wyłączenie dispatchów (służb AI)
Config.DispatchServices = {
    [1] = false, -- Radiowozy policji
    [2] = false, -- Helikoptery policji
    [3] = false, -- Straż pożarna
    [4] = false, -- SWAT
    [5] = false, -- Karetki
    [6] = false, -- Motocykle policyjne
    [7] = false, -- Wsparcie policyjne
    [8] = false, -- Blokady drogowe
    [9] = false, -- PoliceAutomobileWaitPulledOver
    [10] = false, -- PoliceAutomobileWaitCruising
    [11] = false, -- Gang Members
    [12] = false, -- Helikoptery SWAT
    [13] = false, -- Policyjne łodzie
    [14] = false, -- Pojazdy armii
    [15] = false, -- Wsparcie Bikerów
}

-- Poziom poszukiwania
Config.EnableWantedLevel = false -- Blokada systemu wanted level GTA

-- Rozszerzone Discord Rich Presence
Config.Discord = {
    ["IsEnabled"] = true, -- Czy włączyć Discord Rich Presence
    ["ApplicationId"] = '1378890591945097356', -- Discord App ID
    ["IconLarge"] = 'logo_name', -- Nazwa dużej ikony (wgrana w art assets)
    ["IconLargeHoverText"] = 'Duża ikona z opisem',
    ["IconSmall"] = 'small_logo_name', -- Nazwa małej ikony
    ["IconSmallHoverText"] = 'Mała ikona z opisem',
    ["UpdateRate"] = 60000, -- Odświeżanie co 60s
    ["ShowPlayerCount"] = true, -- Pokazywanie liczby graczy
    ["MaxPlayers"] = 48, -- Maksymalna liczba graczy
    ["Buttons"] = {
        {
            text = 'Połącz z serwerem',
            url = 'fivem://connect/localhost:30120'
        },
        {
            text = 'Drugi przycisk',
            url = 'fivem://connect/localhost:30120'
        }
    }
}

-- Gęstość ruchu (dodatkowa)
Config.Density = {
    ['parked'] = 0.8,      -- Zaparkowane pojazdy
    ['vehicle'] = 0.8,     -- Pojazdy na drogach
    ['multiplier'] = 0.8,  -- Ogólny mnożnik
    ['peds'] = 0.8,        -- Piesi
    ['scenario'] = 0.8,    -- NPC w scenariuszach
}

-- Ogłuszanie po taserze
Config.Stun = {
    active = true, -- Czy włączyć efekt ogłuszenia
    min = 4000,     -- Minimalny czas ogłuszenia w ms
    max = 7000      -- Maksymalny czas ogłuszenia w ms
}

-- Wyłączenie bicia pistoletem
Config.RemovePistolWhipping = true

-- Inne ogólne ustawienia
Config.Cruise = 'mp/h' -- Jednostki tempomatu
Config.IdleCamera = true -- Czy włączyć idle camerę GTA
Config.disableHandsupControls = {24, 25, 47, 58, 59, 63, 64, 71, 72, 75, 140, 141, 142, 143, 257, 263, 264} -- Blokada klawiszy przy podniesionych rękach
Config.DisableAmbience = false -- Czy wyłączyć dźwięki w tle (syreny, alarmy)
Config.HarnessUses = 20 -- Ilość użyć pasa bezpieczeństwa
Config.DamageNeeded = 100.0 -- Ile siły potrzeba do pchania auta
Config.EnableProne = false -- Czy włączyć czołganie
Config.MapText = "Nazwa Serwera" -- Tekst wyświetlany nad minimapą

-- Wyłączenia elementów HUD oraz kontrolek
Config.Disable = {
    disableHudComponents = {1, 2, 3, 4, 7, 9, 13, 19, 20, 21, 22},
    disableControls = {37}, -- Klawisz Tab
    displayAmmo = true -- Czy wyświetlać liczbę amunicji
}

-- Jedzenie
Config.ConsumablesEat = {
    ["sandwich"] = math.random(35, 54),
    ["tosti"] = math.random(40, 50),
    ["twerks_candy"] = math.random(35, 54),
    ["snikkel_candy"] = math.random(40, 50),
    ["taco"] = math.random(25, 34),
    ["kesilmiskarpuz"] = math.random(25, 34),
    ["grape"] = math.random(25, 34),
}

-- Picie
Config.ConsumablesDrink = {
    ["water_bottle"] = math.random(35, 54),
    ["kurkakola"] = math.random(35, 54),
    ["coffee"] = math.random(40, 50),
}

-- Alkohol
Config.ConsumablesAlcohol = {
    ["whiskey"] = math.random(20, 30),
    ["beer"] = math.random(30, 40),
    ["vodka"] = math.random(20, 40),
}

-- Fajerwerki (itemy)
ConsumablesFireworks = {
    "firework1",
    "firework2",
    "firework3",
    "firework4"
}

-- Opóźnienie fajerwerków
Config.FireworkTime = 5

-- Zablokowane scenariusze
Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
        "WORLD_VEHICLE_AMBULANCE",
        "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
        "WORLD_VEHICLE_POLICE_CAR",
        "WORLD_VEHICLE_POLICE_BIKE",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
    }
}

-- Zablokowane pojazdy
Config.BlacklistedVehs = {
    [`SHAMAL`] = true,
    [`LUXOR`] = true,
    [`LUXOR2`] = true,
    [`JET`] = true,
    [`LAZER`] = true,
    [`BUZZARD`] = true,
    [`BUZZARD2`] = true,
    [`ANNIHILATOR`] = true,
    [`SAVAGE`] = true,
    [`TITAN`] = true,
    [`RHINO`] = true,
    [`FIRETRUK`] = true,
    [`MULE`] = false,
    [`MAVERICK`] = true,
    [`BLIMP`] = true,
    [`AIRTUG`] = true,
    [`CAMPER`] = true,
    [`HYDRA`] = true,
    [`OPPRESSOR`] = true,
    [`technical3`] = true,
    [`insurgent3`] = true,
    [`apc`] = true,
    [`tampa3`] = true,
    [`trailersmall2`] = true,
    [`halftrack`] = true,
    [`hunter`] = true,
    [`vigilante`] = true,
    [`akula`] = true,
    [`barrage`] = true,
    [`khanjali`] = true,
    [`caracara`] = true,
    [`blimp3`] = true,
    [`menacer`] = true,
    [`oppressor2`] = true,
    [`scramjet`] = true,
    [`strikeforce`] = true,
    [`cerberus`] = true,
    [`cerberus2`] = true,
    [`cerberus3`] = true,
    [`scarab`] = true,
    [`scarab2`] = true,
    [`scarab3`] = true,
    [`rrocket`] = true,
    [`ruiner2`] = true,
    [`deluxo`] = true,
    [`cargoplane2`] = true,
    [`voltic2`] = true,
}

-- Zablokowana broń
Config.BlacklistedWeapons = {
    [`WEAPON_RAILGUN`] = true,
}

-- Zablokowane modele NPC
Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
}

-- Wyłączenie kamizelki przy ciężkim pancerzu
Config.DisableVestDrawable = false

-- Holster - możliwe warianty kabury
Config.HolsterVariant = {130,122,3,6,8}

-- Bronie podlegające animacji wyciągania
Config.HolsterableWeapons = {
    'WEAPON_PISTOL',
    'WEAPON_PISTOL_MK2',
    'WEAPON_COMBATPISTOL',
    'WEAPON_APPISTOL',
    'WEAPON_PISTOL50',
    'WEAPON_REVOLVER',
    'WEAPON_SNSPISTOL',
    'WEAPON_HEAVYPISTOL',
    'WEAPON_VINTAGEPISTOL'
}

-- Obiekty do usuwania (przeszkody na mapie)
Config.Objects = {
    {coords = vector3(266.09,-349.35,44.74), heading = 0, length = 200, width = 200, model = "prop_sec_barier_02b"},
    {coords = vector3(285.28,-355.78,45.13), heading = 0, length = 200, width = 200, model = "prop_sec_barier_02a"},
}

-- Cooldowny na animację wyciągania broni
Config.cooldownPolice = 300  -- Policja
Config.cooldown = 1700       -- Gracz cywil

-- Lista broni pod animacje
Config.weapons = {
    "WEAPON_PISTOL",
    "WEAPON_GLOCK",
    "WEAPON_STUNGUN",
    "WEAPON_KNUCKLE",
    "WEAPON_BATS",
    "WEAPON_BOTTLE",
    "WEAPON_DAGGER",
    "WEAPON_KNIFE",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_DP9",
    "WEAPON_COMBATPDW",
    "WEAPON_SPECIALCARBINE_MK2",
    "WEAPON_ASSAULTRIFLE2",
    "WEAPON_COMPACTRIFLE"
}

-- Teleporty (windy, przejścia)
Config.Teleports = {
    [1] = {
        [1] = {
            coords = vector4(-66.7, -802.45, 44.23, 334.71),
            ["AllowVehicle"] = false,
            drawText = '[E] Biuro'
        },
        [2] = {
            coords = vector4(-75.77, -826.94, 243.39, 76.74),
            ["AllowVehicle"] = false,
            drawText = '[E] Parter'
        },
    },
    [2] = {
        [1] = {
            coords = vector4(-198.1, -575.3, 40.49, 74.01),
            ["AllowVehicle"] = false,
            drawText = '[E] Biuro'
        },
        [2] = {
            coords = vector4(-1579.63, -565.05, 108.52, 297.6),
            ["AllowVehicle"] = false,
            drawText = '[E] Parter'
        },
    },
}

-- Ustawienia myjni samochodowej
Config.DefaultPrice = 20 -- Domyślna cena myjni
Config.DirtLevel = 0.1   -- Poziom brudu przy którym myjnia się aktywuje

Config.CarWash = {
    dirtLevel = 0.1, 
    defaultPrice = 20,
    locations = {
        [1] = {coords = vector3(174.81, -1736.77, 28.87), length = 7.0, width = 8.8, heading = 359}, -- South Los Santos Carson Avenue
        [2] = {coords = vector3(25.2, -1391.98, 28.91), length = 6.6, width = 8.2, heading = 0}, -- Innocence Blvd
        [3] = {coords = vector3(-74.27, 6427.72, 31.02), length = 9.4, width = 8, heading = 315}, -- Paleto Bay
        [4] = {coords = vector3(1362.69, 3591.81, 34.5), length = 6.4, width = 8, heading = 21}, -- Sandy Shores
        [5] = {coords = vector3(-699.84, -932.68, 18.59), length = 11.8, width = 5.2, heading = 0} -- Little Seoul
    }
}

-- Customowe jedzenie i picie (zaawansowane konfiguracje itemów)
Config.ConsumablesCustom = {
    -- Przykład użycia:
    -- ['nowyitem'] = {
    --     ['progress'] = {
    --         label = 'Używasz przedmiotu...',
    --         time = 5000
    --     },
    --     ['animation'] = {
    --         animDict = "amb@prop_human_bbq@male@base",
    --         anim = "base",
    --         flags = 8,
    --     },
    --     ['prop'] = {
    --         model = false, -- Model obiektu (prop)
    --         bone = false, -- Kość na której ma być trzymany obiekt (np. 18905 lewa ręka, 57005 prawa ręka)
    --         coords = false, -- Pozycja XYZ
    --         rotation = false, -- Rotacja XYZ
    --     },
    --     ['replenish'] = {
    --         type = 'Hunger', -- Co uzupełnia: Hunger/Thirst/false
    --         replenish = math.random(20, 40),
    --         isAlcohol = false, -- Czy zawiera alkohol (jeśli tak - wpływa na efekt upojenia)
    --         event = false, -- Wydarzenie zewnętrzne po użyciu (przydatne do narkotyków)
    --         server = false -- Czy event jest po stronie serwera
    --     }
    -- }
}

-- Kości dla customowych animacji z obiektami
-- 18905 = lewa ręka
-- 57005 = prawa ręka

-- GOTOWE 🔧

