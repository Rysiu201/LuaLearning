--discord.gg/avance
--discord.gg/avance
--discord.gg/avance
local QBCore = exports['qb-core']:GetCoreObject()
--discord.gg/avance
-- local cashAmount = 0
-- local bankAmount = 0
--discord.gg/avance
-- RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
--     PlayerData = {}
-- end)
--discord.gg/avance
-- RegisterNetEvent("QBCore:Player:SetPlayerData", function(val)
--     PlayerData = val
-- end)
--discord.gg/avance
-- RegisterNetEvent('hud:client:ShowAccounts', function(type, amount)
--     if type == 'cash' then
--         QBCore.Functions.Notify('Cebindeki Para: '..cashAmount, 'success')
--     else
--         QBCore.Functions.Notify('Bankadaki Para: '..bankAmount, 'success')
--     end
-- end)
--discord.gg/avance
-- RegisterNetEvent('hud:client:OnMoneyChange', function(type, amount, isMinus)
--     cashAmount = PlayerData.money['cash']
--     bankAmount = PlayerData.money['bank']
-- end)

RegisterNetEvent("qb-hud:GiveMoney", function(id)

    local deposit = exports['qb-input']:ShowInput({
        header = "Para Transferi",
        submitText = "Onayla",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = "Oyuncuya para ver"
            }
        }
    })
    if deposit then
        if not deposit.amount then return end
        RequestAnimDict('mp_common', function()
            TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake2_a', 5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
        end)
        TriggerServerEvent("qb-hud:GiveMoneyServer", GetPlayerServerId(NetworkGetEntityOwner(id.entity)), tonumber(deposit.amount))
    end

end)