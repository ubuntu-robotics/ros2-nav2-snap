#!/usr/bin/bash -e

LOC_CONFIG_FILE="$(snapctl get localization-config)"
MAP_FILE="$(snapctl get map)"
SIMULATION="$(snapctl get simulation)"

source $SNAP/usr/bin/url_management.sh

if [ -z "${LOC_CONFIG_FILE}" ] ; then
    echo "No localization configuration file found."
    exit 1
fi

if [ -z "${MAP_FILE}" ]; then
    echo "No current_map.yaml found, run slam to generate one or load one via URL"
    exit 1
fi

# it the config-path is a URL we save it to a default local location
# otherwise, it it's a local path we use that.
if is_url "${LOC_CONFIG_FILE}" ; then
    STORAGE_PATH_TO_CONFIG="$SNAP_COMMON/config/localization_params.yaml"
    if get_url "${LOC_CONFIG_FILE}" "${STORAGE_PATH_TO_CONFIG}"; then
        CONFIG_FILE=${STORAGE_PATH_TO_CONFIG}
    fi
else
    echo "Config is not a URL, setting local path"
    CONFIG_FILE=${LOC_CONFIG_FILE}
fi

ros2 launch nav2_bringup localization_launch.py \
  params_file:=${CONFIG_FILE} map:=${MAP_FILE} use_sim_time:=${SIMULATION}
