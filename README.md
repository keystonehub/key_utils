# FiveM Utility Library with Common Bridges & UI

## 🌍 Overview

A modular and feature-rich utility library for FiveM.
The library started as `boii_utils` however after some feedback I decided to drop the `boii_` branding entirely, refactor and release as something more open.
Hopefully being detached from the BOII brand will increase the usage appeal and we can cut down on needing 20 bridges to play a server.

This library includes pretty much everything a developer should need for creating fivem resources, if it doesnt, it can be added.

Some notable modules: 

- **Framework & Common Resource Bridges:** Currently covers "es_extended", "ox_core", "qb-core", "keystone" or can be ran standalone, also includes a notification bridge, and a drawtext ui bridge covering a decent amount of commonly used resources.
- **Standalone Systems:** Contains standalone licence, skills & reputation systems this gives an alternate method to framework options, or a method to those without.
- **Character Creation & Customisation:** Should cover everything a developer needs to create clothing stores, tattoos, barbers or basically anything related to character creation and customisation. These have been used two build two fully functioning multicharacter resources so you should be more than covered.
- **Vehicle Customisation:** Should cover everything to create vehicle stores and customs, these have not been used in a release resource yet but they do work.

All modules have been listed below along with the new included UI elements.
For more information on how the modules or ui elements work refer to the `.MD` files throughout the library.

Much love, and happy scripting!

## 🌐 Modules

Bridges: 
- **Frameworks:** Covers all core client and server side functions needed for bridging "es_extended", "ox_core", "qb-core", "keystone" *(unreleased e.t.a a.s.a.p)* 
- **Notifications:** Covers commonly used notification resources. Can be accessed from both server and client side through exports or utils functions.
- **Drawtext UI:** Covers commonly used drawtext ui resources. Can be accessed from both server and client side through exports or utils functions.

The Rest:
- **Blips:** Handles creating and managing blips on the client.
- **Buckets:** Handles server routing buckets.
- **Callbacks:** Standalone callback system, replaces the need for framework specific callbacks.
- **Character Creation:** Covers anything related to character creation and customisation.
- **Commands:** Standalone command system, replaces the need for framework specific commands.
- **Cooldowns:** Cooldown system to provide a easy way for setting player or resource wide cooldowns.
- **Developer:** Small selection of functions to display useful game information on screen.
- **Draw:** Handles FiveM native "Draw" functions.
- **Entities:** Handles getting closest entities to players *(vehicles, peds)* and more.
- **Environment:** Small section with some functions to provide details on the environment such as current season.
- **Geometry:** Simplifies some geometric calculations in both 2D and 3D spaces.
- **Items:** Standalone usable items registery. The framework bridge does wrap core systems however this provides an alternatie if required.
- **Keys:** Handles retrieving keys by key codes or a string name.
- **Licences:** Standalone licence system replaces the need for managing licences across frameworks. Refer to framework bridges on data conversion to sync data.
- **Maths:** Handles common mathematical functions.
- **Peds:** Handles creating and managing peds on the client.
- **Player:** Handles some specific client side actions on the player ped, e.g, getting the street name, or running animations on them.
- **Reputations:** Standalone reputation system replaces the need for managing reps across frameworks. Refer to framework bridges on data conversion to sync data.
- **Requests:** Handles all FiveM native "Request" functions.
- **Scope:** Handles player scopes and triggering events on scoped players.
- **Skills:** Standalone skills system replaces the need for managing skills across frameworks. Refer to framework bridges on data conversion to sync data.
- **Strings:** Handles some common used string functions.
- **Styles:** Full storage of a players current "style" data, this is used in tandem with the "Character Creation" module.
- **Tables:** Handles common used table functions.
- **Timestamps:** Handles retrieving and converting timestamps in a variety of ways.
- **Vehicles:** Handles all vehicles details, checks and customisation options.
- **Version:** Handles resource version checking with console logs from an external hosted .json file.
- **Zones:** Handles creating and managing "zones" in the world, e.g, "safe zones".

## 🎨 UI Elements

