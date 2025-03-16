# FiveM Utility Library with Common Bridges & UI

![FIVEM_UTILS_THUMB](https://github.com/user-attachments/assets/46ce9970-9a8a-4d10-b19a-2cb4bfaaec18)

A modular and feature-rich Developer Utility Library for FiveM.  
This library is designed to streamline development by providing essential tools, bridges, and a full UI kit—all in one place.

## What is the point of this library?
To simplify scripting with prebuilt systems and framework/UI bridges.
It provides an array of standalone solutions and essential tools to lessen the dev load.

## What happened to `boii_utils`?
Dropped the branding to make it more open, modular, and appealing to a wider range of developers.
The intention is to try and cut down on the excessive amount of bridges needed for servers today.

## Can I use only certain parts?
Yes! The entire library is modular.
There’s no requirement to load everything just require what you need.

# Notable Features:
- **Framework & UI Bridges:** Allows compatibility for multiple resources through one simple API.
    - Framework Bridge by default covers: `esx`, `keystone`, `nd`, `ox`, `qb`, `qbx`. 
    - Notification Bridge by default covers: `default`, `boii`, `esx`, `okok`, `ox`, `qb`
    - DrawText Bridge by default covers: `default`, `boii`, `esx`, `okok`, `ox`, `qb` 

- **Standalone Systems:** Provides a single path over framework specific systems or can provide systems to those without.  
    - Callbacks: Straight forward callback system with optional data sending.
    - Commands: Comes with database based permissions, could be moved to ace however if prefer.
    - Licences: Full in-depth licence system with support for theory, practical, a points system and revoking.
    - XP: Full XP system with experience growth factors and max levels.

- **Unique Scripting Modules:** The modules include most, if not all the functions you would need for creating things like clothing stores, multicharacter, vehicle customs etc.
    - Characters: Contains all functions needed to create a character customiser, clothing store, tattoo store etc, this set of functions was used to create the multi-character and customisation locations within the `keystone` core.
    - Vehicles: Contains virtually all functions that should be needed to create vehicle customisation scripts.

- **UI Elements:** Since one of the more recent rebuilds the library now includes a full UI suite.
    - Action Menu: Intended to be used like a radial menu, supports main and sub menus.
    - Context Menu: Simple straight forward context menu with support for header images, this one is due a big update a.s.a.p.
    - Dialogue: Can be used to create dialogue conversations for players with NPCs.
    - DrawText: Simple drawtext ui with support for timed displays.
    - Notify: Notifications to include; `success`, `error`, `info`, `warning`, `primary`, `secondary`, `light`, `dark`, `critical`, `neutral`.
    - Progress Bar: A regular timed progress bar, not much to say here.
    - Progress Circle: A progress bar? But in a circle?

Much love, and happy scripting!

# All Modules

- **Framework Bridge:** Bridges multiple cores through one api.
- **Notifications Bridge:** Bridges multiple different notification resources through one api.
- **DrawText UI Bridge:** Bridges multiple different drawtext ui resources through one api.
- **Callbacks:** A standalone alternative to framework systems.
- **Characters:** Covers all character customisation relevant function with shared styles data.
- **Commands:** A standalone alternative to framework systems.
- **Debugging:** A couple of useful debugging functions.
- **Entities:** Everything related to entities (npc, vehicles, objects) within the game world.
- **Environment:** Set of function to cover everything enviroment, from current times to simulated seasons.
- **Geometry:** Suite of functions to simplfy geometric calculations in 2d and 3d space.
- **Items:** A standalone usable items registry to provide an alternative to framework specific systems.
- **Keys:** Includes a full static key list and simple function to get and retrieve keys by name or value.
- **Licences:** Full standalone licence system with support for point systems, theory and practical test markers, with support for licence revoking.
- **Maths:** Extends base `math.` functionality with a large suite of additional functions.
- **Player:** Small amount of player related functions such as retrieving the players cardinal direction or running animations on the player with full attached prop support.
- **Requests:** Set of wrapper functions around cfx `Request` functions.
- **Scope:** Small set of functions to handle player scopes.
- **Strings:** Extends base `string.` functionality by adding some addition functions.
- **Tables:** Extends base `table.` functionality by adding some useful functions otherwise not already provided.
- **Timestamps:** Covers everything related to server side timestamps with formatted responses.
- **Vehicles:** Large suite of vehicle related functions, should include everything needed to create a vehicle customs resource.
- **Version:** Provides resource version checking from an externally hosted `.json` file.
- **XP:** Full standalone XP system with support for types, growth factors and max levels.

# UI Previews

![Action Menu, Context Menu, Dialogue, DrawText, Notifications](https://i.ibb.co/PG7vKfPB/image-2025-03-15-004251413.png)
![Progress Bar, Progress Circle](https://i.ibb.co/9HkYnYqh/image-2025-03-15-004440049.png)

# Dependencies

- **[OxMySQL](https://github.com/overextended/oxmysql/releases)**

# Getting Started

The installation of the library is pretty straight forward however detail instructions have been provided within the `docs`. 
You can find installation instructions here: `2-Installation.md`

# Notes

- Currently documentation for the library is limited to the included `docs` files, these will be moved to gitbook in time however for now it will have to do.

# Contributions

Contributions are more than welcome! 
If you would like to contribute to the the utility library, or any other Keystone resource, please fork the repository and submit a pull request or contact through discord.

# 📩 Support

**[Discord](https://discord.gg/SjNhQV2YeN)**

Please do not join the discord expecting instant support. 
This is a **free** and **open source** resource after all. 
