Citizen.CreateThread(function()
	for _,v in pairs(Config.Blips) do
		local blip = AddBlipForCoord(v.coord.x, v.coord.y, v.coord.z)
		SetBlipSprite(blip, v.sprite)
		SetBlipScale(blip, v.scale)
		SetBlipColour(blip, v.color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.text)
		EndTextCommandSetBlipName(blip)
		if not v.radius then
			local blipradius = AddBlipForRadius(v.coord, v.radius)
			SetBlipColour(blipradius, v.radiuscolor)
			SetBlipAlpha(blipradius, v.alpha)
		end
	end
end)

Citizen.CreateThread(function()
	local aktifblipler = {}
	local aktifblipler2 = {}
	local blip = false
	RegisterNetEvent("malikane:blipAcKapa")
	AddEventHandler("malikane:blipAcKapa", function()
		if blip then
			pasifblip()
			blip = false
		else
			aktifblip()
			blip = true
		end
	end)

	Citizen.Wait(2000)
	function aktifblip()
		for k,v in ipairs(Config.Malikane)do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite (blip, v.id)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.6)
			SetBlipColour (blip, v.colour)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.title)
			EndTextCommandSetBlipName(blip)
			table.insert(aktifblipler, blip)
		end
	end

	RegisterNetEvent("kafeler:blipAcKapa")
	AddEventHandler("kafeler:blipAcKapa", function()
		if blip2 then
			pasifblip2()
			blip2 = false
		else
			aktifblip2()
			blip2 = true
		end
	end)

	Citizen.Wait(2000)
	function aktifblip2()
		for l,z in ipairs(Config.Kafeler)do
			local blip2 = AddBlipForCoord(z.x, z.y, z.z)
			SetBlipSprite (blip2, z.id)
			SetBlipDisplay(blip2, 4)
			SetBlipScale  (blip2, 0.6)
			SetBlipColour (blip2, z.colour)
			SetBlipAsShortRange(blip2, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(z.title)
			EndTextCommandSetBlipName(blip2)
			table.insert(aktifblipler2, blip2)
		end
	end

	function pasifblip()
		for i=1, #aktifblipler do
			RemoveBlip(aktifblipler[i])
		end
		aktifblipler = {}
	end

	function pasifblip2()
		for i=1, #aktifblipler2 do
			RemoveBlip(aktifblipler2[i])
		end
		aktifblipler2 = {}
	end
	
end)