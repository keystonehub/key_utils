# 5 - API Maths

The Maths module provides a variety of mathematical functions useful for calculations related to geometry, statistics, and general number manipulation.

# Shared

## round(number, decimals)
Rounds a number to the specified number of decimal places.

### Parameters:
- **number** *(number)* - The number to round.
- **decimals** *(number)* - The number of decimal places to round to.

### Returns:
- *(number)* - The rounded number.

### Example Usage:
```lua
local rounded = MATHS.round(3.14159, 2) -- 3.14
```

---

## calculate_distance(start_coords, end_coords)
Calculates the distance between two 3D coordinate points.

### Parameters:
- **start_coords** *(vector3)* - The starting coordinates.
- **end_coords** *(vector3)* - The ending coordinates.

### Returns:
- *(number)* - The distance between the two points.

### Example Usage:
```lua
local dist = MATHS.calculate_distance(vector3(0, 0, 0), vector3(3, 4, 0)) -- 5.0
```

---

## clamp(val, lower, upper)
Clamps a number within a specified range.

### Parameters:
- **val** *(number)* - The value to clamp.
- **lower** *(number)* - The lower bound of the range.
- **upper** *(number)* - The upper bound of the range.

### Returns:
- *(number)* - The clamped value.

### Example Usage:
```lua
local clamped = MATHS.clamp(15, 0, 10) -- 10
```

---

## lerp(a, b, t)
Linearly interpolates between two numbers.

### Parameters:
- **a** *(number)* - The start value.
- **b** *(number)* - The end value.
- **t** *(number)* - The interpolation factor (0-1).

### Returns:
- *(number)* - The interpolated value.

### Example Usage:
```lua
local value = MATHS.lerp(0, 100, 0.5) -- 50
```

---

## factorial(n)
Calculates the factorial of a number.

### Parameters:
- **n** *(number)* - The number to calculate the factorial of.

### Returns:
- *(number)* - The factorial of the number.

### Example Usage:
```lua
local fact = MATHS.factorial(5) -- 120
```

---

## deg_to_rad(deg)
Converts degrees to radians.

### Parameters:
- **deg** *(number)* - The angle in degrees.

### Returns:
- *(number)* - The angle in radians.

### Example Usage:
```lua
local radians = MATHS.deg_to_rad(180) -- 3.14159
```

---

## rad_to_deg(rad)
Converts radians to degrees.

### Parameters:
- **rad** *(number)* - The angle in radians.

### Returns:
- *(number)* - The angle in degrees.

### Example Usage:
```lua
local degrees = MATHS.rad_to_deg(math.pi) -- 180
```

---

## circle_circumference(radius)
Calculates the circumference of a circle given its radius.

### Parameters:
- **radius** *(number)* - The radius of the circle.

### Returns:
- *(number)* - The circumference of the circle.

### Example Usage:
```lua
local circumference = MATHS.circle_circumference(10) -- 62.8319
```

---

## circle_area(radius)
Calculates the area of a circle given its radius.

### Parameters:
- **radius** *(number)* - The radius of the circle.

### Returns:
- *(number)* - The area of the circle.

### Example Usage:
```lua
local area = MATHS.circle_area(10) -- 314.159
```

---

## triangle_area(p1, p2, p3)
Calculates the area of a triangle given three 2D points.

### Parameters:
- **p1, p2, p3** *(table)* - The three points {x, y}.

### Returns:
- *(number)* - The area of the triangle.

### Example Usage:
```lua
local area = MATHS.triangle_area({x=0, y=0}, {x=5, y=0}, {x=0, y=5}) -- 12.5
```

---

## mean(numbers)
Calculates the mean (average) of a list of numbers.

### Parameters:
- **numbers** *(table)* - A table containing the list of numbers.

### Returns:
- *(number)* - The mean of the numbers.

### Example Usage:
```lua
local avg = MATHS.mean({1, 2, 3, 4, 5}) -- 3.0
```

---

## median(numbers)
Calculates the median of a list of numbers.

### Parameters:
- **numbers** *(table)* - A table containing the list of numbers.

### Returns:
- *(number)* - The median of the numbers.

### Example Usage:
```lua
local med = MATHS.median({1, 3, 3, 6, 7, 8, 9}) -- 6
```

---

## mode(numbers)
Calculates the mode (most frequent value) of a list of numbers.

### Parameters:
- **numbers** *(table)* - A table containing the list of numbers.

### Returns:
- *(number|nil)* - The mode of the numbers, or nil if there is no mode.

### Example Usage:
```lua
local mod = MATHS.mode({1, 2, 2, 3, 4, 4, 4, 5}) -- 4
```

---

## standard_deviation(numbers)
Calculates the standard deviation of a list of numbers.

### Parameters:
- **numbers** *(table)* - A table containing the list of numbers.

### Returns:
- *(number)* - The standard deviation of the numbers.

### Example Usage:
```lua
local std_dev = MATHS.standard_deviation({1, 2, 3, 4, 5}) -- 1.5811
```

---

## linear_regression(points)
Calculates the linear regression coefficients (slope and intercept) for a set of points.

### Parameters:
- **points** *(table)* - A table containing the list of points {x, y}.

### Returns:
- *(table)* - A table with the slope and intercept of the linear regression line.

### Example Usage:
```lua
local regression = MATHS.linear_regression({{x=1, y=2}, {x=2, y=3}, {x=3, y=5}})
print(regression.slope, regression.intercept)
```