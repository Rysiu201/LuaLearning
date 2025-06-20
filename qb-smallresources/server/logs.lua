local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['test'] = 'https://discord.com/api/webhooks/1381342984406171829/izF3Cw5KMhi3zZuNm9bzNkOaHyLMrOD1Jj7ddQFb9rhqEkrMCzSx1909J3DJMMobHhVJ',
    ['banking'] = 'https://discord.com/api/webhooks/1381343543540453518/OH8G0DvUqslhvzUctjYO2Vba7I2UZRAKcQTh9YJbIS-e38HwtVXYgphzZd1xzO0HeGGU', -- Bank
    ['joinleave'] = 'https://discord.com/api/webhooks/1381349445995855943/0NsKdvj3onw45AbuUl9phNh9j5nknTACSfCrLuXTNnX4yB7vR2krX113VOwStXwSDbKF', -- Wejście / Wyjście z serwera
    ['playermoney'] = 'https://discord.com/api/webhooks/1381349471002296351/fbM7T80MvGWjLXA2Khu3h12jouUdFj-Oidw8_3Z_-u2AMgvOzkvw3HRR_2z_g_I1RxYi', -- Gotówka / przelewy
    ['playerinventory'] = 'https://discord.com/api/webhooks/1381349467222970517/BHTuKVFa0uey0Ur7qquRkt8FbxL69f-_MZvv_2_-u9FFmstjdI8dxjmD-NcJoxcaX0Q4', -- Ekwipunek
    ['death'] = 'https://discord.com/api/webhooks/1381349461858717746/T_W3oOMPN5b8FXeJmqI7Ej-r-mXggHF-2zSFOYw6omVtlFfepBR-UvZO530g-JpBDdF2', -- Śmierć gracza
    ['bossmenu'] = 'https://discord.com/api/webhooks/1381349456192081920/FlkO1TRnWDBf52nU3bC60HMB5ytALymXjxZPv58HwD8MlgeJtVlpE0U0il2GP3cPg1qM', -- Menu szefa
    ['gangmenu'] = 'https://discord.com/api/webhooks/1381350288283275415/ZS7n--HTZa_3XHiPUIJpqnX-OkOCiybjtaTkaedbkRCuzc9PeyZczOenmlUoMR2isxqQ', -- Menu gangu
    ['robbing'] = 'https://discord.com/api/webhooks/1381350613803204629/zfFKl7wYNE62A5nK4b_WaoNPxmWHI2-wrCxouhS-C1fEVhpS8nVANZ8WvE8q6RkXA8xk', -- Rabowanie gracza
    ['trunk'] = 'https://discord.com/api/webhooks/1381350711803248650/rqfhPpjM8PEItkN4AcQpBROuW1cwoAt7HLk-hO5PK8acSmo64CmYWOWubtzy3Ua0Fgxh', -- Bagażnik
    ['glovebox'] = 'https://discord.com/api/webhooks/1381350879663231086/KkAW5Q1GUdxHkXW4NSLAzg-WOYmKLaL8BfOPM_B4l2EApgm3csHZDTSRTXjI31D1bwyG', -- Schowek (deska rozdzielcza)
    ['stash'] = 'https://discord.com/api/webhooks/1381350967936680037/X9xA__5gt_LBxGDPek4tU16SJFupr7pIoKiOiKBOnId87jBoYbxiCwpvyXPpkTUPQTx4', -- Skrytka
    ['drop'] = 'https://discord.com/api/webhooks/1381351050916794541/E7JWl9MKvvdT_7eT0-0_o2lsdQ2HkdeVnB2F0hFqt7pTBARs-kBBYgia-y3L5VlaxkTX', -- Dropy na ziemi
    ['vehiclesales'] = 'https://discord.com/api/webhooks/1381351151060127969/RBP62r56aeDxczSGfL10OS4Co9S7lMAkSt0aU-MFOBHm5vf3o-cCEhpZEnQJYBxWBqhv', -- Komisy samochodowe (używane auta)
    ['hacktablet'] = 'https://discord.com/api/webhooks/1381351230076616804/MjuI3_XDUi5dXFXS76OOhGqTX9z-h4HBtVcaxFmkrKg8yqfJOq0WnTGliiiU_9idIJET', -- Hack Tablet
    ['holding'] = 'https://discord.com/api/webhooks/1381351373156909076/oOl1LsJ6OhPnQ4dOOPoEi368bIoZUJI354ZXcOWQ4NeQMEjnadF8UsYASUWKsDuNwpPe', -- Holding (spółki)
    ['mucehver'] = 'https://discord.com/api/webhooks/1381351474709401871/rKWf6vZ7y_vKmPmD4yGa_1aTNEWceeftIHJBDfs8K2VPaup8dFXNXoNh7EBCHpY7n8cd', -- Rabunek jubilera
    ['markets'] = 'https://discord.com/api/webhooks/1381351588542546111/eUDlh8WOpNaKoaolR2DAEF7zaqbQlQe5dBIELGkG2jeqA92OAxgVsT6Yy68durNpBuuM', -- Napad na sklep
    ['aracparcalama'] = 'https://discord.com/api/webhooks/1381351672650928271/6D3XXOP_bbetuYRcZ6cufGoHQTPUDVNz3ipbub8BqnmoP-zWkdEEV_2y_vjplNpeXY5E', -- Rozbiórka pojazdu
    ['atmrob'] = 'https://discord.com/api/webhooks/1381351781405167698/pW2c1dPoyB7yTE3c63mdKKkxHRVxgfdRIiqmHGZjYBCGWSgkq8qTGIhidM0mGY9LteId', -- Rabunek bankomatu
    ['parkmeter'] = 'https://discord.com/api/webhooks/1381351879556206714/Z1uF649-4t-8UY7D0sI1c_O15hhEW-CfrNkSeyIjRrGKKziVCxoqNSSdHt0C7QcJwAem', -- Kradzież z parkomatu
    ['ev'] = 'https://discord.com/api/webhooks/1381351979174858812/dedn03EzOBcfeHSA9uTQ4OZQ4VmWbeIV9XEKNGgMjnRQfkVEzAZdDs0zZun8A0UZM0pe', -- Domy (wejścia do domów)
    ['craft'] = 'https://discord.com/api/webhooks/1381352054844559452/Qp0zoVXa3KyM_ujqjVP1COMobigqDAPyLKI8LG1b6nwAIy4X7nVZkEGFgAQ_smEgPbmW', -- Crafting
    ['polis'] = 'https://discord.com/api/webhooks/1381352168904331396/d1sulHEfJSFbAX0YRrwVCp15ievs80jIUErQ1xxhRuv3PJ7-cx0W5Sw-oXyGHIuAo1So', -- Policja
    ['medo'] = 'https://discord.com/api/webhooks/1381352249598672906/dVLtMe2Tss8Up4P2VUNH3akWRAz_L4WMaqdBmm8TrWJQCDEoCjFHS87gcoDD62GXA4vG', -- Komendy RP typu /me /do
    ['givecar'] = 'https://discord.com/api/webhooks/1381352344926552156/3e3QMf_wOtGwxLVm8UeWUZAH__WgO5KLaHtc4C0Map8jwx7MKls_er_A2Z6JesAGuqhL', -- Dodawanie pojazdów
    ['galeri'] = 'https://discord.com/api/webhooks/1381352417010126919/JN1APVLNzEt5oCgUaPlYGfWO9mjNc5u0VHAR8gsYHYuNuVazTqAgrbD5H3JF0ATezehQ', -- Salon samochodowy
    ['shops'] = 'https://discord.com/api/webhooks/1381352502141911201/PkfMdCox4Z4rgOnWAwcPHegNZlh5r28kYLv5Fo-8dXDjq_SdpJKfGUZFkwa9UHkxHAJY', -- Sklepy
}

