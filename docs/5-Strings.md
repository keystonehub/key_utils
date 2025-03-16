# 5 - API Strings

Shared string functions to extend native `string.` functionality.

# Shared

## capitalize(str)
Capitalizes the first letter of each word in a string.

### Parameters:
- **str** *(string)* - The string to capitalize.

### Returns:
- *(string)* - The capitalized string.

### Example Usage:
```lua
local result = STRINGS.capitalize("hello world")
print(result) -- Output: "Hello World"
```

---

## random_string(length)
Generates a random string of a specified length.

### Parameters:
- **length** *(number)* - The length of the random string.

### Returns:
- *(string)* - The generated random string.

### Example Usage:
```lua
local result = STRINGS.random_string(10)
print(result) -- Output: "A1b2C3d4E5"
```

---

## split(str, delimiter)
Splits a string into a table based on a given delimiter.

### Parameters:
- **str** *(string)* - The string to split.
- **delimiter** *(string)* - The delimiter to split by.

### Returns:
- *(table)* - A table of split segments.

### Example Usage:
```lua
local result = STRINGS.split("apple,banana,grape", ",")
for _, v in ipairs(result) do
    print(v)
end
-- Output:
-- apple
-- banana
-- grape
```

---

## trim(str)
Trims whitespace from the beginning and end of a string.

### Parameters:
- **str** *(string)* - The string to trim.

### Returns:
- *(string)* - The trimmed string.

### Example Usage:
```lua
local result = STRINGS.trim("   hello world   ")
print(result) -- Output: "hello world"
```