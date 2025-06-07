local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('Gotówka', 'Wyświetla ilość gotówki przy sobie', {}, false, function(source, _)
    local Player = QBCore.Functions.GetPlayer(source)
    local cashamount = Player.PlayerData.money.cash
    TriggerClientEvent('QBCore:Notify', source, "Masz przy sobie "..cashamount.."$", 'success')
end)

QBCore.Commands.Add('Bank', 'Wyświetla stan konta bankowego', {}, false, function(source, _)
    local Player = QBCore.Functions.GetPlayer(source)
    local bankamount = Player.PlayerData.money.bank
    TriggerClientEvent('QBCore:Notify', source, "Na koncie bankowym masz "..bankamount.."$", 'success')
end)

-- AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
--     if item == "harness" and count < 1 then
--         TriggerClientEvent('remove:harness', source)
--     end
-- end)

RegisterServerEvent("qb-hud:GiveMoneyServer", function(id, para)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local TargetId = id
    local PlayerPos = GetEntityCoords(GetPlayerPed(src))
    local Target = QBCore.Functions.GetPlayer(TargetId)
    local TargetPos = GetEntityCoords(GetPlayerPed(TargetId))
    local amount = para

    if Target ~= nil then
        if amount ~= nil then
            if amount > 0 then
                if Player.PlayerData.money.cash >= amount and amount > 0 then
                    if #(PlayerPos - TargetPos) < 3 then
                        if TargetId ~= source then
                            Player.Functions.RemoveMoney('cash', amount, "Gotówka przekazana do "..Player.PlayerData.citizenid)
                            Target.Functions.AddMoney('cash', amount, "Otrzymano gotówkę od: "..Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname)
                            
                            TriggerClientEvent('QBCore:Notify', TargetId, Player.PlayerData.charinfo.firstname.." przekazał Ci "..amount.."$", 'success')
                            TriggerClientEvent('QBCore:Notify', source, "Przekazałeś "..amount.."$ dla "..Target.PlayerData.charinfo.firstname.."!", 'success')
                            
                            TriggerEvent("DiscordBot:ToDiscord", "przelewgotowki", "Przekazano: "..amount.."$", source, TargetId)
                        else
                            TriggerClientEvent('chatMessage', source, "System", "error", "Nie możesz przekazywać pieniędzy samemu sobie!")
                        end
                    else
                        TriggerClientEvent('chatMessage', source, "System", "error", "Gracz, któremu chcesz przekazać gotówkę, nie jest w pobliżu!")
                    end
                else
                    TriggerClientEvent('chatMessage', source, "System", "error", "Nie masz wystarczającej ilości gotówki!")
                end
            else
                TriggerClientEvent('chatMessage', source, "System", "error", "Kwota musi być większa niż zero!")
            end
        else
            TriggerClientEvent('chatMessage', source, "System", "error", "Musisz podać kwotę!")
        end
    else
        TriggerClientEvent('chatMessage', source, "System", "error", "Gracz nie jest online!")
    end
end)
