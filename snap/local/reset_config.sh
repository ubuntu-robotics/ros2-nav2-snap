#!/bin/sh -e

# Make sure the folder exists
mkdir -p $SNAP_COMMON/configuration_templates

cp $SNAP/usr/share/ros2-nav2/configuration_templates/*.yaml $SNAP_COMMON/configuration_templates/.
