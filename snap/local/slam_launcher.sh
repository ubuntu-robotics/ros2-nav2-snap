#!/usr/bin/bash

SLAM_CONFIG_FILE="$(snapctl get slam-config)"
SIMULATION="$(snapctl get simulation)"

source $SNAP/usr/bin/url_management.sh

if [ -z "${SLAM_CONFIG_FILE}" ] ; then
    echo "No Slam configuration file found."
    exit 1
fi

# it the config-path is a URL we save it to a default local location
# otherwise, it it's a local path we use that.
if is_url "${SLAM_CONFIG_FILE}" ; then
    STORAGE_PATH_TO_CONFIG="$SNAP_COMMON/config/slam_params.yaml"
    if get_url "${SLAM_CONFIG_FILE}" "${STORAGE_PATH_TO_CONFIG}"; then
        CONFIG_FILE=${STORAGE_PATH_TO_CONFIG}
    fi
else
    echo "Config is not a URL, setting local path"
    CONFIG_FILE=${SLAM_CONFIG_FILE}
fi

${SNAP}/ros2 launch nav2_bringup slam_launch.py \
  params_file:=${CONFIG_FILE} use_sim_time:=${SIMULATION}
