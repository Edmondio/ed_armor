local function T(key)
    return Config.Locales[Config.Language][key] or key
end

-- Variable pour vérifier si monitorArmor est déjà en cours
local armorMonitorRunning = false

-- Optimisation : Déplacer PlayerPedId() hors de la fonction pour éviter les appels répétés
local playerPed = PlayerPedId()

-- Optimisation : Mise en cache du sexe du joueur
local isMale = IsPedMale(playerPed)

-- Fonction pour vérifier si le joueur porte un gilet compatible
local function isWearingCompatibleVest()
    -- Optimisation : Utilisation de la variable mise en cache
    local vestsConfig = isMale and Config.CompatibleVests.male or Config.CompatibleVests.female

    for slotIndex, compatibleDrawables in pairs(vestsConfig) do
        if compatibleDrawables[GetPedDrawableVariation(playerPed, slotIndex)] then
            return true
        end
    end

    return false
end

-- Fonction pour vérifier régulièrement si le joueur porte le bon vêtement
local function monitorArmor()
    while true do
        -- Convertir les minutes en millisecondes
        Citizen.Wait(Config.CheckArmorMinutes * 60 * 1000)

        local currentArmor = GetPedArmour(playerPed)
        if currentArmor > 0 then
            if not isWearingCompatibleVest() then
                SetPedArmour(playerPed, 0)
                armorMonitorRunning = false
                TriggerEvent('ox_lib:notify', {type = 'error', description = T('armor_removed')})
                break
            end
        else
            armorMonitorRunning = false
            break
        end
    end
end

-- Fonction pour démarrer le monitoring de l'armure si nécessaire
local function startArmorMonitoringIfNeeded()
    local currentArmor = GetPedArmour(playerPed)
    if currentArmor > 0 and isWearingCompatibleVest() and not armorMonitorRunning then
        armorMonitorRunning = true
        CreateThread(monitorArmor)
    end
end

-- Événement déclenché lorsque le joueur se connecte
AddEventHandler('playerSpawned', function()
    playerPed = PlayerPedId()
    isMale = IsPedMale(playerPed)
    startArmorMonitoringIfNeeded()
end)

-- Événement déclenché lorsque la ressource démarre ou redémarre
AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    playerPed = PlayerPedId()
    isMale = IsPedMale(playerPed)
    startArmorMonitoringIfNeeded()
end)

-- Optimisation : Fonction unique pour tous les types d'armure
local function AddArmor(item, armor)
    if not isWearingCompatibleVest() then
        TriggerEvent('ox_lib:notify', { type = 'error', description = T('vest_required') })
        return
    end

    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        anim = {
            dict = "clothingtie",
            clip = "try_tie_positive_a",
        },
    }) then 
        SetPedArmour(playerPed, armor)
        TriggerEvent('ox_lib:notify', { type = 'success', description = T('armor_applied') })
        TriggerServerEvent('ed_armor:server:removeItem', item)
        
        if not armorMonitorRunning then
            armorMonitorRunning = true
            CreateThread(monitorArmor)
        end
    else
        TriggerEvent('ox_lib:notify', { type = 'error', description = T('armor_cancelled') })
    end
end

-- Parcourir automatiquement tous les types d'armure définis dans la configuration
for armorType, config in pairs(Config) do
    -- Vérifier si l'élément de configuration est un type d'armure valide
    if type(config) == "table" and config.nameitem and config.level then
        exports(config.nameitem, function(data, slot)
            AddArmor(config.nameitem, config.level)
        end)
    end
end
