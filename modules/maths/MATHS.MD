# Maths Module

## Overview

The Maths Module provides utility functions for performing various mathematical operations and calculations. 

## Features

- **Basic Mathematical Operations**: Rounding numbers, clamping values, and linear interpolation.
- **Distance Calculations**: Calculate distances between points in 2D or 3D space.
- **Statistical Functions**: Compute mean, median, mode, and standard deviation.
- **Geometrical Calculations**: Areas of circles and triangles, circumference of circles.
- **Regression Analysis**: Linear regression coefficients for data points.
- **Angle Conversions**: Convert between degrees and radians.

## Usage

### Basic Example

#### Rounding Numbers

```lua
local rounded_value = utils.maths.round(3.14159, 2)
print('Rounded Value:', rounded_value) -- Output: 3.14
```

#### Clamping Values

```lua
local clamped_value = utils.maths.clamp(15, 0, 10)
print('Clamped Value:', clamped_value) -- Output: 10
```

#### Linear Interpolation

```lua
local interpolated_value = utils.maths.lerp(0, 10, 0.5)
print('Interpolated Value:', interpolated_value) -- Output: 5
```

### Advanced Example

#### Distance Calculation

```lua
local start_coords = {x = 0, y = 0, z = 0}
local end_coords = {x = 3, y = 4, z = 0}
local distance = utils.maths.calculate_distance(start_coords, end_coords)
print('Distance:', distance) -- Output: 5
```

#### Statistical Functions

```lua
local numbers = {1, 2, 3, 4, 5}
local mean_value = utils.maths.mean(numbers)
local median_value = utils.maths.median(numbers)
local mode_value = utils.maths.mode(numbers)

print('Mean:', mean_value)    -- Output: 3
print('Median:', median_value) -- Output: 3
print('Mode:', mode_value)    -- Output: nil (no mode)
```

#### Linear Regression

```lua
local points = {
    {x = 1, y = 2},
    {x = 2, y = 4},
    {x = 3, y = 6},
    {x = 4, y = 8}
}
local regression = utils.maths.linear_regression(points)
print('Slope:', regression.slope)         -- Output: 2
print('Intercept:', regression.intercept) -- Output: 0
```

### Geometric Calculations

#### Circle Calculations

```lua
local radius = 5
local circumference = utils.maths.circle_circumference(radius)
local area = utils.maths.circle_area(radius)

print('Circumference:', circumference) -- Output: 31.4159
print('Area:', area)                   -- Output: 78.5398
```

#### Triangle Area

```lua
local p1 = {x = 0, y = 0}
local p2 = {x = 4, y = 0}
local p3 = {x = 0, y = 3}
local area = utils.maths.triangle_area(p1, p2, p3)

print('Triangle Area:', area) -- Output: 6
```