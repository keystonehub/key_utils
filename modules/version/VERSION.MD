# Version Control Module

## Overview

The Version Control Module enables resources to verify their current version against a centralized JSON version file. 

## Features

- Compares semantic version strings (e.g., `1.0.0`) to identify outdated resources.
- Fetches version information from a remote JSON file.
- Provides detailed update notes if an update is available.
- Supports callback functionality for custom handling of version checks.

## JSON Structure

The remote JSON file should follow this structure:

```json
{
    "resources": {
        "resource_name": {
            "version": "1.0.0",
            "notes": [
                "Update note 1",
                "Update note 2"
            ]
        }
    }
}
```

### Example

```json
{
    "resources": {
        "example_resource": {
            "version": "1.1.0",
            "notes": [
                "Added new features."
            ]
        }
    }
}
```

## Usage

### Checking a Resource's Version

To check the version of a resource, call the `check_version` function with a configuration table. The function will fetch the version data from the specified URL and compare it with the current resource's version.

#### Example

```lua
local opts = {
    resource_name = GetCurrentResourceName(), -- Optional: Defaults to the current resource name.
    url_path = 'username/repository/main/versions.json', -- GitHub raw file path.
    callback = function(is_up_to_date, current_version, latest_version, message)
        if not is_up_to_date then
            print("[Version Control] Update required: " .. message)
        else
            print("[Version Control] " .. message)
        end
    end
}

exports.version.check_version(opts)
```

### Parameters

- **resource_name**: (Optional) The name of the resource to check. Defaults to the current resource name.
- **url_path**: The GitHub raw file path to the JSON version file.
- **callback**: (Optional) A function to handle the result of the version check.

### Callback Parameters

- **is_up_to_date**: A boolean indicating whether the resource is up to date.
- **current_version**: The current version of the resource.
- **latest_version**: The latest version of the resource available in the JSON file.
- **message**: A string containing additional information about the version check.

## Example Workflow

**Objective**: Ensure the resource `example_resource` is up-to-date and print update notes if an update is required.

### Steps

1. Define the JSON version file on GitHub:

```json
{
    "resources": {
        "example_resource": {
            "version": "1.2.0",
            "notes": [
                "Added new animations.",
                "Improved performance."
            ]
        }
    }
}
```

2. Implement the version check in your resource:

```lua
local opts = {
    resource_name = "example_resource",
    url_path = "your_github_username/repository/main/versions.json",
    callback = function(is_up_to_date, current_version, latest_version, message)
        if is_up_to_date then
            print("[Version Control] Resource is up-to-date. Version: " .. current_version)
        else
            print("[Version Control] Update available! Current: " .. current_version .. " Latest: " .. latest_version)
            print("Update Notes: " .. message)
        end
    end
}

utils.version.check(opts)
```

3. Run the script and observe the console for update messages.

## Notes

- Ensure the JSON file is accessible via the provided URL.
- Version comparison supports semantic versioning formats (e.g., `1.0.0`).