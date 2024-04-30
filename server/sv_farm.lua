ESX = exports["es_extended"]:getSharedObject()

--- Recolte raisin rouge & blanc

RegisterServerEvent('RDZ:Rasin')
AddEventHandler('RDZ:Rasin', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    -- Quantités aléatoires de raisins
    local quantiteRaisinRouge = math.random(1, 2)
    local quantiteRaisinBlanc = math.random(2, 3)

    -- Vérifier l'espace dans l'inventaire
    local hasEnoughSpace = xPlayer.canCarryItem('raisinrouge', quantiteRaisinRouge) and xPlayer.canCarryItem('raisinblanc', quantiteRaisinBlanc)

    if hasEnoughSpace then

        TriggerClientEvent('RDZ:RasinRecolteCircleBar', _source)

        Citizen.Wait(3500)

        -- Ajouter des raisins rouges et blancs au joueur
        xPlayer.addInventoryItem('raisinrouge', quantiteRaisinRouge)
        xPlayer.addInventoryItem('raisinblanc', quantiteRaisinBlanc)
        
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez recolte ' .. quantiteRaisinRouge .. ' Rasin Rouge & ' .. quantiteRaisinBlanc .. ' Rasin Blanc')
    else
        -- Si le joueur n'a pas assez d'espace, vous pouvez envoyer un message approprié ou prendre une autre action
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez pas assez de place sur vous !')
    end
end)

--- Traite les raisin rouge & blanc

RegisterServerEvent('RDZ:RaisinTraiteRouge')
AddEventHandler('RDZ:RaisinTraiteRouge', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifiez si le joueur a suffisamment de raisins rouges
    local hasEnoughRaisinRouge = xPlayer.getInventoryItem('raisinrouge').count >= Config.RaisinRouge.removeraisinrouge

    if hasEnoughRaisinRouge then

        TriggerClientEvent('RDZ:RasinTraiteCircleBar', _source)

        Citizen.Wait(3500)

        -- Retirer 2 raisins rouges
        xPlayer.removeInventoryItem('raisinrouge', Config.RaisinRouge.removeraisinrouge)

        -- Ajouter 1 raisin rouge pressé
        xPlayer.addInventoryItem('raisinrougepressage', Config.RaisinRouge.addbarque)

        -- Afficher un message pour informer le joueur
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez pressé ' .. Config.RaisinRouge.removeraisinrouge .. ' raisins rouges.')
    else
        -- Si le joueur n'a pas assez de raisins rouges, afficher un message d'erreur
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de raisins rouges.')
    end
end)

RegisterServerEvent('RDZ:RaisinTraiteBlanc')
AddEventHandler('RDZ:RaisinTraiteBlanc', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifiez si le joueur a suffisamment de raisins rouges
    local hasEnoughRaisinRouge = xPlayer.getInventoryItem('raisinblanc').count >= Config.RaisinBlanc.removeraisinblanc
    
    if hasEnoughRaisinRouge then

        TriggerClientEvent('RDZ:RasinTraiteCircleBar', _source)

        Citizen.Wait(3500)

        -- Retirer 2 raisins rouges
        xPlayer.removeInventoryItem('raisinblanc', Config.RaisinBlanc.removeraisinblanc)

        -- Ajouter 1 raisin rouge pressé
        xPlayer.addInventoryItem('raisinblancpressage', Config.RaisinBlanc.addbarque)

        -- Afficher un message pour informer le joueur
        TriggerClientEvent('esx:showNotification', _source, 'Vous avez pressé ' .. Config.RaisinBlanc.removeraisinblanc .. ' raisins blanc.')
    else
        -- Si le joueur n'a pas assez de raisins rouges, afficher un message d'erreur
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de raisins blanc.')
    end
end)

