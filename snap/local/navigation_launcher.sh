#!/usr/bin/bash

NAV_CONFIG_FILE="$(snapctl get navigation-config)"
SIMULATION="$(snapctl get simulation)"

if [ -z "${NAV_CONFIG_FILE}" ] ; then
    echo "No navigation configuration file found."
    exit 1
fi

source $SNAP/usr/bin/url_management.sh

# it the config-path is a URL we save it to a default local location
# otherwise, it it's a local path we use that.
if is_url "${NAV_CONFIG_FILE}" ; then
    STORAGE_PATH_TO_CONFIG="$SNAP_COMMON/config/nav2_params.yaml"
    if get_url "${NAV_CONFIG_FILE}" "${STORAGE_PATH_TO_CONFIG}"; then
        CONFIG_FILE=${STORAGE_PATH_TO_CONFIG}
    fi
else
    echo "Config is not a URL, setting local path"
    CONFIG_FILE=${NAV_CONFIG_FILE}
fi

ros2 launch nav2_bringup navigation_launch.py \
  params_file:=${CONFIG_FILE} use_sim_time:=${SIMULATION}
