ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterCommand('mesaigir', function()
  local myJob = ESX.PlayerData.job.name
  local founded = false

  if myJob == 'offpolice' or myJob == 'offambulance' or myJob == 'offsheriff' then
      local ped = PlayerPedId()
      local pCoords = GetEntityCoords(ped)
      local dst = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, KVL.EMSLocation.x, KVL.EMSLocation.y, KVL.EMSLocation.z, false)
      local dst2 = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, KVL.PDLocation.x, KVL.PDLocation.y, KVL.PDLocation.z, false)
      local dst3 = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, KVL.SDLocation.x, KVL.SDLocation.y, KVL.SDLocation.z, false)

      if myJob == 'offambulance' then
      if dst < 100 then
        founded = true
      end

      if founded then
            TriggerServerEvent('kvl-duty:mesai')
        else
            exports['mythic_notify']:DoHudText('inform', 'Çok uzaktasın!')
        end
      end

      if myJob == 'offpolice' then
      if dst2 < 100 then
        founded = true
      end

        if founded then
          TriggerServerEvent('kvl-duty:mesai')
        else
          exports['mythic_notify']:DoHudText('inform', 'Çok uzaktasın!')
        end
      end

    if myJob == 'offsheriff' then
      if dst3 < 100 then
        founded = true
      end
      
        if founded then
          TriggerServerEvent('kvl-duty:mesai')
        else
          exports['mythic_notify']:DoHudText('inform', 'Çok uzaktasın!')
        end
    end

  end

  if myJob == 'police' or myJob == 'ambulance' or myJob == 'sheriff' then
    exports['mythic_notify']:DoHudText('inform', 'Zaten mesaidesin!')
  end
end)

RegisterCommand('mesaicik', function()
  local myJob = ESX.PlayerData.job.name
  local founded = false

  if myJob == 'police' or myJob == 'ambulance' or myJob == 'sheriff' then
      local ped = PlayerPedId()
      local pCoords = GetEntityCoords(ped)
      local dst = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, KVL.EMSLocation.x, KVL.EMSLocation.y, KVL.EMSLocation.z, false)
      local dst2 = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, KVL.PDLocation.x, KVL.PDLocation.y, KVL.PDLocation.z, false)
      local dst3 = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, KVL.SDLocation.x, KVL.SDLocation.y, KVL.SDLocation.z, false)

      if myJob == 'ambulance' then
      if dst < 100 then
        founded = true
      end

      if founded then
            TriggerServerEvent('kvl-duty:mesai')
        else
            exports['mythic_notify']:DoHudText('inform', 'Çok uzaktasın!')
        end
      end

      if myJob == 'police' then
      if dst2 < 100 then
        founded = true
      end

        if founded then
          TriggerServerEvent('kvl-duty:mesai')
        else
          exports['mythic_notify']:DoHudText('inform', 'Çok uzaktasın!')
        end
      end

    if myJob == 'sheriff' then
      if dst3 < 100 then
        founded = true
      end
      
        if founded then
          TriggerServerEvent('kvl-duty:mesai')
        else
          exports['mythic_notify']:DoHudText('inform', 'Çok uzaktasın!')
        end
    end

  end

  if myJob == 'offpolice' or myJob == 'offambulance' or myJob == 'offsheriff' then
    exports['mythic_notify']:DoHudText('inform', 'Zaten mesai dışındasın!')
  end
end)
