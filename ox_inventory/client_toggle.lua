RegisterCommand('toggleinv', function()
    local focus = not IsNuiFocused()
    SetNuiFocus(focus, focus)
    SetNuiFocusKeepInput(focus)
    SendNUIMessage({ action = focus and 'showInventory' or 'hideInventory' })
end, false)

RegisterKeyMapping('toggleinv', 'Toggle Inventory', 'keyboard', 'F2')

RegisterNUICallback('close', function(_, cb)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    SendNUIMessage({ action = 'hideInventory' })
    cb('ok')
end)

local tabActive = false
CreateThread(function()
    while true do
        Wait(0)
        if not IsNuiFocused() then
            if IsControlPressed(0, 37) and not tabActive then
                tabActive = true
                SendNUIMessage({ action = 'showHotbarOnly' })
            elseif not IsControlPressed(0, 37) and tabActive then
                tabActive = false
                SendNUIMessage({ action = 'hideHotbarOnly' })
            end
        end
    end
end)
