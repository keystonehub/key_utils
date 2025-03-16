# 5 - API Timestamps

Provides utility functions for handling timestamps, date-time conversions, and calculations in UNIX format.

# Server

## get_timestamp()
Gets the current UNIX timestamp and its formatted date-time string.

### Returns:
- *(table)* - `{ timestamp: number, formatted: string }`.

### Example Usage:
```lua
local ts = TIMESTAMPS.get_timestamp()
print(ts.timestamp, ts.formatted)
```

---

## convert_timestamp(timestamp)
Converts a UNIX timestamp to a human-readable date and time format.

### Parameters:
- **timestamp** *(number)* - The UNIX timestamp to convert.

### Returns:
- *(table)* - `{ date: string, time: string, both: string }`.

### Example Usage:
```lua
local formatted = TIMESTAMPS.convert_timestamp(1700000000)
print(formatted.both)
```

---

## get_current_date_time()
Gets the current date and time in various formats.

### Returns:
- *(table)* - `{ timestamp: number, date: string, time: string, both: string }`.

### Example Usage:
```lua
local now = TIMESTAMPS.get_current_date_time()
print(now.date, now.time)
```

---

## add_days_to_date(date, days)
Adds a specified number of days to a given date.

### Parameters:
- **date** *(string)* - The date in `YYYY-MM-DD` format.
- **days** *(number)* - The number of days to add.

### Returns:
- *(string)* - The new date after adding the specified days.

### Example Usage:
```lua
local future_date = TIMESTAMPS.add_days_to_date("2024-05-01", 7)
print(future_date)
```

---

## date_difference(start_date, end_date)
Calculates the difference in days between two dates.

### Parameters:
- **start_date** *(string)* - The start date in `YYYY-MM-DD` format.
- **end_date** *(string)* - The end date in `YYYY-MM-DD` format.

### Returns:
- *(table)* - `{ days: number }`.

### Example Usage:
```lua
local diff = TIMESTAMPS.date_difference("2024-05-01", "2024-06-01")
print(diff.days)
```

---

## convert_timestamp_ms(timestamp_ms)
Converts a UNIX timestamp in milliseconds to a human-readable date-time format.

### Parameters:
- **timestamp_ms** *(number)* - The UNIX timestamp in milliseconds.

### Returns:
- *(table)* - `{ date: string, time: string, both: string }`.

### Example Usage:
```lua
local formatted = TIMESTAMPS.convert_timestamp_ms(1700000000000)
print(formatted.both)
```