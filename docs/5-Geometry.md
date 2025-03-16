# 5 - API Geometry

The Geometry module provides a set of mathematical functions for working with points, distances, angles, and geometric shapes in both 2D and 3D space.

---

# Shared

## distance_2d(p1, p2)
Calculates the distance between two 2D points.

### Parameters:
- **p1** *(table)* - The first point `{x, y}`.
- **p2** *(table)* - The second point `{x, y}`.

### Returns:
- *(number)* - The Euclidean distance between the points.

### Example Usage:
```lua
local dist = GEOMETRY.distance_2d({x = 0, y = 0}, {x = 3, y = 4}) -- Returns 5
```

---

## distance_3d(p1, p2)
Calculates the distance between two 3D points.

### Parameters:
- **p1** *(table)* - The first point `{x, y, z}`.
- **p2** *(table)* - The second point `{x, y, z}`.

### Returns:
- *(number)* - The Euclidean distance between the points.

### Example Usage:
```lua
local dist = GEOMETRY.distance_3d({x = 0, y = 0, z = 0}, {x = 3, y = 4, z = 0}) -- Returns 5
```

---

## midpoint(p1, p2)
Finds the midpoint between two 3D points.

### Parameters:
- **p1** *(table)* - The first point `{x, y, z}`.
- **p2** *(table)* - The second point `{x, y, z}`.

### Returns:
- *(table)* - The midpoint `{x, y, z}`.

### Example Usage:
```lua
local mid = GEOMETRY.midpoint({x = 0, y = 0, z = 0}, {x = 6, y = 6, z = 6})
print(mid.x, mid.y, mid.z) -- Outputs: 3, 3, 3
```

---

## is_point_in_rect(point, rect)
Determines if a point is inside a given 2D rectangle.

### Parameters:
- **point** *(table)* - The point `{x, y}`.
- **rect** *(table)* - The rectangle `{x, y, width, height}`.

### Returns:
- *(boolean)* - True if the point is inside the rectangle, false otherwise.

### Example Usage:
```lua
local inside = GEOMETRY.is_point_in_rect({x = 5, y = 5}, {x = 0, y = 0, width = 10, height = 10}) -- Returns true
```

---

## is_point_in_box(point, box)
Determines if a point is inside a given 3D box.

### Parameters:
- **point** *(table)* - The point `{x, y, z}`.
- **box** *(table)* - The box `{x, y, z, width, height, depth}`.

### Returns:
- *(boolean)* - True if the point is inside the box, false otherwise.

### Example Usage:
```lua
local inside = GEOMETRY.is_point_in_box({x = 5, y = 5, z = 5}, {x = 0, y = 0, z = 0, width = 10, height = 10, depth = 10}) -- Returns true
```

---

## is_point_on_line_segment(point, line_start, line_end)
Determines if a point is on a 2D line segment.

### Parameters:
- **point** *(table)* - The point `{x, y}`.
- **line_start** *(table)* - The start of the line `{x, y}`.
- **line_end** *(table)* - The end of the line `{x, y}`.

### Returns:
- *(boolean)* - True if the point is on the line segment, false otherwise.

### Example Usage:
```lua
local on_line = GEOMETRY.is_point_on_line_segment({x = 2, y = 2}, {x = 0, y = 0}, {x = 4, y = 4}) -- Returns true
```

---

## angle_between_points(p1, p2)
Calculates the angle between two 2D points in degrees.

### Parameters:
- **p1** *(table)* - The first point `{x, y}`.
- **p2** *(table)* - The second point `{x, y}`.

### Returns:
- *(number)* - The angle in degrees.

### Example Usage:
```lua
local angle = GEOMETRY.angle_between_points({x = 0, y = 0}, {x = 1, y = 1})
print(angle) -- Outputs 45
```

---

## rotate_point_around_point_2d(point, pivot, angle_degrees)
Rotates a point around another point in 2D.

### Parameters:
- **point** *(table)* - The point `{x, y}`.
- **pivot** *(table)* - The pivot point `{x, y}`.
- **angle_degrees** *(number)* - The angle in degrees.

### Returns:
- *(table)* - The rotated point `{x, y}`.

### Example Usage:
```lua
local rotated = GEOMETRY.rotate_point_around_point_2d({x = 1, y = 0}, {x = 0, y = 0}, 90)
print(rotated.x, rotated.y) -- Outputs 0, 1
```

---

## is_point_in_circle(point, circle_center, circle_radius)
Determines if a point is inside a circle.

### Parameters:
- **point** *(table)* - The point `{x, y}`.
- **circle_center** *(table)* - The circle center `{x, y}`.
- **circle_radius** *(number)* - The radius of the circle.

### Returns:
- *(boolean)* - True if inside, false otherwise.

### Example Usage:
```lua
local inside = GEOMETRY.is_point_in_circle({x = 3, y = 3}, {x = 0, y = 0}, 5) -- Returns true
```

## do_spheres_intersect(s1_center, s1_radius, s2_center, s2_radius)
Determines if two spheres intersect.

### Parameters:
- **s1_center** *(table)* - The center of the first sphere `{x, y, z}`.
- **s1_radius** *(number)* - The radius of the first sphere.
- **s2_center** *(table)* - The center of the second sphere `{x, y, z}`.
- **s2_radius** *(number)* - The radius of the second sphere.

