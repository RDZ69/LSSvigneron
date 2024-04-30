Config = {}

--- Blip Vigneron
Config.vigneronLocation =  {x = -1897.66, y = 2068.58, z = 140.81} 	
Config.vigneronBlipText = "RDZ | Vigneron"
Config.vigneronBlipColor = 49
Config.vigneronBlipSprite = 85

Config.useMarker = true -- Marker or Target (true = Marker) (false = Target)
Config.TypeMarker = 2 -- Si marker true vous pouvez changez le marker que vous-voulez (https://docs.fivem.net/docs/game-references/markers/)
Config.ColorMarker = { r = 0, g = 60, b = 255, a = 200 }

-- Position Marker
Config.PositionMarker = {
    BossMarker =  {x = -1899.4666, y = 2069.0125, z = 141.0206}, 	-- Position du menu Boss
    CoffreMarker =  {x = -1876.4818, y = 2058.8184, z = 141.0060}, 	-- Position du Coffre Vigneron
    ClothesMarker =  {x = -1875.8593, y = 2054.5991, z = 141.0690}, -- Position du Vestiare Vigneron
    GarageMarker =  {x = -1922.5287, y = 2057.5308, z = 140.8321}, -- Position du Vestiare Vigneron
}

-- Position Target
Config.PositionTarget = {
    Boss =  {x = -1899.4666, y = 2069.0125, z = 141.0206}, 	-- Position du menu Boss
    Clothes =  {x = -1875.8593, y = 2054.5991, z = 141.0690}, -- Position du Vestiare Vigneron
    Garage =  {x = -1923.12, y = 2057.68, z = 140.82}, -- Position du Vestiare Vigneron

	Coffre =  {x = -1876.4818, y = 2058.8184, z = 141.0060}, 	-- Position du Coffre Vigneron
	Poids = 100000, -- 100000 en gr equivalent a 100Kg
}

Config.cars = {
	vigneron = {
    {nom = "Ranger véhicule", modele = ""},
    {nom = "PickUp", modele = "bodhi2"}, 
	{nom = "Quatre Roue", modele = "verus"},
	},
}

Config.SpawnVeh = {
    vigneron = vector4(-1919.014, 2057.14, 140.73, 252.83),
}

--- Vettements de travail
Config.Uniforms = {
	Vigneron_wear = {
 		male = {
 			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
 			['torso_1'] = 369,   ['torso_2'] = 8,
 			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 40,
 			['pants_1'] = 8,   ['pants_2'] = 3,
 			['shoes_1'] = 7,   ['shoes_2'] = 9,
			['helmet_1'] = 155,  ['helmet_2'] = 1,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
        },

 		female = {
 			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
 			['torso_1'] = 27,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 23,   ['pants_2'] = 6,
			['shoes_1'] = 6,   ['shoes_2'] = 0,
 			['helmet_1'] = -1,  ['helmet_2'] = 0,
 			['chain_1'] = 0,    ['chain_2'] = 0,
 			['ears_1'] = -1,     ['ears_2'] = 0	
        },
	},
}

Config.RaisinRouge = {
	removeraisinrouge = 2, -- enleve 2 raisin rouge
	addbarque = 1, -- donne 1 barquet de raisin rouge pressée apres les avoir enlever
}

Config.RaisinBlanc = {
	removeraisinblanc = 2, -- enleve 2 raisin blanc
	addbarque = 1, -- donne 1 barquet de raisin blanc pressée apres les avoir enlever
}

Config.BarqueRouge = {
	removebarquerouge = 2, -- enleve 2 barque de raisin rouge
	addvinrouge = 1, -- donne 1 vin rouge apres avoir enleve 2 barque de raisin rouge 
}

Config.BarqueBlanc = {
	removebarqueblanc = 2, -- enleve 2 barque de raisin blanc
	addvinblanc = 1, -- donne 1 vin blanc apres avoir enleve 2 barque de raisin blanc
}

Config.Bouteille = {
	prixduvinrouge = 10, -- prix par bouteille
	prixduvinblanc = 20, -- prix par bouteille
}

