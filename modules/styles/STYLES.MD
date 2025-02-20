# Styles Module

## Overview

The Styles Module is a shared utility designed to manage customization data for freemode peds (male and female). 
This includes genetics, barber settings, clothing options, and tattoos. 

## Usage

### Getting Default Styles
The module allows you to retrieve the default styles for reference or resetting purposes.

#### Example
```lua
local default_styles = exports.styles:get_style_defaults()
print(default_styles.m.genetics.mother) -- Output: 0
```

### Retrieving Current Styles
Retrieve the current style data for a specific ped sex (`m` or `f`).

#### Example
```lua
local male_styles = exports.styles:get_style('m')
print(male_styles.clothing.jacket_style) -- Output: 15
```

### Resetting Styles
Reset all styles to their default values. This is useful when switching characters or restoring defaults.

#### Example
```lua
exports.styles:reset_styles()
print(exports.styles:get_style('m').clothing.jacket_style) -- Output: 15 (default value)
```

## Events

### Default Initialization
On resource start, the module automatically initializes the default styles.

#### Example
```lua
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    print('Styles defaults initialized.')
end)
```