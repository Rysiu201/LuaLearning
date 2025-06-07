--discord.gg/avance
local QBCore = exports['qb-core']:GetCoreObject()
local oyuncuYulendi, stres_aktif, sarhosAktif, IsAnimated, isDead = false, false, false, false, false
local adSu, animSu, bodySu = "amb@world_human_drinking@beer@male@idle_a", "idle_c", 49   
local adSigara, animSigara, bodySigara = "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 49 
local adYemek, animYemek, bodyYemek = "mp_player_inteat@burger", "mp_player_int_eat_burger", 49
local bussy = false
--discord.gg/avance
local bilgiler = { yemek = 4230, su = 6500, sarhos = 0, zirh = 0, heal = 200}
--discord.gg/avance
local oyunSuresi = 0
--discord.gg/avance
local RandomVehicleInteraction = {
	{interaction = 27, time = 2500},
	{interaction = 6, time = 2000},
	{interaction = 7, time = 1200}, --turn left and accel
	{interaction = 8, time = 1200}, --turn right and accel
	{interaction = 10, time = 1300}, --turn left and restore wheel pos
	{interaction = 11, time = 1400}, --turn right and restore wheel pos
	{interaction = 23, time = 4000}, -- accel fast
	{interaction = 31, time = 4000} -- accel fast and then handbrake 
}
--discord.gg/avance
AddEventHandler('tgiann:playerdead', function(dead)
	isDead = dead
	bilgiler.sarhos = 0
	if bilgiler.yemek < 1000 then bilgiler.yemek = 1000 end
	if bilgiler.su < 1000 then bilgiler.su = 1000 end
end)
--discord.gg/avance
RegisterNetEvent('tgian-hud:load-data')
AddEventHandler('tgian-hud:load-data', function(health, armor)
	while not isLoggedIn do 
		Citizen.Wait(1000)
	end
	local playerPed = PlayerPedId()
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	-- bilgiler.yemek = PlayerData.metadata["hunger"]
	-- bilgiler.su = PlayerData.metadata["thirst"]
	-- bilgiler.sarhos = PlayerData.metadata["drunk"]
	-- bilgiler.zirh = PlayerData.metadata["armor"]
	-- bilgiler.heal = PlayerData.metadata["heal"]
	SetEntityMaxHealth(playerPed, 200)
	if health then
		SetEntityHealth(playerPed, health)
		SetPedArmour(playerPed, armor)
	else
		SetEntityHealth(playerPed, bilgiler.heal)
		SetPedArmour(playerPed, bilgiler.zirh)
	end
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
	oyuncuYulendi = true
end)

RegisterNetEvent('tgiann-hud:fulle')
AddEventHandler('tgiann-hud:fulle', function()
	local playerPed = PlayerPedId()
	bilgiler.yemek = 10000
	bilgiler.su = 10000
	bilgiler.sarhos = 0
	bilgiler.zirh = 100
	bilgiler.heal = 200
	SetPedArmour(playerPed, bilgiler.zirh)
	SetEntityMaxHealth(playerPed, 200)
	SetEntityHealth(playerPed, bilgiler.heal)
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		if oyuncuYulendi then
			oyunSuresi = oyunSuresi + 1
			TriggerEvent("tgiann-hud:save", GetPedArmour(PlayerPedId()))
		end
	end
end)

RegisterNetEvent('tgiann-hud:save')
AddEventHandler('tgiann-hud:save', function(armor)
	if armor ~= nil then
		bilgiler.zirh = armor
	end
	saveStatusData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function() -- armor save
    saveStatusData()
end)

