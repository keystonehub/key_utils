# Strings Module

## Overview

The Strings Module provides utility functions to simplify some common string manipulations.

## Features

- **Capitalize**: Capitalizes the first letter of each word in a string.
- **Random String**: Generates a random alphanumeric string of a given length.
- **Split**: Splits a string into a table based on a specified delimiter.
- **Trim**: Trims whitespace from the beginning and end of a string.

## Usage

### Capitalize a String

Use the `capitalize` function to capitalize the first letter of each word in a string.

#### Example

```lua
local capitalized = exports.strings:capitalize('hello world')
print(capitalized) -- Output: 'Hello World'
```

### Generate a Random String

Use the `random_string` function to generate a random alphanumeric string of a specified length.

#### Example

```lua
local random_str = exports.strings:random_string(10)
print(random_str) -- Output: A random 10-character string, e.g., 'aB3dE5FgHi'
```

### Split a String

Use the `split` function to divide a string into parts based on a specified delimiter.

#### Example

```lua
local parts = exports.strings:split('a,b,c', ',')
print(parts[1], parts[2], parts[3]) -- Output: 'a', 'b', 'c'
```

### Trim Whitespace

Use the `trim` function to remove leading and trailing whitespace from a string.

#### Example

```lua
local trimmed = exports.strings:trim('  hello  ')
print(trimmed) -- Output: 'hello'
```