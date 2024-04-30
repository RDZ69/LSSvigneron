ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'vigneron', 'vigneron', 'society_vigneron', 'society_vigneron', 'society_vigneron', {type = 'public'})

--- Annonce Vigneron
RegisterServerEvent('RDZ:vigneron:AnnonceOuvert')
AddEventHandler('RDZ:vigneron:AnnonceOuvert', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'vigneron', '~b~Annonce', '~g~vigneron Ouvert', 7)
    end
end)

RegisterServerEvent('RDZ:vigneron:AnnonceFermer')
AddEventHandler('RDZ:vigneron:AnnonceFermer', function()
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        
        -- Afficher la notification avancée ESX
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'vigneron', '~b~Annonce', '~r~Vigneron Fermé', 7)
        end
end)

--- Coffre 
local borderstash = {
    id = 'vigneronCoffre',
    label = 'Coffre vigneron',
    slots = 90,
    weight = Config.PositionTarget.Poids,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
		exports.ox_inventory:RegisterStash(borderstash.id, borderstash.label, borderstash.slots, borderstash.weight, borderstash.owner)
    end
end)