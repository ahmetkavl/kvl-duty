ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('kvl-duty:mesai')
AddEventHandler('kvl-duty:mesai', function(job, target)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local myjob = xPlayer.getJob()
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    local src = source
    
    if job == 'police' or job == 'ambulance' or job == 'sheriff' then
        xPlayer.setJob('off' ..job, grade)
        kvllog(src,  ' '..GetProperty(src).. ' \n  **EYLEM** : Mesaiden ayrılma \n **Departman** : **'..myjob.label..'**  ')
        TriggerClientEvent('esx:showNotification', src, 'Mesaiden çıktın!')
    elseif job == 'offpolice' then
        xPlayer.setJob('police', grade)
        kvllog(src,  ' '..GetProperty(src).. ' \n  **EYLEM** : Mesaiye girme \n **Departman** : '..myjob.label..'')
        TriggerClientEvent('esx:showNotification', src, 'Mesaiye girdin!')
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        kvllog(src,  ' '..GetProperty(src).. ' \n  **EYLEM** : Mesaiye girme \n **Departman** : '..myjob.label..' ')
        TriggerClientEvent('esx:showNotification', src, 'Mesaiye girdin!')
    elseif job == 'offsheriff' then
        xPlayer.setJob('sheriff', grade)
        kvllog(src,  ' '..GetProperty(src).. ' \n **EYLEM** : Mesaiye girme \n **Departman** : '..myjob.label..' ')
        TriggerClientEvent('esx:showNotification', src, 'Mesaiye girdin!')
    end
end)

function GetProperty(id, Prop)
    local text = "**OYUNCU** \n" ..GetPlayerName(id).." ("..id..")"
    for k,v in pairs(GetPlayerIdentifiers(id)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            text = text.."\n**DISCORD** \n<@" .. string.gsub(v,"discord:","") .. ">"
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
            text = text.."\n**STEAM ID** \n"..v
            text = text.."\n**STEAM URL** \nhttps://steamcommunity.com/profiles/"..tonumber(string.gsub(v, "steam:", ""),16)
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            text = text.."\n**LISANS** \n"..v
        end
    end
    return text
end

Citizen.CreateThread(function()
    if GetCurrentResourceName() == 'kvl-duty' then
    else
        Citizen.Wait(5000)
        os.exit()
    end
 end)

 function kvllog(xPlayer, text)
    local discord_webhook = "webhookgirin"
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "KVL Logger | Mesai Giriş & Çıkış Log",
      ["avatar_url"] = "https://cdn.discordapp.com/attachments/800338082120466462/830154275623141436/kvlv1.jpg",
      ["embeds"] = {{
        ["author"] = {
          ["name"] = ""
        },
        ["color"] = 975243,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
    local replacements = {
        ['&' ] = '&amp;',
        ['<' ] = '&lt;',
        ['>' ] = '&gt;',
        ['\n'] = '<br/>'
    }

    return str
        :gsub('[&<>\n]', replacements)
        :gsub(' +', function(s)
            return ' '..('&nbsp;'):rep(#s-1)
        end)
end
