ESX = exports["es_extended"]:getSharedObject()

-- Créer une table locale pour stocker les coordonnées
local boxZones = {
    { coords = vector3(-1874.7069, 2098.8540, 139.4133) }, -- Fait
    { coords = vector3(-1877.2382, 2098.8015, 139.5890) }, -- Fait
    { coords = vector3(-1878.7981, 2098.7197, 139.7232) }, -- Fait
    { coords = vector3(-1880.3070, 2098.8291, 139.7157) }, -- Fait
    { coords = vector3(-1882.0720, 2098.7607, 139.6916) }, -- Fait
    { coords = vector3(-1883.7555, 2098.6379, 139.6521) }, -- Fait
    { coords = vector3(-1885.5819, 2099.0435, 139.4313) }, -- Fait
}

-- Parcourez la table des zones de boîte et ajoutez-les une par une
for _, zone in ipairs(boxZones) do
    exports.ox_target:addBoxZone({
        coords = zone.coords,
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                event = 'RDZ:RammasRaisin',
                icon = 'fa-regular fa-user',
                label = "Recolté les raisin",
                distance = 3
            }
        }
    })
end

--- Recolté les raisin 
RegisterNetEvent('RDZ:RammasRaisin')
AddEventHandler('RDZ:RammasRaisin', function()
    TriggerServerEvent('RDZ:Rasin')
end)

RegisterNetEvent('RDZ:RasinRecolteCircleBar')
AddEventHandler('RDZ:RasinRecolteCircleBar', function()
    TriggerEvent("RDZ:Animation:Raisin0")

    lib.progressCircle({
        duration = 3500,
        label = 'Recolte des Raisin',
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })

    TriggerEvent("RDZ:Raisin0:StopAnimation")
end)

RegisterNetEvent("RDZ:Animation:Raisin0")
AddEventHandler("RDZ:Animation:Raisin0", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Figé le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
end)

RegisterNetEvent("RDZ:Raisin0:StopAnimation")
AddEventHandler("RDZ:Raisin0:StopAnimation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)

-- Traitement raisin blanc & rouge 

exports.ox_target:addBoxZone({
    coords = {x = -1931.8824, y = 2055.4487, z = 140.7554},
    size = vec3(1, 1, 1),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'box',
            event = 'RDZ:TraiteRaisin',
            icon = 'fa-regular fa-user',
            label = "Traitement Rasin",
            job = "vigneron",
        }
    }
})
--- Traitement des raisin 
RegisterNetEvent('RDZ:TraiteRaisin')
AddEventHandler('RDZ:TraiteRaisin', function()
    lib.showContext('RDZ:Menutraitement')
end)

--- Menu Traitement Vigneron
lib.registerContext({
    id = 'RDZ:Menutraitement',
    title = 'Pressage de raisin',
    options = {
        {
            title = 'Pressage de raisin rouge',
            icon = 'fa fa-fire',
            event = 'RDZ:TraiteRaisinRouge',
        },
        {
            title = 'Pressage de raisin blanc',
            icon = 'fa fa-fire',
            event = 'RDZ:TraiteRaisinBlanc',
        },
    },
})

--- Traitement des raisin 
RegisterNetEvent('RDZ:TraiteRaisinRouge')
AddEventHandler('RDZ:TraiteRaisinRouge', function()
    TriggerServerEvent('RDZ:RaisinTraiteRouge')
end)

--- Traitement des raisin 
RegisterNetEvent('RDZ:TraiteRaisinBlanc')
AddEventHandler('RDZ:TraiteRaisinBlanc', function()
    TriggerServerEvent('RDZ:RaisinTraiteBlanc')
end)

RegisterNetEvent('RDZ:RasinTraiteCircleBar')
AddEventHandler('RDZ:RasinTraiteCircleBar', function()
    TriggerEvent("RDZ:Animation:Raisin2")

    lib.progressCircle({
        duration = 3500,
        label = 'Presse les Raisin',
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })

    TriggerEvent("RDZ:Raisin2:StopAnimation")
end)

RegisterNetEvent("RDZ:Animation:Raisin2")
AddEventHandler("RDZ:Animation:Raisin2", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Figé le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
end)

