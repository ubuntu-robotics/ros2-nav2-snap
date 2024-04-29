# ros2-nav2-snap

The ros2-nav2 snap provides mapping, localization and navigation capabilities for a robot.

## Build

This package is distributed as a snap and as such is meant to be built using snapcraft:

SNAPCRAFT_ENABLE_EXPERIMENTAL_EXTENSIONS=1 snapcraft

## Install

Using the locally built snap, first install it

`snap install --dangerous ros2-teleop-*.snap`

It can also be installed directly from the store:

`snap install ros2-nav2`

## Use

### Configuration

The snap offers the following functionality:

- Slam
- Localization
- Navigation

Those apps can be configured via snap parameters.
The configuration file can be provided by means of a URL.
In such case, the snap will download the file and place it in `$SNAP_COMMON/config/app_name_params.yaml`.
To configure the config-filepath to a URL:

`snap set ros2-nav2 <app-name>-config="https://raw.githubusercontent.com/robot-repo/<app_name>_params.yaml"`

Note: the URL must be reachable by the snap. When using a URL, the configuration file will be downloaded everytime the app is launched. Therefore a configuration update upstream will be applied with the application relaunch.

Otherwise to configure it to a local configuration file:

`snap set ros2-nav2 <app-name>-config="$SNAP_COMMON/config/<app_name>_params.yaml"`

The local configuration should be at a path accessible to the snap such as $SNAP_COMMON.

Some parameters templates are provided that can be used and mofiedid. They are stored in the `$SNAP_COMMON/configuration_template folder`
and they can be used to create your own configuration file in the $SNAP_COMMON/config folder.

### Slam

The slam application parameters can be configured via the `slam-config` parameter.

The mapping application can be launched as,

`snap start ros2-nav2.slam`

After launching the app, simply drive the robot around until you've mapped the area.
Once finished, stop the mapping with,

`snap stop ros2-nav2.slam`

This will terminate the mapping and automatically
save the map in '${SNAP_COMMON}/maps/new_map.{yaml,png}'.

The new map will be saved with current date and time and a symbolic soft link to current_map.yaml will be created.

### Map saver

The map saver configuration can be configured via the `map-saver-config` parameter.

The map saver comes with default parameters. The available configurable parameters are the following:

- free_thresh_default
- occupied_thresh_default

If a URL or filepath is provided those parameters will be overwritten, otherwise the map_saver defaults will be used.

### Load map

The map can be either created with the slam application or loaded from URL.

The optional parameter provided to load a map is:
snapctl set map-yaml-path!

The parameter can point to a URL as follow:

`sudo snap set ros2-nav2 map-yaml-path=https://raw.githubusercontent.com/ros-planning/navigation2/main/nav2_bringup/maps/turtlebot3_world.yaml`

When setting this parameter to a URL, the map .yaml file and it's associated image will be downloaded and stored in `$SNAP_COMMON/maps`.
A soft symlink to the downloaded map will be created, so the map will be used by the localization algorithm.

### Localization

The localization configuration file can be can be configured via the `localization-config` parameter.

With the environment mapped, one can make use of the autonomous navigation.
To do so, first start the localization application. The localization allows the robot to localize itself in the map provided.
It can be started and stopped respectively with,

`snap start ros2-nav2.localization`
`snap stop ros2-nav2.localization`

### Navigation

The navigation configuration file can be can be configured via the `navigation-config` parameter.


The navigation application allows the robot to autonomously move around to a defined goal while avoiding obstacles. 
It can be started and stopped respectively with,
`snap start ros2-nav2.navigation`
`snap stop ros2-nav2.navigation`

