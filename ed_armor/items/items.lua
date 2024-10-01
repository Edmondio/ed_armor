['light_armor'] = {
    label = 'Armure légère',
    weight = 500,
    stack = true,
    close = true,
    description = 'Armure légère qui donne 50 points d\'armure',
    client = {
        add = function(item)
            item.metadata.armorValue = 50
        end,
    },
}

['medium_armor'] = {
    label = 'Armure moyenne',
    weight = 1000,
    stack = true,
    close = true,
    description = 'Armure moyenne qui donne 75 points d\'armure',
    client = {
        add = function(item)
            item.metadata.armorValue = 75
        end,
    },
}

['heavy_armor'] = {
    label = 'Armure lourde',
    weight = 1500,
    stack = true,
    close = true,
    description = 'Armure lourde qui donne 100 points d\'armure',
    client = {
        add = function(item)
            item.metadata.armorValue = 100
        end,
    },
}