function saveStatusData()
	TriggerServerEvent("tgiann-basicneeds:bilgilerKaydet", bilgiler.yemek, bilgiler.su, bilgiler.sarhos, bilgiler.zirh, bilgiler.heal, oyunSuresi)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		if oyuncuYulendi and not isDead then
			local playerPed = PlayerPedId()
			if bilgiler.yemek <= 0 then
				SetEntityHealth(playerPed, GetEntityHealth(playerPed) - 20)
				QBCore.Functions.Notify("Robi Ci się słabo z głodu!", "error", 8000)
			elseif bilgiler.su <= 0 then
				SetEntityHealth(playerPed, GetEntityHealth(playerPed) - 20)
				QBCore.Functions.Notify("Robi Ci się słabo z pragnienia!", "error", 8000)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if oyuncuYulendi and not isDead then
			if bilgiler.yemek > 0 then
				bilgiler.yemek = bilgiler.yemek - 1
			end
			
			if bilgiler.su > 0 then
				bilgiler.su = bilgiler.su - 1
			end

			if bilgiler.sarhos > 0 then
				bilgiler.sarhos = bilgiler.sarhos - 5
			end

			-- Kontrol
			if bilgiler.yemek > 10000 then
				bilgiler.yemek = 10000
			elseif bilgiler.yemek < 0 then
				bilgiler.yemek = 0
			end	

			if bilgiler.su > 10000 then
				bilgiler.su = 10000
			elseif bilgiler.su < 0 then
				bilgiler.su = 0
			end	

			if bilgiler.sarhos > 10000 then
				bilgiler.sarhos = 10000
			elseif bilgiler.sarhos < 0 then
				bilgiler.sarhos = 0
			end	

			SendNUIMessage({
				type = "updateStatus",
				data = {
					yemek = bilgiler.yemek / 100,
					su = bilgiler.su / 100,
				},
			})
		end
		Citizen.Wait(1000)
	end
end)

RegisterNetEvent("kfzeu-basicneeds:su_alti")
AddEventHandler("kfzeu-basicneeds:su_alti", function(rtime, item)
	if not bussy then
		local playerPed = PlayerPedId()
		if IsPedSwimming(playerPed) then
			bussy = true
			QBCore.Functions.Progressbar("scuba_giy", "Zakładasz strój", 15000, false, false, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				QBCore.Functions.TriggerCallback("tgiann-base:removeItem", function(result)
					if result then
						local time = rtime * 60 --5 Dakika
						Citizen.CreateThread(function()
							while bussy do
								Citizen.Wait(1000)
								time = time - 1
							end
						end)
			
						SetEnableScuba(playerPed, true)
						SetEnableScubaGearLight(playerPed, false)
						SetPedScubaGearVariation(playerPed)
						SetSwimMultiplierForPlayer(playerPed, 1.4)
						SendNUIMessage({type = "showSuAlti", durum = true})
						
						while bussy do
							DrawGenericTextThisFrame()
							SetTextEntry("STRING")
							SetPedMaxTimeUnderwater(playerPed, 900.0)
							AddTextComponentString("Kalan Dakika: " .. QBCore.Shared.Round(time/60, 2))
							DrawText(0.5, 0.90)
							Citizen.Wait(1)
							if time < 1 or not IsPedSwimming(playerPed) then
								break
							end
						end
			
						SetPedMaxTimeUnderwater(playerPed, 20.0)
						SetEnableScuba(playerPed, false)
						ClearPedScubaGearVariation(playerPed)
						SetSwimMultiplierForPlayer(playerPed, 1.0)
						SendNUIMessage({type = "showSuAlti", durum = false})

						-- TriggerEvent("qb-clothing:refresh") -- Eski Kıyafetleri Giydirme
						Citizen.Wait(600000) -- Regülatör bitince cd (10dk)
					end
					bussy = false
				end, item, 1)
			end, function() -- Cancel
				bussy = false
			end)
		else
			QBCore.Functions.Notify("Musisz być w wodzie", "error")
		end
	else
		QBCore.Functions.Notify("Nie możesz teraz założyć regulatora, spróbuj później!", "error")
	end
end)

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