RegisterNetEvent("RDZ:Raisin2:StopAnimation")
AddEventHandler("RDZ:Raisin2:StopAnimation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)

-- Traitement raisin blanc & rouge 

exports.ox_target:addBoxZone({
    coords = {x = -1867.7405, y = 2058.7830, z = 140.9978},
    size = vec3(1, 1, 1),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'box',
            event = 'RDZ:bouteilleraisin',
            icon = 'fa-regular fa-user',
            label = "Mise en bouteille",
            job = "vigneron",
        }
    }
})
--- Traitement des raisin 
RegisterNetEvent('RDZ:bouteilleraisin')
AddEventHandler('RDZ:bouteilleraisin', function()
    lib.showContext('RDZ:MenuBouteille')
end)

--- Menu Traitement Vigneron
lib.registerContext({
    id = 'RDZ:MenuBouteille',
    title = 'Mise en bouteille',
    options = {
        {			
            title = 'Vin Rouge',
            description = 'Besoin : ' .. Config.BarqueRouge.removebarquerouge ..  ' raisain rouge presser',
            event = 'RDZ:TraiteRaisinRouge2',
            icon = 'wine-bottle',					
        },
        {			
            title = 'Vin Blanc',
            description = 'Besoin : ' .. Config.BarqueBlanc.removebarqueblanc ..  ' raisain blanc presser',
            event = 'RDZ:TraiteRaisinBlanc2',
            icon = 'wine-bottle',					
        },
    },
})

--- Traitement des raisin 
RegisterNetEvent('RDZ:TraiteRaisinRouge2')
AddEventHandler('RDZ:TraiteRaisinRouge2', function()
    TriggerServerEvent('RDZ:RaisinTraiteRouge2')
end)

--- Traitement des raisin 
RegisterNetEvent('RDZ:TraiteRaisinBlanc2')
AddEventHandler('RDZ:TraiteRaisinBlanc2', function()
    TriggerServerEvent('RDZ:RaisinTraiteBlanc2')
end)

RegisterNetEvent('RDZ:RasinTraiteCircleBar2')
AddEventHandler('RDZ:RasinTraiteCircleBar2', function()
    TriggerEvent("RDZ:Animation:Raisin3")

    lib.progressCircle({
        duration = 3500,
        label = 'Mise en bouteille',
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })

    TriggerEvent("RDZ:Raisin3:StopAnimation")
end)

RegisterNetEvent("RDZ:Animation:Raisin3")
AddEventHandler("RDZ:Animation:Raisin3", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Figé le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
end)

RegisterNetEvent("RDZ:Raisin3:StopAnimation")
AddEventHandler("RDZ:Raisin3:StopAnimation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)

-- Ped vente Grossiste
Citizen.CreateThread(function()
    local hash = GetHashKey("a_m_y_soucent_02")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "a_m_y_soucent_02", vector4(90.9538, -1603.5936, 30.0791, 231.0100), true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)  

-- Vente Grosiste

exports.qtarget:AddBoxZone("Vigneron Vente", vector3(91.2429, -1603.7640, 30.0791), 2.0 , 2.5, {	
	name="Vigneron Vente",
	heading=35,
	debugPoly=false,
	minZ=16.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "RDZ:ventevinrouge",
				icon = "fa fa-fire",
				label = "Vente Vin rouge",
				job = "vigneron",
			},

			{
				event = "RDZ:ventevinblanc",
				icon = "fa fa-fire",
				label = "Vente Vin Blanc",
				job = "vigneron",
			},

		},
	distance = 5.0
})
  
-- Gestion de la vente de vin rouge côté client
RegisterNetEvent('RDZ:ventevinrouge')
AddEventHandler('RDZ:ventevinrouge', function()
    TriggerServerEvent('RDZ:VinRougeVente')
end)

--- Vente vin blanc 
RegisterNetEvent('RDZ:ventevinblanc')
AddEventHandler('RDZ:ventevinblanc', function()
    TriggerServerEvent('RDZ:VinBlancVente')
end)

RegisterNetEvent('RDZ:VenteBouteille')
AddEventHandler('RDZ:VenteBouteille', function()
    TriggerEvent("RDZ:Animation:Vente")

    lib.progressCircle({
        duration = 3500,
        label = 'Mise en bouteille',
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })

    TriggerEvent("RDZ:Vente:StopAnimation")
end)

RegisterNetEvent("RDZ:Animation:Vente")
AddEventHandler("RDZ:Animation:Vente", function()
    FreezeEntityPosition(PlayerPedId(), true) -- Figé le joueur
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
end)

RegisterNetEvent("RDZ:Vente:StopAnimation")
AddEventHandler("RDZ:Vente:StopAnimation", function()
    ClearPedTasks(PlayerPedId())  -- Arrêter l'animation
    FreezeEntityPosition(PlayerPedId(), false)    -- Unfreeze le joueur
end)
