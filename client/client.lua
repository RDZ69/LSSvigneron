ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'vigneron', 'vigneron', 'society_vigneron', 'society_vigneron', 'society_vigneron', {type = 'public'})

if Config.useMarker and ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
    -- Créer un marker
    local markerOptions = {
        coords = Config.PositionMarker.CoffreMarker, -- Coordonnées du marker
        type = Config.TypeMarker, -- Type de marker : standard
        width = 0.30, -- Largeur du marker
        height = 0.25, -- Hauteur du marker
        color = Config.ColorMarker,
    }        

    local markerCoffre = lib.marker.new(markerOptions)

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            
            markerCoffre:draw()

            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.PositionMarker.CoffreMarker.x, Config.PositionMarker.CoffreMarker.y, Config.PositionMarker.CoffreMarker.z) -- Calculer la distance entre le joueur et le marker
            
            if distance < 1.5 then
                if not lib.isTextUIOpen() then
                    lib.showTextUI("[E] Pour ouvrir le coffre")
                end

                if IsControlJustPressed(0, 51) then -- Si le joueur appuie sur la touche E
                    lib.notify({ description = "Vous avez ouvert le Coffre de stockage!" }) -- Afficher une notification
                    TriggerEvent('vigneron:coffre') -- Déclencher l'événement pour commencer le braquage Brinks
                end
            else
                if lib.isTextUIOpen() then
                    lib.hideTextUI() -- Cacher l'interface texte si le joueur n'est pas à proximité
                end
            end
        end
    end)
else    
    exports.qtarget:AddBoxZone("vigneronCoffre", (Config.PositionTarget.Coffre), 1.0 , 1.5, {
	name="vigneronCoffre",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "vigneron:coffre",
				icon = "fa fa-university",
				label = "Coffre",
				job = "vigneron",
			},
		},
	distance = 2.5
})
end

RegisterNetEvent('vigneron:coffre')
AddEventHandler('vigneron:coffre', function()
	exports.ox_inventory:openInventory('stash', {id='vigneronCoffre', owner= false, job = vigneron})
end)

--- Blips Location Job Vigneron
function CreateBlipCircle(coords, text, color, sprite)
	blip = AddBlipForCoord(coords)

	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	CreateBlipCircle(vector3(Config.vigneronLocation.x, Config.vigneronLocation.y, Config.vigneronLocation.z), Config.vigneronBlipText, Config.vigneronBlipColor, Config.vigneronBlipSprite)
end)

--- Menu F6

lib.registerContext({
  id = 'RDZ_vigneron',
  title = 'Menu Vigneron',
  options = {
      {
          title = 'Annonces', -- Fait
          icon = 'wifi',
          menu = 'RDZ:annonce_menuvigneron',
      },
      { -- Fait
          title = 'Demande Point Farm',
          icon = 'fa fa-fire',
          menu = 'RDZ:pointfarm_menuvigneron',
      },
      { -- Fait
          title = 'Facture',
          icon = 'file-lines',
          event = 'RDZ:vigneron:sendbill'
      },
  },
  { -- Fait
      id = 'RDZ:annonce_menuvigneron',
      title = 'Annonces',
      menu = 'menu_vigneron',
      options = {
          ['Ouvert'] = {event = 'RDZ:annonceOvigneron', icon = 'fa fa-check-circle'},
          ['Fermer'] = {event = 'RDZ:annonceFvigneron', icon = 'fa fa-times-circle'}
      }
  },
  { -- Fait
      id = 'RDZ:pointfarm_menuvigneron',
      title = 'Point Farm',
      menu = 'menu_vigneron',
      options = {
        ['Recolte'] = {event = 'RDZ:Recolteblip', icon = 'fa fa-check-circle'},
        ['Pressage de raisin'] = {event = 'RDZ:Traitementblip', icon = 'fa fa-check-circle'},
        ['Mise en bouteille'] = {event = 'RDZ:Traitementblip2', icon = 'fa fa-check-circle'},
        ['Vente'] = {event = 'RDZ:Venteblip', icon = 'fa fa-times-circle'},
      }
  }
})

-- Blips recolte traitement vente ect ...

RegisterNetEvent('RDZ:Recolteblip')
AddEventHandler('RDZ:Recolteblip', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
		local blip = AddBlipForCoord(-1878.8734, 2096.2300, 140.3414) 
		SetNewWaypoint(-1878.8734, 2096.2300, 140.3414)
		SetBlipSprite (blip, 85) 
		SetBlipScale  (blip, 1.0) 
		SetBlipColour (blip, 49) 
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Recolte Vigneron') 
		EndTextCommandSetBlipName(blip)
	end
	ESX.ShowNotification('~y~Regarde ta carte pour le point de Recolte de raisin')
end)

