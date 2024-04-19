#!/bin/sh -e

# Make sure the folder exists
mkdir -p $SNAP_COMMON/config

cp $SNAP/usr/share/ros2-nav2/config/*.yaml $SNAP_COMMON/config/.