local Colors = {
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ['lightgreen'] = 65309,
}

local logQueue = {}

AddEventHandler('playerConnecting', function()
    local steamisim = GetPlayerName(source)
    local ip = GetPlayerEP(source)
    local steamhex = GetPlayerIdentifier(source)
    local lisans = GetPlayerIdentifiers(source)[2]
    local tarih = os.date()
    local idedentifier = {}
    local idedentifier = GetPlayerIdentifiers(source)
    for i=1, #idedentifier do
        if string.find(idedentifier[i], "discord") then
            discord = string.sub(idedentifier[i], 9)
        end
    end
    TriggerEvent("atomik-log:server:CreateLog", "joinleave", "Połączono z serwerem", "green", "Steam nick: **"..steamisim.."**\nIP Adres: **"..ip.."**\n Hex: **"..steamhex.."**\n Licencja: ** "..lisans.."**\n Discord: ** <@"..discord..">**\n Data: ** "..tarih.."**", false)
    end)
    
RegisterNetEvent('atomik-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'Aether Log System',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/1381342935810969711/1381347422390976652/LogoBot.png?ex=68472f89&is=6845de09&hm=4ed019e8d282685de2b68abd9d08ff60875dd808c497b2f86953b93853e2ad0d&',
            },
        }
    }

    if not logQueue[name] then logQueue[name] = {} end
    logQueue[name][#logQueue[name]+1] = {webhook = webHook, data = embedData}

    if #logQueue[name] >= 10 then
        local postData = { username = 'Aether Log System', embeds = {} }

        for i = 1, #logQueue[name] do
            postData.embeds[#postData.embeds+1] = logQueue[name][i].data[1]
        end

        PerformHttpRequest(logQueue[name][1].webhook, function() end, 'POST', json.encode(postData), { ['Content-Type'] = 'application/json' })

        logQueue[name] = {}
    end
end)

Citizen.CreateThread(function()
    local timer = 0
    while true do
        Wait(1000)
        timer = timer + 1
        if timer >= 1 then -- 
            timer = 0
            for name, queue in pairs(logQueue) do
                if #queue > 0 then
                    local postData = { username = 'Aether Log System', embeds = {} }
                    for i = 1, #queue do
                        postData.embeds[#postData.embeds+1] = queue[i].data[1]
                    end
                    PerformHttpRequest(queue[1].webhook, function() end, 'POST', json.encode(postData), { ['Content-Type'] = 'application/json' })
                    logQueue[name] = {}
                end
            end
        end
    end
end)

QBCore.Commands.Add('testwebhook', 'Testuj webhook Discord dla logów (tylko admin)', {}, false, function()
    TriggerEvent('atomik-log:server:CreateLog', 'test', 'Test Webhooka', 'green', '**Odbiorca:** Test \n Odebrany przedmiot: tests \n Ilość: 5')
end, 'admin')