RegisterNetEvent('RDZ:Traitementblip')
AddEventHandler('RDZ:Traitementblip', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
		local blip = AddBlipForCoord(-1929.1469, 2060.7495, 140.8242) 
		SetNewWaypoint(-1929.1469, 2060.7495, 140.8242)
		SetBlipSprite (blip, 85)
		SetBlipScale  (blip, 1.0) 
		SetBlipColour (blip, 49) 
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Traitement') 
		EndTextCommandSetBlipName(blip)
	end
	ESX.ShowNotification('~y~Regarde ta carte pour le point de pressage de raisin')
end)

RegisterNetEvent('RDZ:Traitementblip2')
AddEventHandler('RDZ:Traitementblip2', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
		local blip = AddBlipForCoord(-1866.3865, 2058.4058, 140.9984) 
		SetNewWaypoint(-1866.3865, 2058.4058, 140.9984)
		SetBlipSprite (blip, 85)
		SetBlipScale  (blip, 1.0) 
		SetBlipColour (blip, 49) 
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Traitement') 
		EndTextCommandSetBlipName(blip)
	end
	ESX.ShowNotification('~y~Regarde ta carte pour le point de Mise en bouteille')
end)

RegisterNetEvent('RDZ:Venteblip')
AddEventHandler('RDZ:Venteblip', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then 
		local blip = AddBlipForCoord(91.4010, -1603.8853, 30.8950) 
		SetNewWaypoint(91.4010, -1603.8853, 30.8950)
		SetBlipSprite (blip, 85) 
		SetBlipScale  (blip, 1.0) 
		SetBlipColour (blip, 49) 
		SetBlipAsShortRange(blip, true)
	
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Vente Grosiste') 
		EndTextCommandSetBlipName(blip)
	end
	ESX.ShowNotification('~y~Regarde ta carte pour le point de Vente')

end)

-- Création de la keybind pour ouvrir le menu sans utiliser /vigneron
Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      if IsControlJustPressed(0, 167) then -- Touche F6
          local xPlayer = ESX.GetPlayerData()
          if xPlayer.job.name == 'vigneron' then
              lib.showContext('RDZ_vigneron')
          end
      end
  end
end)

--- Annonce Vigneron
RegisterNetEvent('RDZ:annonceOvigneron')
AddEventHandler('RDZ:annonceOvigneron', function()
    TriggerServerEvent('RDZ:vigneron:AnnonceOuvert')
end)

RegisterNetEvent('RDZ:annonceFvigneron')
AddEventHandler('RDZ:annonceFvigneron', function()
    TriggerServerEvent('RDZ:vigneron:AnnonceFermer')
end)

--- Vigneron Facture
RegisterNetEvent('RDZ:vigneron:sendbill')
AddEventHandler('RDZ:vigneron:sendbill', function()
      local input = lib.inputDialog('FACTURE vigneron', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('~r~Personne proche !')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_vigneron', 'Facture vigneron', amount)
			end
		end
    end
end)

-- Menu boss vigneron
if Config.useMarker and ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
    -- Créer un marker
    local markerOptions = {
        coords = Config.PositionMarker.BossMarker, -- Coordonnées du marker
        type = Config.TypeMarker, -- Type de marker : standard
        width = 0.30, -- Largeur du marker
        height = 0.25, -- Hauteur du marker
        color = Config.ColorMarker,
    }        

    local markerBoss = lib.marker.new(markerOptions)

    -- Fonction pour vérifier si le joueur est à proximité du marker
    Citizen.CreateThread(function()
        while true do
            Wait(0) -- Attendre une frame pour ne pas surcharger le CPU
            
            markerBoss:draw() -- Dessiner le marker

            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.PositionMarker.BossMarker.x, Config.PositionMarker.BossMarker.y, Config.PositionMarker.BossMarker.z) -- Calculer la distance entre le joueur et le marker
            
            if distance < 1.5 then
                if not lib.isTextUIOpen() then
                    lib.showTextUI("[E] Pour ouvrir l'ordinateur") -- Afficher une instruction
                end

                if IsControlJustPressed(0, 51) then -- Si le joueur appuie sur la touche E
                    lib.notify({ description = "Vous avez ouvert l'ordinateur!" }) -- Afficher une notification
                    TriggerEvent('RDZ:MenuBoss') -- Déclencher l'événement pour commencer le braquage Brinks
                end
            else
                if lib.isTextUIOpen() then
                    lib.hideTextUI() -- Cacher l'interface texte si le joueur n'est pas à proximité
                end
            end
        end
    end)
else
    -- Target menu boss
    exports.ox_target:addBoxZone({
        coords = Config.PositionTarget.Boss,
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'box',
                event = 'RDZ:MenuBoss',
                icon = 'fa-regular fa-user',
                label = "Menu Boss",
                job = "vigneron",
            }
        }
    })
end

RegisterNetEvent('RDZ:MenuBoss')
AddEventHandler('RDZ:MenuBoss', function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' and ESX.PlayerData.job.grade_name == 'boss' then
        TriggerEvent('esx_society:openBossMenu', 'vigneron', function()
        end)
    end
end)


