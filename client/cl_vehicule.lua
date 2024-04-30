local Options = {}

-- Menu boss vigneron
if Config.useMarker and ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
    -- Créer un marker
    local markerOptions = {
        coords = Config.PositionMarker.GarageMarker, -- Coordonnées du marker
        type = Config.TypeMarker, -- Type de marker : standard
        width = 0.30, -- Largeur du marker
        height = 0.25, -- Hauteur du marker
        color = Config.ColorMarker,
    }        

    local markerGarage = lib.marker.new(markerOptions)

    -- Fonction pour vérifier si le joueur est à proximité du marker
    Citizen.CreateThread(function()
        while true do
            Wait(0) -- Attendre une frame pour ne pas surcharger le CPU
            
            markerGarage:draw() -- Dessiner le marker

            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.PositionMarker.GarageMarker.x, Config.PositionMarker.GarageMarker.y, Config.PositionMarker.GarageMarker.z) -- Calculer la distance entre le joueur et le marker
            
            if distance < 1.5 then
                if not lib.isTextUIOpen() then
                    lib.showTextUI("[E] Pour ouvrir le Garage") 
                end

                if IsControlJustPressed(0, 51) then
                    lib.notify({ description = "Vous voulez quoi comme vehicule !" }) 
                    TriggerEvent('RDZ:vehicule') 
                end
            else
                if lib.isTextUIOpen() then
                    lib.hideTextUI()
                end
            end
        end
    end)
else
exports.qtarget:AddBoxZone("RDZ:Vehicule", Config.PositionTarget.Garage, 1.0 , 1.5, {
	name="RDZ:Vehicule",
	heading=35,
	debugPoly=false, 
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "RDZ:vehicule", 
				icon = "fa fa-car",
				label = "Garage",
				job = "vigneron",
			},
		},
	distance = 2.5
})
end 

RegisterNetEvent('RDZ:vehicule')
AddEventHandler('RDZ:vehicule', function()
    lib.showContext('RDZ:vehicule')
end)

for i = 1, #Config.cars.vigneron do
    if i == 1 then
        Options[i] = { title = Config.cars.vigneron[i].nom, args = Config.cars.vigneron[i].modele, icon = "fa fa-car", event = 'RDZ:delCar'}
    else
        Options[i] = { title = Config.cars.vigneron[i].nom, args = Config.cars.vigneron[i].modele, icon = "fa fa-car", event = 'RDZ:spawnCar'}
    end
end

lib.registerContext({
	id = 'RDZ:vehicule',
	title = 'Garage',
	options = Options,
})

function createCarvigneron(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.SpawnVeh.vigneron, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = 'RDZ Vigneron'
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('RDZ:spawnCar', function(data)
    createCarvigneron(data)
end)

RegisterNetEvent('RDZ:delCar')
AddEventHandler('RDZ:delCar',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

--- ped garage
Citizen.CreateThread(function()
	local hash = GetHashKey("a_m_m_beach_01")
	while not HasModelLoaded(hash) do
	RequestModel(hash)
	Wait(1000)
	end
	ped = CreatePed("a_m_m_beach_01", "a_m_m_beach_01", -1923.12, 2057.68, 139.81, 258.03, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetEntityInvincible(ped, true)
	FreezeEntityPosition(ped, true)
end)

-- Ranger le vehicule
local point = lib.points.new({
    coords = vector3(-1920.6255, 2048.6821, 140.6886),
    distance = 5, -- Distance de détection autour du point
    dunak = 'nerd', -- Propriété personnalisée
})

function point:nearby()
    -- Vérifier si le joueur appartient au job vigneron
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
        DrawMarker(1, self.coords.x, self.coords.y, self.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 0, 255, 200, false, true, 2, false, nil, nil, false)
    
        -- Vérifier si le joueur est à proximité du point et appuie sur la touche E
        if self.currentDistance < 2 and IsControlJustReleased(0, 38) then
            -- Vérifier si le joueur est dans un véhicule
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if vehicle ~= 0 then
                -- Si le joueur est dans un véhicule, supprimer le véhicule
                DeleteEntity(vehicle)
                lib.notify({ description = "Vous avez rendu le véhicule à Bob !" }) -- Afficher une notification
            else
                -- Si le joueur n'est pas dans un véhicule, afficher un message
                lib.notify({ description = "Vous devez être dans un véhicule pour effectuer cette action." })
            end
        end
    end
end