# 5 - API UI Bridges

The UI bridges provide a unified API for handling DrawText UI and Notifications across multiple FiveM resources. 
These bridges detect and route function calls, allowing scripts to work across different environments without modification.

# DrawText UI

The DrawText UI bridge standardizes interaction UI elements across various drawtext resources.

## Server

### show_drawtext(source, options)
Displays drawtext for a specific client.

```lua
local DRAWTEXT = require("modules.drawtext")
DRAWTEXT.show(1, { message = "Hello, player!", icon = "info" })
```

### hide_drawtext(source)
Hides the drawtext UI for a specific client.

```lua
DRAWTEXT.hide(1)
```

## Client

### show_drawtext(options)
Displays drawtext on the client.

```lua
DRAWTEXT.show({ message = "Press E to interact", icon = "info" })
```

### hide_drawtext()
Hides the drawtext UI on the client.

```lua
DRAWTEXT.hide()
```

# Notifications

The Notifications bridge standardizes how notifications are handled across different UI systems.

## Server

### send_notification(source, options)
Sends a notification to a specific client.

```lua
local NOTIFY = require("modules.notifications")
NOTIFY.send(1, { type = "info", message = "You received $500", duration = 5000 })
```

## Client

### send_notification(options)
Displays a notification on the client.

```lua
NOTIFY.send({ type = "success", message = "Mission Complete!", duration = 3000 })
```