Config = {}


Config.CheckArmorMinutes = 1  -- minutes

Config.LightArmor = {
    nameitem = 'light_armor',
    level = 50
}

Config.MediumArmor = {
    nameitem = 'medium_armor',
    level = 75
}

Config.HeavyArmor = {
    nameitem = 'heavy_armor',
    level = 100
}

Config.CompatibleVests = {
    male = { -- Configuration pour les hommes
        [9] = { -- Index 9 représente le kevlar
            [1] = true,
            -- add more here
            
        }
    },
    female = { -- Configuration pour les femmes
        [9] = { -- Index 9 représente le kevlar
            [1] = true,
            -- add more here
            
        }
    }
}

Config.Language = 'fr' -- 'en' for English, 'fr' for French, etc.

Config.Locales = {
    ['en'] = {
        ['vest_required'] = 'You must wear a bulletproof vest to use this armor.',
        ['armor_applied'] = 'Armor successfully applied!',
        ['armor_cancelled'] = 'You cancelled the armor application.',
        ['armor_removed'] = 'Your armor has been removed because you are no longer wearing the compatible vest.'
    },
    ['fr'] = {
        ['vest_required'] = 'Vous devez porter un gilet pare-balles pour utiliser cette armure.',
        ['armor_applied'] = 'Armure appliquée avec succès !',
        ['armor_cancelled'] = 'Vous avez annulé l\'application de l\'armure.',
        ['armor_removed'] = 'Votre armure a été retirée car vous ne portez plus le gilet compatible.'
    }
    -- Add more languages as needed
}
