# Callbacks Module

## Overview

The Callbacks Module provides a standalone system for handling client-to-server and server-to-client callbacks. 
It removes the need for writing framework-specific implementations..

For further details or assistance, refer to the documentation or contact support via Discord.

## What is a Callback?

A callback is a way to send data and receive a response between the client and server. 
The Callbacks Module provides a consistent interface (`utils.callbacks` or exports) to handle these interactions without requiring custom logic for different frameworks.

## What Does the Callbacks Module Do?

- Allows servers to register callbacks to process client requests.
- Allows clients to trigger server callbacks and handle the response.
- Generates and manages unique callback IDs to ensure reliable communication.

## How is This Useful?

- **Framework Independence**: Write callbacks once, and they will work regardless of the framework.
- **Simplified Communication**: Easily send and receive data between the client and server.
- **Error Handling**: Logs missing or unregistered callbacks for debugging.

## Usage

### Client-Side

1. **Trigger a Server Callback**:

   ```lua
   utils.callbacks.trigger('example_callback', { key = 'value' }, function(response)
       print('Server response:', response)
   end)
   ```

2. **Exported Function**:
   - `trigger_callback(name, data, cb)`
     - `name`: The event name of the callback.
     - `data`: Data to send to the server.
     - `cb`: Function to handle the server response.

### Server-Side

1. **Register a Server Callback**:

   ```lua
   utils.callbacks.register('example_callback', function(source, data, cb)
       print('Received data:', data)
       cb({ success = true, message = 'Callback executed successfully.' })
   end)
   ```

2. **Exported Function**:
   - `register_callback(name, cb)`
     - `name`: The name of the callback event.
     - `cb`: Function to process the callback and send a response.

### Example Workflow

- **Client** triggers a callback:

   ```lua
   utils.callbacks.trigger('get_player_data', { player_id = 1 }, function(response)
       print('Player data:', response)
   end)
   ```

- **Server** handles the callback:

   ```lua
   utils.callbacks.register('get_player_data', function(source, data, cb)
       local player_data = { id = source, name = 'John Doe', rank = 'admin' }
       cb(player_data)
   end)
   ```

- **Client** receives and processes the server response.