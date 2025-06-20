local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('smallresources:server:GetCurrentPlayers', function(_, cb)
    cb(#GetPlayers())
end)