--- Traite les raisin rouge & blanc Pour devenir en bouteille
RegisterServerEvent('RDZ:RaisinTraiteRouge2')
AddEventHandler('RDZ:RaisinTraiteRouge2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifiez si le joueur a suffisamment de raisins rouges
    local hasEnoughRaisinRouge = xPlayer.getInventoryItem('raisinrougepressage').count >= Config.BarqueRouge.removebarquerouge

    if hasEnoughRaisinRouge then

        TriggerClientEvent('RDZ:RasinTraiteCircleBar2', _source)

        Citizen.Wait(3500)

        -- Retirer 2 raisins rouges
        xPlayer.removeInventoryItem('raisinrougepressage', Config.BarqueRouge.removebarquerouge)

        -- Ajouter 1 raisin rouge pressé
        xPlayer.addInventoryItem('vinrouge', Config.BarqueRouge.addvinrouge)

        -- Afficher un message pour informer le joueur
        TriggerClientEvent('esx:showNotification', _source, 'Vous utilise ' .. Config.BarqueBlanc.removebarquerouge .. ' barque de raisin rouge pour ' .. Config.BarqueBlanc.addvinrouge .. ' vin rouge .')
    else
        -- Si le joueur n'a pas assez de raisins rouges, afficher un message d'erreur
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de barque de raisin rouge.')
    end
end)

RegisterServerEvent('RDZ:RaisinTraiteBlanc2')
AddEventHandler('RDZ:RaisinTraiteBlanc2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifiez si le joueur a suffisamment de raisins rouges
    local hasEnoughRaisinRouge = xPlayer.getInventoryItem('raisinblancpressage').count >= Config.BarqueBlanc.removebarqueblanc

    if hasEnoughRaisinRouge then

        TriggerClientEvent('RDZ:RasinTraiteCircleBar2', _source)

        Citizen.Wait(3500)

        -- Retirer 2 raisins rouges
        xPlayer.removeInventoryItem('raisinblancpressage', Config.BarqueBlanc.removebarqueblanc)

        -- Ajouter 1 raisin rouge pressé
        xPlayer.addInventoryItem('vinblanc', Config.BarqueBlanc.addvinblanc)

        -- Afficher un message pour informer le joueur
        TriggerClientEvent('esx:showNotification', _source, 'Vous utilise ' .. Config.BarqueBlanc.removebarqueblanc .. ' barque de raisin blanc pour ' .. Config.BarqueBlanc.addvinblanc .. ' vin blanc .')
    else
        -- Si le joueur n'a pas assez de raisins rouges, afficher un message d'erreur
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez de barque de raisin blanc.')
    end
end)

-- Vente de Vin rouge

RegisterServerEvent('RDZ:VinRougeVente')
AddEventHandler('RDZ:VinRougeVente', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local vinBlancQuantity = xPlayer.getInventoryItem('vinrouge').count

    if vinBlancQuantity > 0 then
        local pricePerBottle = Config.Bouteille.prixduvinrouge
        local totalPrice = vinBlancQuantity * pricePerBottle

        -- Retirer les bouteilles de vin blanc de l'inventaire du joueur
        xPlayer.removeInventoryItem('vinrouge', vinBlancQuantity)

        -- Ajouter l'argent au joueur
        xPlayer.addMoney(totalPrice)

        -- Afficher une notification de succès
        TriggerClientEvent('ox_lib:notify', _source, {
            type = 'success',
            text = 'Vous avez vendu ' .. vinBlancQuantity .. ' bouteille(s) de vin Rouge pour ' .. totalPrice .. '$.'
        })
    else
        -- Afficher une notification d'erreur si le joueur n'a pas de vin blanc
        TriggerClientEvent('ox_lib:notify', _source, {
            type = 'error',
            text = 'Vous n\'avez pas de bouteille de vin rouge à vendre.'
        })
    end
end)


-- Vente de Vin blanc

RegisterServerEvent('RDZ:VinBlancVente')
AddEventHandler('RDZ:VinBlancVente', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local vinBlancQuantity = xPlayer.getInventoryItem('vinblanc').count

    if vinBlancQuantity > 0 then
        local pricePerBottle = Config.Bouteille.prixduvinblanc
        local totalPrice = vinBlancQuantity * pricePerBottle

        -- Retirer les bouteilles de vin blanc de l'inventaire du joueur
        xPlayer.removeInventoryItem('vinblanc', vinBlancQuantity)

        -- Ajouter l'argent au joueur
        xPlayer.addMoney(totalPrice)

        -- Afficher une notification de succès
        TriggerClientEvent('ox_lib:notify', _source, {
            type = 'success',
            text = 'Vous avez vendu ' .. vinBlancQuantity .. ' bouteille(s) de vin blanc pour ' .. totalPrice .. '$.'
        })
    else
        -- Afficher une notification d'erreur si le joueur n'a pas de vin blanc
        TriggerClientEvent('ox_lib:notify', _source, {
            type = 'error',
            text = 'Vous n\'avez pas de bouteille de vin blanc à vendre.'
        })
    end
end)