![image](https://media.discordapp.net/attachments/1330607993863143508/1330630894834421821/image.png?ex=678eae17&is=678d5c97&hm=56825f290d1696ad3590ec1dc0d3873f46ab3d6921f9739bc632f977a76230ac&=&format=webp&quality=lossless&width=1202&height=676)
![image](https://media.discordapp.net/attachments/1330607993863143508/1330631449614745743/image.png?ex=678eae9b&is=678d5d1b&hm=118d8b14f93b63233aeabe81c4aceea4df1f50d6e704918c5e0e39bd078038cf&=&format=webp&quality=lossless&width=1202&height=676)

- **Action Menu:** Provides alternate functionality to a radial menu, works similarly, main menus with sub menus.

![image](https://media.discordapp.net/attachments/1330607993863143508/1330608050192646264/spaces2FHfd391cB6wDC8S3yHcie2Fuploads2FyooG6MHUHRrLUzeBZDaI2Fimage.png?ex=678e98d0&is=678d4750&hm=3cc51347d7a9dd7dcaff3ecd2c51c13ec2a3ad09ce475b3c806987cdbd48657e&=&format=webp&quality=lossless)

- **Context Menu:** This was a quick addition before release it will be improved.

![image](https://media.discordapp.net/attachments/1330607993863143508/1330608803670003893/image.png?ex=678e9984&is=678d4804&hm=cf3298a17229394c0f1c9bd6a5986f38345a9b9f6745769e0ec76386e42a5be1&=&format=webp&quality=lossless)

- **Dialogue:** Redesign and refactor to my old boii_ui dialogue system.

![image](https://media.discordapp.net/attachments/1330607993863143508/1330608151996661860/spaces2FHfd391cB6wDC8S3yHcie2Fuploads2FB8pGKOcyAl9Pvrf4CBmu2Fimage.png?ex=678e98e8&is=678d4768&hm=3c4c1b97b36c660633ef47160f6a88aee7e152ff08b4d454d05d4b77ee4b2b14&=&format=webp&quality=lossless)

- **Drawtext UI:** Supports regular key display and presses or can be used with an icon and progress bar for timed indicators.

![image](https://media.discordapp.net/attachments/1330607993863143508/1330608119566438410/spaces2FHfd391cB6wDC8S3yHcie2Fuploads2FlWEcFv3AwvdK09GDZHPv2Fimage.png?ex=678e98e1&is=678d4761&hm=df6935d07a03ab1618def7e8235606885538e557bb068490866478479c1f0050&=&format=webp&quality=lossless)

- **Notifications:** Available types: success, error, info, warning, primary, secondary, light, dark, critical, neutral.

![image](https://media.discordapp.net/attachments/1330607993863143508/1330608014868222002/spaces2FHfd391cB6wDC8S3yHcie2Fuploads2FwZ6HF7GJIyhDgGW3SJWB2Fimage.png?ex=678e98c8&is=678d4748&hm=d0e9a4c94d9da8e82b109578836ae1a319f847dcd0cee72e68e33add52294c7e&=&format=webp&quality=lossless)

- **Progress Bar:** Simple no fuss progress bar.

![image](https://media.discordapp.net/attachments/1330607993863143508/1330608095931535421/spaces2FHfd391cB6wDC8S3yHcie2Fuploads2F4OsVmxvaR2v9ujnsCiqb2Fimage.png?ex=678e98db&is=678d475b&hm=cf0cc95cfb5a571863d972ee3add4c2d16c8ef99725b9edafe96304d18017835&=&format=webp&quality=lossless)

- **Progress Circle:** This has been used built into some recent boii releases however now its here and freely available to use.

![image](https://media.discordapp.net/attachments/1330607993863143508/1330608075115335700/spaces2FHfd391cB6wDC8S3yHcie2Fuploads2FSiAAxLROrR9KFkmRJV6W2Fimage.png?ex=678e98d6&is=678d4756&hm=838a6faf894f1795b9b2e901ea98dfd29912f3c1dc212310dea4b8794cee220c&=&format=webp&quality=lossless)

## 💹 Dependencies

- **[OxMySQL](https://github.com/overextended/oxmysql/releases/tag/v2.12.0)**

Framework bridges of course require a supported framework core.

## 📦 Getting Started

Prior to installation make sure you have all of the dependencies listed above in your server.

1. Download the latest release version from: **[GitHub](https://github.com/keystonehub/fivem_utils/releases)**

2. Add any licences, reputations or skills you want the utils systems to cover into the `data/` files.

3. Add the included `.sql` files into your database.
- `REQUIRED.sql` is as the name suggests **required** this is the user accounts tables used by utils.
- `sqls/frameworks` contains framework specific tables to support the utils licence, rep, and skills systems, these are optional if you do not use the systems.

4. Customise utils settings inside `utils_settings.cfg`.
- These are convars, you should copy these into your `server.cfg` 
- Or move the file into your servers root *(where your server.cfg is)* and add the following line into your `server.cfg` 
```
exec utils_settings.cfg
```

5. Add `fivem_utils` resource into your server resources.

6. Add `ensure fivem_utils` into your `server.cfg`

Now you are good to go!
For information on how each module works read their `.MD` file.
For importing them into your projects read `MODULES.MD`.

## 📝 Notes

- No official documentation for this version currently exists, every module contains its own `.MD` file with information on how it works. You can also view the **[boii_utils documentation](https://docs.boii.dev/fivem/free-resources/boii_utils)** however some things have changed. Included in the resource is a `notes.md` file that has some brief notes on what was changed.
- If you are migrating over from `boii_utils` make sure you read the included `notes.md` file.
- All functions should still work as they did in the old version, they have not all been tested in this version, if any do not work get in touch and they will be fixed.

## 🤝 Contributions

Contributions are more than welcome! 
If you would like to contribute to the the utility library, or any other Keystone resource, please fork the repository and submit a pull request or contact through discord.

## 📝 Documentation

A official documentation section has not been setup for Keystone yet. 
To compensate for this every module contains a `.MD` file with instructions about the module.

Please make sure to read these if you are unsure.
If they could be improved, let us know and they can be updated.

## 📩 Support

Support for Keystone resources is primarily handled by the community.
Please do not join the discord expecting instant support. 

This is a **free** and **open source** resource after all. 

**[Discord](https://discord.gg/SjNhQV2YeN)**
