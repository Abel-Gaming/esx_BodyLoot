ESX              = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(250)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local closestPed = ESX.Game.GetClosestPed(playerCoords)
		local closestPedCoords = GetEntityCoords(closestPed)

		while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(closestPed)) <= 1.5 do
			Citizen.Wait(0)
			if IsEntityDead(closestPed) then
				ESX.Game.Utils.DrawText3D(GetEntityCoords(closestPed), "Press [~b~E~w~] to loot body", 0.6, 1)
				if IsControlJustReleased(0, 51) then
					RequestAnimDict("random@domestic")
					while not HasAnimDictLoaded("random@domestic") do
						Citizen.Wait(1)
					end
					TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 8.0, -8, 2000, 2, 0, 0, 0, 0)
					Citizen.Wait(2000)
					local randomNumber = math.random(1, #Config.LootItems)
					--print(randomNumber)
					local randomItem = Config.LootItems[randomNumber]
					--print(randomItem)
					TriggerServerEvent('esx_BodyLoot:TakeItem', randomItem)
					DeleteEntity(closestPed)
				end
			end
		end
	end
end)
