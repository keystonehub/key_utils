# Changes

Entire resource has been rebuilt and restructured from the orginal fivem_utils release.
Everything is now structured in its own module, should hopefully but much easier to work with in the future. 

Some noteable things that have changed are below.
Some files have been removed entirely.

Config settings have been moved to convars as utils cannot be restarted live. 
This is a problem that convars should solve.

Config options for skills/reps/licences have been removed entirely and replaced with a new "data" section.

```diff
# Key:
! Modified
- Removed
+ Added
#

! `exports.fivem_utils:get_utils()` -> `exports.fivem_utils:get_modules()` or `exports.fivem_utils:get_module(module_name)`
! utils.fw.adjust_inventory: `quantity` -> `amount`
! utils.callback -> utils.callbacks
! utils.callback.cb -> utils.callbacks.trigger
! utils.callback.register -> utils.callbacks.register
! connections.lua -> user_registry.lua
! utils.dates -> utils.timestamps
! timestamps.convert_timestamp.formatted -> timestamps.convert_timestamp.both
! timestamps.convert_timestamp_ms.formatted -> " ".both
! utils.player changed all "player" variables to "player_ped"
! utils.environment.get_current_season -> refactor to remove if else logic
! utils.draw removed all the pointless wrapper functions and now just holds custom ones.
! utils.tables.print_table -> utils.tables.print
! utils.tables.table_contains -> utils.tables.contains
! utils.tables.table_compare -> utils.tables.compare

- Conversions section; only covered qb, now the code is inside the qb bridge.
- File database.lua; only had one function for generating unique ids has been moved to `user_registry.lua` can access with `utils.generate_unique_id(...)` server side.
- File debug.lua; was just wrapper functions for type is now all running through 1 function `utils.debug_log`.
- File exports.lua; no longer needed is covered by init.lua
- File config.lua; no longer used check `settings.cfg` for config toggles, skills/rep/licences have moved to new data section.
- utils.ui section no longer used now use new bridge functions listed below.

+ 1 unified utils.debug_log function instead of having 10 debug functions.
+ timestamps.get_current_date_time now returns additional value "both" for date & time formatted together.
+ /data/ now hold skills/rep/licences lists instead of cluttering one config file.
+ Default UI functions: utils.notify, utils.show_drawtext, utils.hide_drawtext, utils.action_menu, utils.context_menu, utils.dialogue, utils.show_progressbar, utils.hide_progressbar, utils.show_circle.
+ New notification bridge section use utils.notifications.send from client or server. Exports are also available.
+ New drawtext ui bridge section use utils.drawtext.show / utils.drawtext.hide from client or server. Exports are also available.
```