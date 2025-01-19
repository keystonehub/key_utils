--[[
----------------------------------------------
 _  _________   ______ _____ ___  _   _ _____ 
| |/ / ____\ \ / / ___|_   _/ _ \| \ | | ____|
| ' /|  _|  \ V /\___ \ | || | | |  \| |  _|  
| . \| |___  | |  ___) || || |_| | |\  | |___ 
|_|\_\_____| |_| |____/ |_| \___/|_| \_|_____|
----------------------------------------------                                               
           Developer Utility Library
                   V1.0.0              
----------------------------------------------
]]

fx_version 'cerulean'
games { 'gta5', 'rdr3' }

name 'fivem_utils'
version '0.0.0'
description 'Keystone - Developer Utility Library'
author 'keystone'
repository 'https://github.com/keystonehub/fivem_utils'
lua54 'yes'

ui_page 'ui/index.html'
nui_callback_strict_mode 'true'

files {
    'ui/**'
}

shared_script 'init.lua'
server_script 'user_registry.lua' -- Required! user accounts handle permissions for commands etc.. dont remove.

shared_scripts {
    'data/*',
    'modules/**/shared.lua',
}

server_scripts {
    --- oxmysql
    '@oxmysql/lib/MySQL.lua',
    'modules/**/server.lua',
}

client_scripts {
    'modules/**/client.lua',
    'ui/lua/*'
}
