# Geometry Module

## Overview

The Geometry Module provides utility functions to perform geometric calculations in both 2D and 3D spaces. 

## Features

- **Distance Calculations:**
  - Calculate distances between points in 2D and 3D.
  - Measure distances from points to planes or lines.

- **Shape and Boundary Analysis:**
  - Check if points are within shapes like circles, rectangles, spheres, and polygons.
  - Detect intersections between lines, circles, and rectangles.

- **Transformations and Rotations:**
  - Rotate points and shapes around pivots.
  - Translate points to local spaces using rotation matrices.

- **Miscellaneous Utilities:**
  - Calculate slopes, angles, and areas of triangles.
  - Work with oriented bounding boxes (OBBs).

## Usage

### Basic Distance Calculation

You can calculate the distance between two points in 2D or 3D using `distance_2d` and `distance_3d`.

#### Example:

```lua
local p1 = {x = 0, y = 0}
local p2 = {x = 3, y = 4}
local distance = utils.geometry.distance_2d(p1, p2)
print("Distance in 2D:", distance) -- Output: 5.0

local p3 = {x = 0, y = 0, z = 0}
local p4 = {x = 3, y = 4, z = 12}
local distance_3d = utils.geometry.distance_3d(p3, p4)
print("Distance in 3D:", distance_3d) -- Output: 13.0
```

### Checking Point Inside Rectangle or Circle

Determine if a point lies inside a rectangle or circle using `is_point_in_rect` or `is_point_in_circle`.

#### Example:

```lua
local point = {x = 5, y = 5}
local rect = {x = 0, y = 0, width = 10, height = 10}
local is_inside_rect = utils.geometry.is_point_in_rect(point, rect)
print("Point inside rectangle:", is_inside_rect) -- Output: true

local circle_center = {x = 0, y = 0}
local circle_radius = 5
local is_inside_circle = utils.geometry.is_point_in_circle(point, circle_center, circle_radius)
print("Point inside circle:", is_inside_circle) -- Output: false
```

### Detecting Line Intersections

Check if two lines intersect using `do_lines_intersect`.

#### Example:

```lua
local line1_start = {x = 0, y = 0}
local line1_end = {x = 10, y = 10}
local line2_start = {x = 0, y = 10}
local line2_end = {x = 10, y = 0}

local intersects = utils.geometry.do_lines_intersect(line1_start, line1_end, line2_start, line2_end)
print("Lines intersect:", intersects) -- Output: true
```

### Rotating Points

Rotate a point around a pivot using `rotate_point_around_point_2d`.

#### Example:

```lua
local point = {x = 1, y = 0}
local pivot = {x = 0, y = 0}
local angle = 90

local rotated_point = utils.geometry.rotate_point_around_point_2d(point, pivot, angle)
print("Rotated Point:", rotated_point.x, rotated_point.y) -- Output: 0.0, 1.0
```

### Translating Points into Local Space

Translate a point into a box’s local coordinate system using `translate_point_to_local_space`.

#### Example:

```lua
local point = {x = 10, y = 10, z = 10}
local box_origin = {x = 5, y = 5, z = 5}
local rotation_matrix = utils.geometry.calculate_rotation_matrix(45, 0, 0)

local local_point = utils.geometry.translate_point_to_local_space(point, box_origin, rotation_matrix)
print("Translated Point:", local_point.x, local_point.y, local_point.z)
```

## Notes

- Only core examples are shown here, refer to the module for additional utilities.