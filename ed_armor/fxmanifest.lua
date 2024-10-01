fx_version 'bodacious'
games {'gta5'}
version '1.0.0'
lua54 'yes'
author 'Edmondio'
description 'Système armure avec plaque'

shared_scripts { 
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    '@es_extended/locale.lua',
    'shared/*.lua',
}

client_scripts {
    'client/*.lua'

}

server_scripts {
    --'@oxmysql/lib/MySQL.lua',
    'server/*.lua',

}