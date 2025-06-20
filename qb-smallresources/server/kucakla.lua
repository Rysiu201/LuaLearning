local QBCore = exports['qb-core']:GetCoreObject()

-- Komenda: Podnieś gracza (na plecy)
QBCore.Commands.Add("podnies", "Podnieś gracza w pobliżu", {}, false, function(source, args)
    TriggerClientEvent("atomik-kucakla:kontrol", source, "kucak")
end)

-- Komenda: Weź zakładnika
QBCore.Commands.Add("zakladnik", "Weź gracza w pobliżu jako zakładnika", {}, false, function(source, args)
    TriggerClientEvent("atomik-kucakla:kontrol", source, "rehin")
end)

-- Animacja dla drugiego gracza (client side)
RegisterServerEvent('atomik-kucakla:server:oyuncu-2-anim')
AddEventHandler('atomik-kucakla:server:oyuncu-2-anim', function(targetSource, tip)
    TriggerClientEvent("atomik-kucakla:client:oyuncu-2-anim", targetSource, tip, source)
end)

-- Anulowanie animacji
RegisterServerEvent('atomik-kucakla:server:anim-iptal')
AddEventHandler('atomik-kucakla:server:anim-iptal', function(targetSource)
    TriggerClientEvent("atomik-kucakla:client:anim-iptal", targetSource)
end)

-- Zwolnienie lub zabicie zakładnika
RegisterServerEvent('atomik-kucakla:server:rehin-birak')
AddEventHandler('atomik-kucakla:server:rehin-birak', function(targetSource, tip)
    TriggerClientEvent("atomik-kucakla:client:rehin-birak", targetSource, tip)
end)