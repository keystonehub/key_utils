--[[
----------------------------------------------
 _  _________   ______ _____ ___  _   _ _____ 
| |/ / ____\ \ / / ___|_   _/ _ \| \ | | ____|
| " /|  _|  \ V /\___ \ | || | | |  \| |  _|  
| . \| |___  | |  ___) || || |_| | |\  | |___ 
|_|\_\_____| |_| |____/ |_| \___/|_| \_|_____|
----------------------------------------------                                               
               Utility Library
                   V1.1.0              
----------------------------------------------
]]

fx_version "cerulean"
games { "gta5", "rdr3" }

name "keystone"
version "1.1.0"
description "Keystone - Utility Library with Common UI and Bridges"
author "Case"
repository "https://github.com/keystonehub/key_utils"
lua54 "yes"

fx_version "cerulean"
game "gta5"

ui_page 'ui/index.html'
nui_callback_strict_mode 'true'

files {
    'ui/**'
}

server_script "@oxmysql/lib/MySQL.lua" -- OxMySQL

shared_script "init.lua"
server_script "users.lua" -- Required! user accounts handle permissions for commands etc.. dont remove.

-- shared_script "@ox_lib/init.lua" -- Uncomment if using ox_lib or ox_core

shared_scripts {
    "lib/data/*.lua",
    "lib/modules/**/*.lua",
    "lib/bridges/**/*.lua",
    "lib/events/*.lua",
    "lib/threads/*.lua",
    "test.lua"
}

client_scripts {
    'ui/lua/*'
}
