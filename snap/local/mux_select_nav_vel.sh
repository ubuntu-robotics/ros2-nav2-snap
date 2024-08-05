#!/usr/bin/bash

ros2 service call /mux/select topic_tools_interfaces/srv/MuxSelect "{topic: /cmd_vel_nav}"
exec $@
