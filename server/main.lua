ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_BodyLoot:TakeItem")
AddEventHandler("esx_BodyLoot:TakeItem", function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.canCarryItem(item, 1) then
		xPlayer.addInventoryItem(item, 1)
		local itemLabel = ESX.GetItemLabel(item)
		xPlayer.showNotification('You found ~y~1' .. '~b~ ' .. itemLabel)
	else
		xPlayer.showNotification('~r~[ERROR]~w~ You do not have space for this item!')
	end
end)