# 5 - API Version

The Version module provides functionality to check and compare the version of a resource against a remote JSON file hosted on GitHub. 
It helps ensure that the resource is up-to-date.

# Server

---

### check_version(opts)
Checks the version of the current resource against a hosted JSON file containing version information.

#### Parameters:
- **opts** *(table)* - Configuration table with the following fields:
  - **resource_name** *(string, optional)* - The name of the resource to check. Defaults to `GetCurrentResourceName()`.
  - **url_path** *(string)* - The GitHub URL path to the JSON version file.
  - **callback** *(function, optional)* - Callback function that receives:
    - *(boolean)* - `true` if the resource is up-to-date, `false` otherwise.
    - *(string)* - Current version.
    - *(string)* - Latest version.
    - *(string)* - Update notes or status message.

#### Example Usage:
```lua
local opts = {
    resource_name = "my_resource",
    url_path = "mygithub/repository/main/versions.json",
    callback = function(is_up_to_date, current, latest, notes) -- Callback is optional
        if is_up_to_date then
            print("Resource is up to date: " .. current)
        else
            print("Update available! Current: " .. current .. " Latest: " .. latest)
            print("Notes: " .. notes)
        end
    end
}
VERSION.check_version(opts)
```