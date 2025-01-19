# Blips Module

## Overview

The Blips Module provides an easy-to-use system for creating, managing, and customizing map blips. 
It supports individual blips, categories, and functions such as toggling visibility and updating properties.

## Features

- **Create Blips**: Add single or multiple blips.
- **Manage Categories**: Group blips by category.
- **Dynamic Updates**: Update blip properties or toggle visibility by category.
- **Full Control**: Remove individual blips, categories, or all blips.

## Usage

### Creating a Blip
To create a single blip, use the `create_blip` function and provide a table with blip properties.

#### Example
```lua
local blip_data = {
    coords = vector3(200.0, 300.0, 20.0),
    sprite = 1,
    color = 2,
    scale = 1.0,
    label = 'Example Blip',
    category = 'test'
}

utils.blips.create_blip(blip_data)
```

### Creating Multiple Blips
To create multiple blips at once, use the `create_blips` function with a list of blip data tables.

#### Example
```lua
local blip_list = {
    {
        coords = vector3(100.0, 200.0, 20.0),
        sprite = 2,
        color = 3,
        scale = 0.8,
        label = 'Blip 1',
        category = 'category1'
    },
    {
        coords = vector3(150.0, 250.0, 20.0),
        sprite = 4,
        color = 5,
        scale = 1.2,
        label = 'Blip 2',
        category = 'category2'
    }
}

utils.blips.create_blips(blip_list)
```

### Removing a Blip
To remove a specific blip, use the `remove_blip` function.

#### Example
```lua
utils.blips.remove_blip(blip)
```

### Removing All Blips
To remove all created blips, use the `remove_all_blips` function.

#### Example
```lua
utils.blips.remove_all_blips()
```

### Removing Blips by Category
To remove all blips within a specific category, use the `remove_blips_by_category` function.

#### Example
```lua
utils.blips.remove_blips_by_category('test')
```

### Toggling Blip Visibility by Category
To toggle the visibility of a category of blips, use the `toggle_blips_by_category` function.

#### Example
```lua
utils.blips.toggle_blips_by_category('test', false) -- Hides all blips in the 'test' category
utils.blips.toggle_blips_by_category('test', true)  -- Shows all blips in the 'test' category
```

### Updating Blip Properties
To update a specific property of a blip, use the `update_blip_property` function.

#### Example
```lua
utils.blips.update_blip_property(blip, 'label', 'New Label')
utils.blips.update_blip_property(blip, 'color', 6)
```

### Retrieving Blips

#### Get All Blips
To get all created blips:
```lua
local all_blips = utils.blips.get_all_blips()
```

#### Get Blips by Category
To get all blips in a specific category:
```lua
local category_blips = utils.blips.get_blips_by_category('test')
```

## Example Workflow

**Objective**: Create a category of blips for stores, toggle their visibility, and remove them when needed.

### Workflow
1. **Create Blips**
```lua
local store_blips = {
    {
        coords = vector3(-48.5, -1757.5, 29.4),
        sprite = 52,
        color = 2,
        scale = 0.8,
        label = 'Store 1',
        category = 'stores'
    },
    {
        coords = vector3(25.7, -1345.3, 29.5),
        sprite = 52,
        color = 2,
        scale = 0.8,
        label = 'Store 2',
        category = 'stores'
    }
}

utils.blips.create_blips(store_blips)
```

2. **Toggle Visibility**
```lua
utils.blips.toggle_blips_by_category('stores', false) -- Hides store blips
utils.blips.toggle_blips_by_category('stores', true)  -- Shows store blips
```

3. **Remove Blips**
```lua
utils.blips.remove_blips_by_category('stores')
```