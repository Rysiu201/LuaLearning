if not lib then return end

local Items = require 'modules.items.server'
local Inventory = require 'modules.inventory.server'
local Shops = {}
local locations = shared.target and 'targets' or 'locations'

---@class OxShopItem
---@field slot number
---@field weight number

local function setupShopItems(id, shopType, shopName, groups)
	local shop = id and Shops[shopType][id] or Shops[shopType] --[[@as OxShop]]

	for i = 1, shop.slots do
		local slot = shop.items[i]

		if slot.grade and not groups then
			print(('^1attempted to restrict slot %s (%s) to grade %s, but %s has no job restriction^0'):format(id, slot.name, json.encode(slot.grade), shopName))
			slot.grade = nil
		end

		local Item = Items(slot.name)

		if Item then
			---@type OxShopItem
			slot = {
				name = Item.name,
				slot = i,
				weight = Item.weight,
				count = slot.count,
				price = (server.randomprices and (not slot.currency or slot.currency == 'money')) and (math.ceil(slot.price * (math.random(80, 120)/100))) or slot.price or 0,
				metadata = slot.metadata,
				license = slot.license,
				currency = slot.currency,
				grade = slot.grade
			}

			if slot.metadata then
				slot.weight = Inventory.SlotWeight(Item, slot, true)
			end

			shop.items[i] = slot
		end
	end
end

---@param shopType string
---@param properties OxShop
local function registerShopType(shopType, properties)
	local shopLocations = properties[locations] or properties.locations

	if shopLocations then
		Shops[shopType] = properties
	else
		Shops[shopType] = {
			label = properties.name,
			id = shopType,
			groups = properties.groups or properties.jobs,
			items = properties.inventory,
			slots = #properties.inventory,
			type = 'shop',
		}

		setupShopItems(nil, shopType, properties.name, properties.groups or properties.jobs)
	end
end

---@param shopType string
---@param id number
local function createShop(shopType, id)
	local shop = Shops[shopType]

	if not shop then return end

	local store = (shop[locations] or shop.locations)?[id]

	if not store then return end

	local groups = shop.groups or shop.jobs
    local coords

    if shared.target then
        if store.length then
            local z = store.loc.z + math.abs(store.minZ - store.maxZ) / 2
            coords = vec3(store.loc.x, store.loc.y, z)
        else
            coords = store.coords or store.loc
        end
    else
        coords = store
    end

	---@type OxShop
	shop[id] = {
		label = shop.name,
		id = shopType..' '..id,
		groups = groups,
		items = table.clone(shop.inventory),
		slots = #shop.inventory,
		type = 'shop',
		coords = coords,
		distance = shared.target and shop.targets?[id]?.distance,
	}

	setupShopItems(id, shopType, shop.name, groups)

	return shop[id]
end

for shopType, shopDetails in pairs(lib.load('data.shops')) do
	registerShopType(shopType, shopDetails)
end

---@param shopType string
---@param shopDetails OxShop
exports('RegisterShop', function(shopType, shopDetails)
       registerShopType(shopType, shopDetails)
end)

-- Forward declarations for affordability helpers so they are available to
-- callbacks defined below.
local canAffordItem, removeCurrency
local purchasing = {}

---Check if the player has enough currency for a purchase.
---@param inv inventory
---@param currency string
---@param price number
---@return true | table
function canAffordItem(inv, currency, price)
       if currency == 'bank' then
               local player = server.GetPlayerFromId(inv.id)
               local canAfford = player and player.Functions.GetMoney('bank') >= price
               return canAfford or {
                       type = 'error',
                       description = locale('cannot_afford', ('%s%s'):format(locale('$'), math.groupdigits(price)))
               }
       end

       local canAfford = price >= 0 and Inventory.GetItemCount(inv, currency) >= price

       return canAfford or {
               type = 'error',
               description = locale('cannot_afford', ('%s%s'):format((currency == 'money' and locale('$') or math.groupdigits(price)), (currency == 'money' and math.groupdigits(price) or ' '..Items(currency).label)))
       }
end

---Remove currency from the player's inventory or bank account.
---@param inv inventory
---@param currency string
---@param price number
function removeCurrency(inv, currency, price)
       if currency == 'bank' then
               local player = server.GetPlayerFromId(inv.id)
               if player then
                       player.Functions.RemoveMoney('bank', price, 'ox_inventory_shop')
               end
       else
               Inventory.RemoveItem(inv, currency, price)
       end
end

