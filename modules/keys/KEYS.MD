# Keys Module

## Overview

The Keys Module provides some simple untilities for handling key codes. 

## Features

- Retrieve key codes for key names.
- Retrieve key names for key codes.
- Print the full list of supported keys.
- Check if a key is registered in the module.

## Usage

### Getting a Key Code by Name

Use the `get_key` function to retrieve the key code for a specific key name.

#### Example:
```lua
local enter_key_code = utils.keys.get_key('enter')
print('Enter key code:', enter_key_code) -- Example output: 191
```

### Getting a Key Name by Code

Use the `get_key_name` function to find the name of a key by its code.

#### Example:
```lua
local key_name = utils.keys.get_key_name(191)
print('Key name:', key_name) -- Example output: "enter"
```

### Printing the Full Key List

Use the `print_key_list` function to print all keys and their codes to the console.

#### Example:
```lua
utils.keys.print_key_list()
```

### Checking if a Key Exists

Use the `key_exists` function to check if a key name is registered in the module.

#### Example:
```lua
local exists = utils.keys.key_exists('space')
print('Does space exist?', exists) -- Example output: true
```

## Notes

- **Case Sensitivity**: Key names are case-sensitive, so use lowercase when querying.

This module simplifies working with keys in FiveM scripts, especially for input management and custom interactions.