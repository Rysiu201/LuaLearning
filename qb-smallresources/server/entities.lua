-- Blacklisting entities can just be handled entirely server side with onesync events
-- No need to run coroutines to supress or delete these when we can simply delete them before they spawn
AddEventHandler("entityCreating", function(handle)
    local entityModel = GetEntityModel(handle)

    if Config.BlacklistedVehs[entityModel] or Config.BlacklistedPeds[entityModel] then
        CancelEvent()
    end
end)

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-carwash:server:washCar', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    if Player.Functions.RemoveMoney('cash', Config.CarWash.defaultPrice, 'car-washed') then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    elseif Player.Functions.RemoveMoney('bank', Config.CarWash.defaultPrice, 'car-washed') then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.dont_have_enough_money'), 'error')
    end
end)