lib.callback.register('ox_inventory:buyCart', function(source, data)
       if purchasing[source] then return false end
       purchasing[source] = true

       local playerInv = Inventory(source)
       if not playerInv or not playerInv.currentShop then purchasing[source] = nil return end

       local shopType, shopId = playerInv.currentShop:match('^(.-) (%d+)$')
       if not shopType then shopType = playerInv.currentShop end
       if shopId then shopId = tonumber(shopId) end

       local shop = shopId and Shops[shopType][shopId] or Shops[shopType]
       local items = data.items or {}
       local currency = data.currency or 'money'

       local additions = {}
       local totalPrice = 0
       local itemNames = {}

       for _, entry in ipairs(items) do
               local fromData = shop.items[entry.fromSlot]
               if fromData then
                       local count = entry.count or 1
                       if fromData.count and fromData.count < count then
                               count = fromData.count
                       end

                       if count < 1 then goto continue end

                       local fromItem = Items(fromData.name)
                       local metadata, realCount = Items.Metadata(playerInv, fromItem, fromData.metadata and table.clone(fromData.metadata) or {}, count)
                       local price = realCount * fromData.price

                       local stackSlot = Inventory.GetSlotForItem(playerInv, fromItem.name, metadata)
                       local targetSlot = stackSlot and playerInv.items[stackSlot] and stackSlot or Inventory.GetEmptyPocketSlot(playerInv)
                       local toData = targetSlot and playerInv.items[targetSlot]
                       local toItem = toData and Items(toData.name)

                       if targetSlot and (toData == nil or (fromItem.name == toItem?.name and fromItem.stack and table.matches(toData.metadata, metadata))) then
                               table.insert(additions, {slot = targetSlot, item = fromItem, count = realCount, metadata = metadata, price = price, fromSlot = entry.fromSlot})
                               totalPrice = totalPrice + price
                               table.insert(itemNames, metadata?.label or fromItem.label)
                       else
                               purchasing[source] = nil
                               return false, false, { type = 'error', description = locale('unable_stack_items') }
                       end
               end
               ::continue::
       end

       if #additions == 0 then return false end

       local afford = canAffordItem(playerInv, currency, totalPrice)
       if afford ~= true then purchasing[source] = nil return false, false, afford end

       for _, info in ipairs(additions) do
               local success, added = Inventory.AddItem(playerInv, info.item.name, info.count, info.metadata)
               if not success then purchasing[source] = nil return false, false, { type = 'error', description = locale('inventory_full') } end

               info.slot = added.slot

               local shopItem = shop.items[info.fromSlot]
               if shopItem and shopItem.count then
                       shopItem.count = shopItem.count - info.count
               end
       end

       removeCurrency(playerInv, currency, totalPrice)

       if currency == 'bank' then
               local player = server.GetPlayerFromId(playerInv.id)
               if player then
                       local receiverId = ('shop_%s'):format(shopType)
                       TriggerEvent('okokBanking:AddNewTransaction', shop.label, receiverId, GetPlayerName(source), player.PlayerData.identifier, totalPrice, ('Zakup w sklepie: %s'):format(table.concat(itemNames, ', ')))
                       TriggerClientEvent('ox_lib:notify', source, { type = 'success', description = ('✅ Zakupiono przedmiot(y) za %s z konta bankowego.'):format(totalPrice) })
               end
       end

                                if server.syncInventory then server.syncInventory(playerInv) end
TriggerEvent('ox_inventory:refreshInventory', source)
purchasing[source] = nil

       return true
end)

lib.callback.register('ox_inventory:openShop', function(source, data)
	local left, shop = Inventory(source)

	if not left then return end

	if data then
		shop = Shops[data.type]

		if not shop then return end

		if not shop.items then
			shop = (data.id and shop[data.id] or createShop(data.type, data.id))

			if not shop then return end
		end

		---@cast shop OxShop

		if shop.groups then
			local group = server.hasGroup(left, shop.groups)
			if not group then return end
		end

		if type(shop.coords) == 'vector3' and #(GetEntityCoords(GetPlayerPed(source)) - shop.coords) > 10 then
			return
		end

                ---@diagnostic disable-next-line: assign-type-mismatch
                left:openInventory(shop)
                left.currentShop = shop.id
        end

	return { label = left.label, type = left.type, slots = left.slots, weight = left.weight, maxWeight = left.maxWeight }, shop
end)

local TriggerEventHooks = require 'modules.hooks.server'

local function isRequiredGrade(grade, rank)
	if type(grade) == "table" then
		for i=1, #grade do
			if grade[i] == rank then
				return true
			end
		end
		return false
	else
		return rank >= grade
	end
end

