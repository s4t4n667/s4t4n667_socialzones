fx_version 'cerulean'
game 'gta5'
use_experimental_fxv2_oal 'yes'
lua54 'yes'

author 'Asgaard Developments | s4t4n667'
description 'Zone-based social payment script'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'resource/client.lua',
    '@PolyZone/client.lua'
}

server_scripts {
    'resource/server.lua'
}

files {
    'locales/*.json',
}