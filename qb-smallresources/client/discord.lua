local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    SetDiscordAppId(Config.appid)

    SetDiscordRichPresenceAsset(Config.logo)
    SetDiscordRichPresenceAssetText(Config.logotext)

    SetDiscordRichPresenceAssetSmall(Config.minilogo)
    SetDiscordRichPresenceAssetSmallText(Config.minilogotext)

    SetDiscordRichPresenceAction(0, Config.Buttons[1].text, Config.Buttons[1].link)
    SetDiscordRichPresenceAction(1, Config.Buttons[2].text, Config.Buttons[2].link)

    while true do
        QBCore.Functions.TriggerCallback('smallresources:server:GetCurrentPlayers', function(result)
            SetRichPresence('Active: ' .. result .. '/' .. Config.maxPlayers)
        end)

        Citizen.Wait(60000)
    end
end)