RegisterNetEvent('kfzeu-basicneeds:zehir')
AddEventHandler('kfzeu-basicneeds:zehir', function(sayi, type, item1, item2)
	if not bussy then
		bussy = true
		local playerPed = PlayerPedId()
		TriggerServerEvent("tgiann-basicneeds:esya-sil", item1, item2)
		if type == "yemek" then
			animasyon(adSu, animSu, bodySu, 12500)
			SetEntityHealth(playerPed, GetEntityHealth(playerPed) + sayi)
		elseif type == "doping" then
			animasyon("mp_suicide", "pill", 49, 3000)
			local addArmor = true
			if GetPedArmour(playerPed) > 0 then
				Citizen.CreateThread(function()
					while addArmor do
						if GetPedArmour(playerPed) < 100 then
							SetPedArmour(playerPed, GetPedArmour(playerPed) + 1)
						end
						Citizen.Wait(500)
					end
				end)
			end
			Citizen.Wait(60000)
			addArmor = false
		elseif type == "enerji" then
			animasyonVeProp(adSu, animSu, bodySu, 'prop_ld_can_01', 57005, 0.13, 0.02, -0.05, -85.0, 175.0, 0.0, 6000, false) 	
			Citizen.Wait(4000)
			local remaininTime = 60
			while remaininTime > 0 do
				Citizen.Wait(1000)
				RestorePlayerStamina(PlayerId(), 1.0)
				remaininTime = remaininTime - 1
			end
		elseif type == "adrenalin" then
			animasyonVeProp("anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 49, 'prop_cs_pills', 18905, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, 3000, false) 	
			local addArmor = true
			Citizen.CreateThread(function()
				if GetPedArmour(playerPed) > 0 then
					while addArmor do
						if GetPedArmour(playerPed) < 100 then
							SetPedArmour(playerPed, GetPedArmour(playerPed) + 1)
						end
						Citizen.Wait(500)
					end
				end
			end)

			local addHealt = true
			Citizen.CreateThread(function()
				while addHealt do
					if GetEntityHealth(playerPed) < 200 then
						SetEntityHealth(playerPed, GetEntityHealth(playerPed) + 0.5)
					end
					Citizen.Wait(500)
				end
			end)

			Citizen.Wait(40000)
			addHealt = false
			addArmor = false
		elseif type == "ot" then
			animasyonVeProp("amb@world_human_smoking@male@male_a@enter", "enter", 49, 'p_cs_joint_02', 47419, 0.015, -0.009, 0.003, 55.0, 0.0, 110.0, 14000, false) 	
			local addHealt = true
			Citizen.CreateThread(function()
				while addHealt do
					if GetEntityHealth(playerPed) < 200 then
						SetEntityHealth(playerPed, GetEntityHealth(playerPed) + 1)
					end
					Citizen.Wait(500)
				end
			end)
			Citizen.Wait(60000)
			addHealt = false
		else
			animasyonVeProp(adYemek, animYemek, bodyYemek, 'prop_cs_pills', 18905, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, 3000, false) 	
			local addHealt = true
			Citizen.CreateThread(function()
				while addHealt do
					if GetEntityHealth(playerPed) < 200 then
						SetEntityHealth(playerPed, GetEntityHealth(playerPed) + 1)
					end
					Citizen.Wait(500)
				end
			end)
			Citizen.Wait(60000)
			addHealt = false
		end
		bussy = false
	end

end)

local NosLoaded = false;

RegisterNetEvent("nos_bitti")
AddEventHandler("nos_bitti", function()
	NosLoaded = false;
end)

RegisterNetEvent('kfzeu-basicneeds:nosAnimation')
AddEventHandler('kfzeu-basicneeds:nosAnimation', function()	
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
	if IsPedInVehicle(PlayerPedId(), vehicle, true) then
		if not NosLoaded then
			QBCore.Functions.TriggerCallback("tgiann-base:removeItem", function(result)
				if result then
					QBCore.Functions.Progressbar("nitro", "Nitro Yükleniyor..", 45000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
					}, {
						animDict = "mini@repair",
						anim = "fixing_a_player",
						flags = 49,
					}, {}, {}, function() -- Done
						if math.random(1,100) < 4 then
							TriggerEvent("iens:motortamiret", vehicle, 10.0)
							QBCore.Functions.Notify("Motor Bozuldu...")
						else
							TriggerEvent("kfzeu:nosActivate", true)
						end
						NosLoaded = true
					end, function() -- Cancel
					end)
				end
			end, "nos", 1)
		else
			QBCore.Functions.Notify("Araçta zaten nitro var.")
		end
	else
		if not IsAnimated then	
			TriggerServerEvent("tgiann-basicneeds:esya-sil", "nos")
			IsAnimated = true
			TriggerEvent('Radiant_Animations:Animation', adSigara, animSigara, bodySigara) -- Load/Start animation
			Citizen.Wait(6500)
			AnimpostfxPlay("DrugsTrevorClownsFight", 1000, true)
			Citizen.Wait(300000)
			AnimpostfxStop("DrugsTrevorClownsFight")
			IsAnimated = false		
		end
	end
end)

