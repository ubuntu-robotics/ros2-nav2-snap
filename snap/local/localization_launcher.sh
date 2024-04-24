#!/usr/bin/bash -e

LOC_CONFIG_FILE="$(snapctl get localization-config)"
MAP_FILE="$(snapctl get map)"
SIMULATION="$(snapctl get simulation)"

DEFAULT_PATH_TO_CONFIG="$SNAP_COMMON/config/localization_params_template.yaml"

CONFIG_FILE=$($SNAP/bin/check_is_url $LOC_CONFIG_FILE $DEFAULT_PATH_TO_CONFIG)

if [ -z "${CONFIG_FILE}" ] ; then
    echo "Config is not a URL"
    CONFIG_FILE=${DEFAULT_PATH_TO_CONFIG}
fi

ros2 launch nav2_bringup localization_launch.py \
  params_file:=${CONFIG_FILE} map:=${MAP_FILE} use_sim_time:=${SIMULATION}