### Returns:
- *(boolean)* - `true` if the spheres intersect, otherwise `false`.

### Example Usage:
```lua
local intersects = GEOMETRY.do_spheres_intersect({x=0, y=0, z=0}, 5, {x=3, y=3, z=3}, 4)
print("Do spheres intersect?", intersects)
```

---

## is_point_in_convex_polygon(point, polygon)
Determines if a point is inside a convex polygon.

### Parameters:
- **point** *(table)* - The point `{x, y}`.
- **polygon** *(table)* - An array of points defining the polygon `{{x, y}, {x, y}, ...}`.

### Returns:
- *(boolean)* - `true` if the point is inside the polygon, otherwise `false`.

### Example Usage:
```lua
local polygon = {{x=0, y=0}, {x=5, y=0}, {x=5, y=5}, {x=0, y=5}}
local inside = GEOMETRY.is_point_in_convex_polygon({x=3, y=3}, polygon)
print("Point inside polygon?", inside)
```

---

## rotate_point_around_point_2d(point, pivot, angle_degrees)
Rotates a point around another point in 2D space.

### Parameters:
- **point** *(table)* - The point to rotate `{x, y}`.
- **pivot** *(table)* - The pivot point `{x, y}`.
- **angle_degrees** *(number)* - The angle in degrees to rotate the point.

### Returns:
- *(table)* - `{x, y}` The rotated point.

### Example Usage:
```lua
local rotated = GEOMETRY.rotate_point_around_point_2d({x=5, y=5}, {x=0, y=0}, 90)
print("Rotated point:", rotated.x, rotated.y)
```

---

## distance_point_to_plane(point, plane_point, plane_normal)
Calculates the distance from a point to a plane.

### Parameters:
- **point** *(table)* - The point `{x, y, z}`.
- **plane_point** *(table)* - A known point on the plane `{x, y, z}`.
- **plane_normal** *(table)* - The normal vector of the plane `{x, y, z}`.

### Returns:
- *(number)* - The distance from the point to the plane.

### Example Usage:
```lua
local distance = GEOMETRY.distance_point_to_plane({x=3, y=3, z=5}, {x=0, y=0, z=0}, {x=0, y=0, z=1})
print("Distance to plane:", distance)
```

---

## rotation_to_direction(rotation)
Converts a rotation vector to a direction vector.

### Parameters:
- **rotation** *(table)* - A vector `{pitch, yaw, roll}` in degrees.

### Returns:
- *(table)* - A normalized direction vector `{x, y, z}`.

### Example Usage:
```lua
local direction = GEOMETRY.rotation_to_direction({x=0, y=0, z=90})
print("Direction vector:", direction.x, direction.y, direction.z)
```

---

## rotate_box(center, width, length, heading)
Rotates a 3D box around its center.

### Parameters:
- **center** *(table)* - The center of the box `{x, y, z}`.
- **width** *(number)* - The width of the box.
- **length** *(number)* - The length of the box.
- **heading** *(number)* - The heading angle in degrees.

### Returns:
- *(table)* - An array of rotated corner points `{{x, y, z}, {x, y, z}, ...}`.

### Example Usage:
```lua
local corners = GEOMETRY.rotate_box({x=0, y=0, z=0}, 10, 5, 45)
print("Rotated box corners:", corners)
```

---

## calculate_rotation_matrix(heading, pitch, roll)
Calculates a rotation matrix from Euler angles.

### Parameters:
- **heading** *(number)* - The yaw angle in degrees.
- **pitch** *(number)* - The pitch angle in degrees.
- **roll** *(number)* - The roll angle in degrees.

### Returns:
- *(table)* - A 3x3 rotation matrix.

### Example Usage:
```lua
local matrix = GEOMETRY.calculate_rotation_matrix(90, 0, 0)
print("Rotation matrix:", matrix)
```

---

## translate_point_to_local_space(point, box_origin, rot_matrix)
Transforms a point into a local coordinate system.

### Parameters:
- **point** *(table)* - The point `{x, y, z}`.
- **box_origin** *(table)* - The origin `{x, y, z}` of the local space.
- **rot_matrix** *(table)* - A rotation matrix.

### Returns:
- *(table)* - The translated point `{x, y, z}` in local space.

### Example Usage:
```lua
local local_point = GEOMETRY.translate_point_to_local_space({x=5, y=5, z=5}, {x=0, y=0, z=0}, GEOMETRY.calculate_rotation_matrix(90, 0, 0))
print("Local space point:", local_point.x, local_point.y, local_point.z)
```

---

## is_point_in_oriented_box(point, box)
Checks if a point is inside an oriented 3D box.

### Parameters:
- **point** *(table)* - The point `{x, y, z}`.
- **box** *(table)* - A box with `{coords={x, y, z}, width, height, depth, heading, pitch, roll}`.

### Returns:
- *(boolean)* - `true` if the point is inside the box, otherwise `false`.

### Example Usage:
```lua
local inside = GEOMETRY.is_point_in_oriented_box({x=2, y=2, z=2}, {coords={x=0, y=0, z=0}, width=5, height=5, depth=5, heading=45, pitch=0, roll=0})
print("Point inside oriented box?", inside)
```