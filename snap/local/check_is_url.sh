#!/usr/bin/bash -e

CONFIG_PARAM_PATH=$1
DEFAULT_PATH_TO_CONFIG=$2

is_url() {
    local url="$1"
    if [[ "$url" =~ ^(https?|http):// ]]; then
        return 0
    fi
    return 1
}

if is_url "${CONFIG_PARAM_PATH}" ; then
    SYSTEM_WGETRC=$SNAP/etc/wgetrc wget "${CONFIG_PARAM_PATH}" -O "${DEFAULT_PATH_TO_CONFIG}"
    if [ $? -eq 0 ]; then
        CONFIG_PARAM_PATH="${DEFAULT_PATH_TO_CONFIG}"
        echo $CONFIG_PARAM_PATH
    else
        echo "Failed to download config file. Checking if a file already exists:"
        if [[ -n "${DEFAULT_PATH_TO_CONFIG}" ]]; then
          CONFIG_PARAM_PATH="${DEFAULT_PATH_TO_CONFIG}"
          echo $CONFIG_PARAM_PATH
        else
          exit 1
        fi
    fi
fi
