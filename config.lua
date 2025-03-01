config = config or {}

config.debug = false --- Enable/disable `utils.debug_log()` logs.

config.defferals_messages = true --- Enable/disable defferal update messages.

--- prefix and digits attached to users unique ids.
--- Example Output: 'USER_123ABC'
config.unique_id_prefix = 'USER_'
config.unique_id_digits = 6

--- Modules

--- Choose your framework here.
--- This will enable the correct bridge you require.
--- Default: 'standalone' - This allows the library to run entirely standalone however you will lose access to the framework bridge, skills, licences and rep.
--- Supported Frameworks: 'es_extended', 'ox_core', 'qb-core', 'ND_Core', 'keystone' *(soon to release)*.
--- For details on adding custom support read FRAMEWORK_BRIDGES.MD.
config.framework = 'none'

--- Enable/disable QBCore metadata conversions.
--- If true will get player metadata values and check for any match with utils skills and licences to ensure both sets are synced.
--- If not using qb-core just ignore this the module will bypass.
config.qb_metadata_conversions = false

--- UI Bridges

--- 'default' = utils built in ui.

--- Set your drawtext ui resource choice: 
--- Supported Resources: 'default', 'qb-core', 'es_extended', 'ox_lib', 'okokTextUI', 'boii_ui', *(soon to release)*.
config.drawtext = 'default'

--- Drawtext fallback priority order if 'utils:draw_text_ui' is incorrectly set:
--- If none of the bridge resources are started it will fallback again to 'default'.
config.drawtext_priority = {'qb-core', 'es_extended', 'ox_lib', 'okokTextUI', 'boii_ui'}

--- Set your notification resource choice: 
--- Supported Resources: 'default', 'qb-core', 'es_extended', 'ox_lib', 'okokNotify', 'boii_ui', 'keystone' *(soon to release)*.
config.notifications = 'default'

--- Notifications fallback priority order if 'utils:draw_text_ui' is incorrectly set:
--- If none of the bridge resources are started it will fallback again to 'default'.
config.notifications_priority = {'qb-core', 'es_extended', 'ox_lib', 'okokNotify', 'boii_ui', 'keystone'}
