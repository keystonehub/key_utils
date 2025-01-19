# UI Elements

The utility library contains several commonly used small UI elements. 
These are used as default fallback options if the bridges fail, or can be used directly. 

The elements here were original created to replace the current release version of `boii_ui` however the community voted to add them into utils.

## Features

- **Notifications**
- **Progress Bar**
- **Progress Circle**
- **Drawtext UI**
- **Dialogues**
- **Context Menu**
- **Action Menu**

### Notifications

#### Usage

**Function:**
```lua
notify(options)
```

**Parameters:**
- `options.type` *(string)*: Notification type (e.g., `success`, `error`, `info`).
- `options.header` *(string, optional)*: Header text.
- `options.message` *(string)*: The main notification message.
- `options.duration` *(number, optional)*: Display duration in milliseconds (default: 3500).
- `options.style` *(table, optional)*: Custom CSS styles for the notification.

**Examples:**
```lua
utils.notify({
    type = 'success',
    header = 'Notification',
    message = 'This is a success notification.',
    duration = 5000
})
```

**Testing Command:**
```bash
/ui:test_notify
```

**Result:**
Cycles through notification types to showcase different styles and durations.

### Progress Bar.

#### Usage

**Functions:**
```lua
show_progressbar(options)
hide_progressbar()
```

**Parameters:**
- `options.header` *(string)*: Title displayed above the progress bar.
- `options.icon` *(string)*: FontAwesome icon class.
- `options.duration` *(number)*: Duration in milliseconds.

**Examples:**
```lua
utils.show_progressbar({
    header = 'Loading...',
    icon = 'fa-solid fa-spinner',
    duration = 5000
})
```

**Testing Command:**
```bash
/ui:test_progress
```

**Result:**
Shows a progress bar with a spinner icon and custom header.

### Progress Circle

#### Usage

**Functions:**
```lua
show_circle(options)
```

**Parameters:**
- `options.message` *(string)*: Text displayed inside the circle.
- `options.duration` *(number)*: Time in seconds for the circle to complete.

**Examples:**
```lua
utils.show_circle({
    message = 'Processing...',
    duration = 10
})
```

**Testing Command:**
```bash
/ui:test_circle
```

**Result:**
Shows a circular progress animation with the provided message and duration.

### Drawtext UI

#### Usage

**Functions:**
```lua
show_drawtext(options)
hide_drawtext()
```

**Parameters:**
- `options.header` *(string)*: Header text for the drawtext.
- `options.message` *(string)*: Message text displayed below the header.
- `options.icon` *(string, optional)*: FontAwesome icon class.
- `options.keypress` *(string, optional)*: Keypress indicator.
- `options.bar_colour` *(string, optional)*: Bar color in HEX format (default: `#FFFFFF`).
- `options.style` *(table, optional)*: Custom CSS styles for the drawtext.

**Examples:**
```lua
utils.show_drawtext({
    header = 'Enter Building',
    message = 'Press E to enter',
    keypress = 'e',
    bar_colour = '#4dcbc2'
})
```

**Testing Commands:**
```bash
/ui:show_drawtext
/ui:hide_drawtext
```

**Result:**
Displays a drawtext UI element with a customizable message and keypress indicator.

### Dialogues

#### Usage

**Function:**
```lua
open_dialogue(dialogue, npc, coords)
```

**Parameters:**
- `dialogue` *(table)*: Dialogue content, including header, conversation, and options.
- `npc` *(Entity)*: NPC entity initiating the dialogue.
- `coords` *(vector3)*: Coordinates for orienting the player's view.

**Examples:**
```lua
utils.dialogue({
    header = {
        message = 'Quarry Employee',
        icon = 'fa-solid fa-hard-hat'
    },
    conversation = {
        {
            id = 1,
            response = {
                'Welcome to the quarry.',
                'How can I assist you today?'
            },
            options = {
                {
                    icon = 'fa-solid fa-question-circle',
                    message = 'What do you do here?',
                    next_id = 2,
                    should_end = false
                },
                {
                    icon = 'fa-solid fa-door-open',
                    message = 'Goodbye!',
                    should_end = true
                }
            }
        }
    }
}, npc, coords)
```

**Testing Command:**
```bash
/ui:test_dialogue
```

**Result:**
Displays an interactive dialogue system with customizable options and responses.

### Context Menu

#### Usage

**Function:**
```lua
context_menu(menu_data)
```

**Parameters:**
- `menu_data` *(table)*: Menu data, including header and content options.

**Examples:**
```lua
utils.context_menu({
    header = {
        title = 'User Options',
        subtitle = 'Select an action',
        icon = 'fa-solid fa-user'
    },
    content = {
        {
            label = 'Profile',
            icon = 'fa-solid fa-id-card',
            action = { type = 'client', name = 'open_profile' },
            should_close = true
        },
        {
            label = 'Enable Notifications',
            type = 'checkbox',
            state = true,
            on_change = { type = 'client', name = 'toggle_notifications' }
        }
    }
})
```

**Testing Command:**
```bash
/ui:test_context
```

**Result:**
Displays a context menu with customizable options, including checkboxes and actions.

### Action Menu

#### Usage

**Function:**
```lua
action_menu(menu_data)
```

**`action_menu` Parameters:**
- `menu_data` *(table)*: Menu options and submenus.

**Examples:**
```lua
utils.action_menu({
    {
        label = 'Main Menu',
        icon = 'fa-solid fa-bars',
        submenu = {
            {
                label = 'Submenu 1',
                icon = 'fa-solid fa-arrow-right',
                submenu = {
                    {
                        label = 'Option 1',
                        icon = 'fa-solid fa-cog',
                        action_type = 'client_event',
                        action = 'some_event'
                    }
                }
            }
        }
    }
})
```

**Testing Command:**
```bash
/ui:test_action
```

**Result:**
Displays an action menu with nested submenus and customizable options.