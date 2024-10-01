-- Serveur : fonction pour supprimer l'item
RegisterNetEvent('ed_armor:server:removeItem', function(item)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        -- Supprimer l'item du joueur
        exports.ox_inventory:RemoveItem(source, item, 1)
    end
end)