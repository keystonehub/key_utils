# Timestamps Module

## Overview

The Timestamps Module provides a set of utilities for handling date and time operations.

## What Does the Timestamps Module Do?

- Retrieves the current timestamp and formatted date-time strings.
- Converts UNIX timestamps to human-readable formats.
- Adds or calculates differences between dates.

## How is This Useful?

- **Simplified Date Operations**: Reduces the complexity of working with timestamps and date formats.

## Usage

### Server-Side Functions

#### Get the Current Timestamp

Retrieve the current timestamp along with its formatted date-time representation.

```lua
local timestamp = utils.timestamps.get_timestamp()
print(timestamp.timestamp) -- Example output: 1691234567
print(timestamp.formatted) -- Example output: 2023-10-01 12:00:00
```

#### Convert a UNIX Timestamp

Convert a UNIX timestamp to a human-readable date and time format.

```lua
local converted = utils.timestamps.convert_timestamp(1691234567)
print(converted.date) -- Example output: 2023-10-01
print(converted.time) -- Example output: 12:00:00
print(converted.both) -- Example output: 2023-10-01 12:00:00
```

#### Get the Current Date and Time

Fetch the current date, time, and timestamp in a single call.

```lua
local current_time = utils.timestamps.get_current_date_time()
print(current_time.date) -- Example output: 2023-10-01
print(current_time.time) -- Example output: 12:00:00
print(current_time.both) -- Example output: 2023-10-01 12:00:00
```

#### Add Days to a Date

Add a specified number of days to a given date.

```lua
local new_date = utils.timestamps.add_days_to_date('2023-10-01', 10)
print(new_date) -- Example output: 2023-10-11
```

#### Calculate the Difference Between Dates

Calculate the difference in days between two dates.

```lua
local difference = utils.timestamps.date_difference('2023-10-01', '2023-10-15')
print(difference.days) -- Example output: 14
```

#### Convert a Timestamp in Milliseconds

Convert a UNIX timestamp in milliseconds to a human-readable date and time format.

```lua
local converted = utils.timestamps.convert_timestamp_ms(1691234567000)
print(converted.date) -- Example output: 2023-10-01
print(converted.time) -- Example output: 12:00:00
print(converted.both) -- Example output: 2023-10-01 12:00:00
```

### Shared Functions

#### Get the Current Time

Retrieve the current time for logging or other purposes.

```lua
local current_time = utils.timestamps.get_current_time()
print(current_time) -- Example output: 2023-10-01 12:00:00
```

## Example Workflow

**Objective**: Log a player's current timestamp and convert it into a readable format.

### Workflow

1. **Get the Current Timestamp**:

```lua
local timestamp = utils.timestamps.get_timestamp()
print(('Raw Timestamp: %d | Formatted: %s'):format(timestamp.timestamp, timestamp.formatted))
```

2. **Convert and Format a Timestamp**:

```lua
local converted = utils.timestamps.convert_timestamp(timestamp.timestamp)
print(('Date: %s | Time: %s | Full: %s'):format(converted.date, converted.time, converted.both))
```