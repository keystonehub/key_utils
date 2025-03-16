# UTILS V1.1.0

Another full rebuild, back to how I prefer to do things. 
Everything works as it should some stuff has been trimmed out again to reduce the overall size of the library and elinate some useless functions.

Some noteable things have changed from 1.0. builds, these are listed below.

Has been renamed from `fivem_utils` to `key_utils` hopefully CFX will actually approve the post now...

```diff
### Key
! Modified
+ Added
- Removed
###

# Initalization
! Changed initialization process, no longer requires priority loading.
! Resource settings added into new ENV metatable.
+ cfx_require function to globally overwrite require for use on cfx platforms.
- Removed old module loading functions

# Framework Bridges
! Changed how framework core files are stored, now single files split by duplicity version.
+ Added new add_item and remove_item functions to keep things more straight forward.
+ Added new add_balance and remove_balance functions.
- Removed old adjust_inventory function.
- Removed old adjust_balance function.
- Remove get_insert_params was not being used.

# All Modules
! Changed how modules are loaded all are now single file split by duplicity version.
! exports.key_utils:get_module(...) -> exports.key_utils:require(...)
! Modified functions to increase spacing try to improve on readability for people.

# Debug
! debug_log changed to debug_print and now accessible through debug.print instead of debug.debug_log.

# Character Creation
! Changed from character_creation -> characters
+ Added all styles functions into this module to keep things organised a little better.

# Licences
! Full system rebuild.
+ Added support for points, max points and revocable licences.

# XP 
+ New module to replace old skills + rep, no need to have two duplicated systems when can diffrentiate by type.

# Removed Modules
- Removed blips module; honestly? i keep forgeting it exists and do blips internally anyway.
- Removed buckets module wasnt being used.
- Removed developer module, wasnt being used, only provided some on screen drawtext functions nothing really all that useful.
- Removed draw module, who uses draw functions anyway eww?
- Removed zones module wasnt being used anywhere and have plans for a better one when have the time.
- Removed styles module and combined with characters module.
- Removed peds module, barely being used can just be done internally.
- Removed skills + reputation modules replaced with new `xp` module.
```