lib.callback.register('ox_inventory:buyItem', function(source, data)
        if data.toType == 'player' then
                if data.count == nil then data.count = 1 end

                if purchasing[source] then return false end
                purchasing[source] = true

                local playerInv = Inventory(source)

                if not playerInv or not playerInv.currentShop then purchasing[source] = nil return end

		local shopType, shopId = playerInv.currentShop:match('^(.-) (%d-)$')

		if not shopType then shopType = playerInv.currentShop end

		if shopId then shopId = tonumber(shopId) end

                local shop = shopId and Shops[shopType][shopId] or Shops[shopType]
                local fromData = shop.items[data.fromSlot]

		if fromData then
			if fromData.count then
                                if fromData.count == 0 then
                                        purchasing[source] = nil
                                        return false, false, { type = 'error', description = locale('shop_nostock') }
                                elseif data.count > fromData.count then
                                        data.count = fromData.count
                                end
                        end

                        if fromData.license and server.hasLicense and not server.hasLicense(playerInv, fromData.license) then
                                purchasing[source] = nil
                                return false, false, { type = 'error', description = locale('item_unlicensed') }
                        end

			if fromData.grade then
				local _, rank = server.hasGroup(playerInv, shop.groups)
                                if not isRequiredGrade(fromData.grade, rank) then
                                        purchasing[source] = nil
                                        return false, false, { type = 'error', description = locale('stash_lowgrade') }
                                end
			end

                        local currency = data.currency or fromData.currency or 'money'
			local fromItem = Items(fromData.name)

                        local result = fromItem.cb and fromItem.cb('buying', fromItem, playerInv, data.fromSlot, shop)
                        if result == false then purchasing[source] = nil return false end

                        local metadata, count = Items.Metadata(playerInv, fromItem, fromData.metadata and table.clone(fromData.metadata) or {}, data.count)
                        local price = count * fromData.price

                       local stackSlot = Inventory.GetSlotForItem(playerInv, fromItem.name, metadata)
                        local targetSlot = stackSlot and playerInv.items[stackSlot] and stackSlot or Inventory.GetEmptyPocketSlot(playerInv)
                        local toData = targetSlot and playerInv.items[targetSlot]
                        local toItem = toData and Items(toData.name)

                        if targetSlot and (toData == nil or (fromItem.name == toItem?.name and fromItem.stack and table.matches(toData.metadata, metadata))) then
                                local canAfford = canAffordItem(playerInv, currency, price)

                                if canAfford ~= true then
                                        purchasing[source] = nil
                                        return false, false, canAfford
                                end

                                if not TriggerEventHooks('buyItem', {
                                        source = source,
                                        shopType = shopType,
                                        shopId = shopId,
                                        toInventory = playerInv.id,
                                        toSlot = targetSlot,
                                        fromSlot = fromData,
                                        itemName = fromData.name,
                                        metadata = metadata,
                                        count = count,
                                        price = fromData.price,
                                        totalPrice = price,
                                        currency = currency,
                                }) then return false end

                                local success, added = Inventory.AddItem(playerInv, fromItem.name, count, metadata, targetSlot)
                                if not success then purchasing[source] = nil return false, false, { type = 'error', description = locale('inventory_full') } end
                                targetSlot = added.slot
                                removeCurrency(playerInv, currency, price)

                                if currency == 'bank' then
                                        local player = server.GetPlayerFromId(playerInv.id)
                                        if player then
                                                local receiverId = ('shop_%s'):format(shopType)
                                                TriggerEvent('okokBanking:AddNewTransaction', shop.label, receiverId, GetPlayerName(source), player.PlayerData.identifier, price, ('Zakup w sklepie: %s'):format(metadata?.label or fromItem.label))
                                                TriggerClientEvent('ox_lib:notify', source, { type = 'success', description = ('✅ Zakupiono przedmiot za %s z konta bankowego.'):format(price) })
                                        end
                                end

				if fromData.count then
					shop.items[data.fromSlot].count = fromData.count - count
				end

                               if server.syncInventory then server.syncInventory(playerInv) end
                               TriggerEvent('ox_inventory:refreshInventory', source)
                               purchasing[source] = nil

                               local message = locale('purchased_for', count, metadata?.label or fromItem.label, (currency == 'money' and locale('$') or math.groupdigits(price)), (currency == 'money' and math.groupdigits(price) or ' '..Items(currency).label))

				if server.loglevel > 0 then
					if server.loglevel > 1 or fromData.price >= 500 then
						lib.logger(playerInv.owner, 'buyItem', ('"%s" %s'):format(playerInv.label, message:lower()), ('shop:%s'):format(shop.label))
					end
				end

                                return true, {targetSlot, playerInv.items[targetSlot], shop.items[data.fromSlot].count and shop.items[data.fromSlot], playerInv.weight}, { type = 'success', description = message }
                        end

                        purchasing[source] = nil
                        return false, false, { type = 'error', description = locale('unable_stack_items') }
                end
        end
end)

server.shops = Shops