RegisterNetEvent('kfzeu-basicneeds:nosAnimation2')
AddEventHandler('kfzeu-basicneeds:nosAnimation2', function()	
	if not IsAnimated then	
		TriggerServerEvent("tgiann-basicneeds:esya-sil", "ABC")
		IsAnimated = true
		animasyon("mp_suicide", "pill", 49, 3000)
		Citizen.Wait(6500)
		TriggerEvent("kfzeu:Acid", 300000)
		SetModelAsNoLongerNeeded('prop_cs_crackpipe')
		IsAnimated = false		
	end
end)

RegisterNetEvent('tgiann-basicneeds:icki')
AddEventHandler('tgiann-basicneeds:icki', function(sayi)
	local yeniDeger = bilgiler.sarhos + sayi 
	if yeniDeger - 4000 < 10000 then
		bilgiler.sarhos = yeniDeger
		exports["gamz-skillsystem"]:UpdateSkillRemove("Kondisyon", 0.03)
		animasyon(adSu, animSu, bodySu, 12500)
	else
		QBCore.Functions.Notify("Bir tane daha içersen bayılacaksın", "error")
	end
end)

RegisterNetEvent('tgiann-basicneeds:igne')
AddEventHandler('tgiann-basicneeds:igne', function()
	if bilgiler.sarhos < 10000 then
		if not AnimpostfxIsRunning("DrugsMichaelAliensFight") then
			StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
			Citizen.Wait(4000)
			StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
		end

		sarhosAktif = true
		RequestAnimSet("move_m@drunk@verydrunk")
		ShakeGameplayCam("DRUNK_SHAKE", 2.0)
		SetPedIsDrunk(PlayerPedId(), true)
		while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
			Citizen.Wait(100)
		end
		SetPedMovementClipset(PlayerPedId(), "move_m@drunk@verydrunk", true)
		bilgiler.sarhos = bilgiler.sarhos + 3000
	end
end)

RegisterNetEvent('tgiann-basicneeds:sigara')
AddEventHandler('tgiann-basicneeds:sigara', function()	
	if not IsAnimated then	
		IsAnimated = true
		exports["gamz-skillsystem"]:UpdateSkillRemove("Kondisyon", 0.05)
        local i = 0
        
        QBCore.Functions.Progressbar("sigara", "Tüttürüyorsun", 60000*3, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = adSigara,
            anim = animSigara,
            flags = bodySigara,
        }, { -- prop1
            model = "ng_proc_cigarette01a",
            bone = 64017,
			coords = { x = 0.010, y = 0.0, z = 0.0 },
			rotation = { x = 50.0, y = 0.0, z = 80.0 }, 
        }, {}, function() -- Done
            -- Done
        end, function() -- Cancel
        end)
		IsAnimated = false		
	end
end)

RegisterNetEvent('tgiann-basicneeds:icki')
AddEventHandler('tgiann-basicneeds:icki', function(data)
	Citizen.Wait(5000)
	if bilgiler.sarhos < 10000 then
		if not AnimpostfxIsRunning("DrugsMichaelAliensFight") then
			StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
			Citizen.Wait(4000)
			StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
		end

		sarhosAktif = true
		RequestAnimSet("move_m@drunk@verydrunk")
		ShakeGameplayCam("DRUNK_SHAKE", 2.0)
		SetPedIsDrunk(PlayerPedId(), true)
		while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
			Citizen.Wait(100)
		end
		SetPedMovementClipset(PlayerPedId(), "move_m@drunk@verydrunk", true)
		
		bilgiler.sarhos = data
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000) 
		if sarhosAktif then
			if bilgiler.sarhos > 0 then
				SetPedMovementClipset(PlayerPedId(), "move_m@drunk@verydrunk", true)
				bilgiler.sarhos = bilgiler.sarhos - 75 
				if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() and not IsVehicleStopped(GetVehiclePedIsIn(PlayerPedId(), false)) then
					local aracSikis = gotunYiyorsaAracSur()
					TaskVehicleTempAction(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), aracSikis.interaction, aracSikis.time) 				
				end
			elseif bilgiler.sarhos < 1 then
				sarhosAktif = false
				SetPedIsDrunk(PlayerPedId(), false)
				StopScreenEffect("DrugsMichaelAliensFightIn")
				StopScreenEffect("DrugsMichaelAliensFight")
				ClearPedSecondaryTask(PlayerPedId())
				ShakeGameplayCam("DRUNK_SHAKE", 0.0)
				ResetPedMovementClipset(PlayerPedId(), 0)
			end
		end
	end