--- Menu Vestiaire
if Config.useMarker and ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
    -- Créer un marker
    local markerOptions = {
        coords = Config.PositionMarker.ClothesMarker, -- Coordonnées du marker
        type = Config.TypeMarker, -- Type de marker : standard
        width = 0.30, -- Largeur du marker
        height = 0.25, -- Hauteur du marker
        color = Config.ColorMarker,
    }        

    local markerVestiaire = lib.marker.new(markerOptions)

    -- Fonction pour vérifier si le joueur est à proximité du marker
    Citizen.CreateThread(function()
        while true do
            Wait(0) -- Attendre une frame pour ne pas surcharger le CPU
            
            markerVestiaire:draw() -- Dessiner le marker

            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.PositionMarker.ClothesMarker.x, Config.PositionMarker.ClothesMarker.y, Config.PositionMarker.ClothesMarker.z) -- Calculer la distance entre le joueur et le marker
            
            if distance < 1.5 then
                if not lib.isTextUIOpen() then
                    lib.showTextUI("[E] Pour ouvrir votre cassier") -- Afficher une instruction
                end

                if IsControlJustPressed(0, 51) then -- Si le joueur appuie sur la touche E
                    lib.notify({ description = "Vous avez ouvert votre cassier!" }) -- Afficher une notification
                    TriggerEvent('RDZ:vigneron:vetement') -- Déclencher l'événement pour commencer le braquage Brinks
                end
            else
                if lib.isTextUIOpen() then
                    lib.hideTextUI() -- Cacher l'interface texte si le joueur n'est pas à proximité
                end
            end
        end
    end)
else
exports.qtarget:AddBoxZone("vigneronVetement", Config.PositionTarget.Clothes, 1.0 , 1.5, {
	name="vigneronVetement",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "RDZ:vigneron:vetement",
				icon = "fas fa-tshirt",
				label = "Vetements",
				job = "vigneron",
			},
		},
	distance = 2.5
})
end

RegisterNetEvent('RDZ:vigneron:vetement')
AddEventHandler('RDZ:vigneron:vetement', function()
	lib.registerContext({
		id = 'VetementVigneron',
		title = 'Vetements',
		onExit = function()
		end,
		options = {
			{
				title = 'Vos Vetement',
				icon = "fas fa-tshirt",
				description = 'Prendre vos propre vetement',
				onSelect = function(args)				
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)		
                        TriggerEvent('RDZ:VettementChangerRemet')
                        Citizen.Wait(3500)
						TriggerEvent('skinchanger:loadSkin', skin)											
						ESX.ShowNotification('~r~Fin de service')
					end)
				end,
			},
			{
				title = 'Vetement Vigneron',
				icon = "fas fa-tshirt",
				description = 'Vetement de travail',
				onSelect = function(args)
					local playerPed = PlayerPedId()
                    TriggerEvent('RDZ:VettementChanger')
                    Citizen.Wait(4500)
					setUniform('Vigneron_wear', playerPed)
					ESX.ShowNotification('~g~Pret à travailler')
				end,
			},		
		},
	})
	lib.showContext('VetementVigneron')
end)

function setUniform(job)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            end

            if job == 'Vigneron_wear' then
				SetPedArmour(playerPed, 0)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            end

            if job == 'Vigneron_wear' then
                SetPedArmour(playerPed, 0)
            end
        end
    end)
end

-- Cet événement démarre la barre de compétences côté client
RegisterNetEvent('RDZ:VettementChanger')
AddEventHandler('RDZ:VettementChanger', function()
    TriggerEvent('RDZ:Animation:vettements')

    lib.progressCircle({
        duration = 4500,
        label = "S'habille",
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
        },
    })

    TriggerEvent('RDZ:stopvettement:Animation')
end)

RegisterNetEvent("RDZ:Animation:vettements")
AddEventHandler("RDZ:Animation:vettements", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Freeze le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STRIP_WATCH_STAND", 0, true)
end)


RegisterNetEvent("RDZ:stopvettement:Animation")
AddEventHandler("RDZ:stopvettement:Animation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)


-- Cet événement démarre la barre de compétences côté client
RegisterNetEvent('RDZ:VettementChangerRemet')
AddEventHandler('RDZ:VettementChangerRemet', function()
    TriggerEvent('RDZ:Animation:deshabille')

    lib.progressCircle({
        duration = 3500,
        label = "Remet ses vettement",
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
        },
    })

    TriggerEvent('RDZ:deshabillevettement:Animation')
end)

RegisterNetEvent("RDZ:Animation:deshabille")
AddEventHandler("RDZ:Animation:deshabille", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Freeze le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STRIP_WATCH_STAND", 0, true)
end)

RegisterNetEvent("RDZ:deshabillevettement:Animation")
AddEventHandler("RDZ:deshabillevettement:Animation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)