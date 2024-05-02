#!/usr/bin/bash -e

is_url() {
    local url="$1"
    if [[ "$url" =~ ^(https?|http):// ]]; then
        return 0
    fi
    return 1
}

get_url() {
    local url="$1"
    local storage_path="$2"
    SYSTEM_WGETRC=$SNAP/etc/wgetrc wget "${url}" -O "${storage_path}"
    if [ $? -eq 0 ]; then
        echo "Config file download successfully at ${storage_path}"
        return 0
    else
        echo "Failed to download config file. Checking if a file already exists."
        if [[ -n "${storage_path}" ]]; then
            echo "Found previously downloaded file, loading it"
            return 0
        else
            echo "No previous file found, exiting"
            return 1
        fi
    fi
}