end)

function animasyonVeProp(ad, anim, body, prop, propD1, propD2, propD3, propD4, propD5, propD6, propD7, time, cancel)
	if not IsAnimated then
		IsAnimated = true
		QBCore.Functions.Progressbar("icveye", "Kullanılıyor", time, false, cancel, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = ad,
			anim = anim,
			flags = body,
		}, { -- prop1
			model = prop,
			bone = propD1,
			coords = { x = propD2, y = propD3, z = propD4 },
			rotation = { x = propD5, y = propD6, z = propD7 }, 
		}, {}, function() -- Done
			IsAnimated = false
		end, function() -- Cancel
			IsAnimated = false
		end)
	end
end

function animasyon(ad, anim, body, time)
	if not IsAnimated then
        IsAnimated = true
        QBCore.Functions.Progressbar("icveyev2", "Kullanılıyor", time, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        }, {
            animDict = ad,
            anim = anim,
            flags = body,
        }, {}, {}, function() -- Done
            IsAnimated = false
        end, function() -- Cancel
        end)
	end
end

function gotunYiyorsaAracSur()
	local rastgele = math.random(1, #RandomVehicleInteraction)
	return RandomVehicleInteraction[rastgele]
end

function loadPropDict(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Citizen.Wait(500)
	end
end

RegisterNetEvent('tgiann-basicneeds:eatOrDrink')
AddEventHandler('tgiann-basicneeds:eatOrDrink', function(itemName, eatOrDrink, addValue, EODTime)
	if not IsAnimated then
		QBCore.Functions.TriggerCallback("tgiann-base:removeItem", function(result)
			if result then
				local totalTime = 20000*EODTime
				if eatOrDrink == "eat" then
					animasyonVeProp(adYemek, animYemek, bodyYemek, 'prop_cs_burger_01', 18905, 0.13, 0.05, 0.02, -50.0, 16.0, 60.0, totalTime, true) 
				elseif eatOrDrink == "drink" then
					animasyonVeProp(adSu, animSu, bodySu, 'prop_ld_can_01', 57005, 0.13, 0.02, -0.05, -85.0, 175.0, 0.0, totalTime, true) 	
				end

				local minAddStatusValue = addValue / (totalTime / 1000)
				while totalTime > 0 do
					Citizen.Wait(1000) -- 1 Saniye
					totalTime = totalTime - 1000
					if isDead or not IsAnimated then break end
					if eatOrDrink == "eat" then
						local yeniDeger = bilgiler.yemek + minAddStatusValue 
						bilgiler.yemek = yeniDeger
						if yeniDeger > 10000 then bilgiler.yemek = 10000  end
					elseif eatOrDrink == "drink" then
						local yeniDeger = bilgiler.su + minAddStatusValue 
						bilgiler.su = yeniDeger
						if yeniDeger > 10000 then bilgiler.su = 10000  end
					end
				end
				saveStatusData()
			end
		end, itemName, 1)
	end
end)

-- Citizen.CreateThread(function()
--     while true do
-- 		if bilgiler.su < 1500 or bilgiler.yemek < 1500 then
-- 			QBCore.Functions.Notify('Acıkmaya/Susamaya Başladın!', 'error')  
-- 			Citizen.Wait(60000)
-- 		elseif bilgiler.su < 500 or bilgiler.yemek < 500 then
-- 			QBCore.Functions.Notify('Açlıktan/Susuzluktan Başın Dönüyor!', 'error')  
-- 			ekranSiyah()
-- 			Citizen.Wait(20000)
-- 		else
-- 			Citizen.Wait(3000)
-- 		end 
--   	end
-- end)

-- function ekranSiyah()
-- 	DoScreenFadeOut(2500)
-- 	Citizen.Wait(2350)
-- 	DoScreenFadeIn(1500)
-- end