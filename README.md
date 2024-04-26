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
- Localisation
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

Some parameters templates are provided that can be used and mofiedid. To use them set the config to:

`snap set ros2-nav2 <app-name>-config="$SNAP_COMMON/configuration_templates/<app_name>_params_template.yaml"`

### Slam

The slam application parameters can be configured via the `slam-config` parameter.

The mapping application can be launched as,

`snap start ros2-nav2.slam`

After launching the app, simply drive the robot around until you've mapped the area.
Once finished, stop the mapping with,

`snap stop ros2-nav2.slam`

This will terminate the mapping and automatically
save the map in '${SNAP_COMMON}/maps/new_map.{yaml,png}'.

The new map will be saved with current date and time and a synbolic soft link to current_map.yaml will be created.

### Load map

The map can be either created with the slam application or loaded from URL.

When setting a URL for the map files, .pgm and .yaml file, those will be downloaded and the softlink current_map.yaml
directed to them.

### Localization and navigation

With the environment mapped, one can make use of the autonomous navigation.
To do so, start the localisation and navigation with,

`snap start ros2-nav2.localization`
`snap start ros2-nav2.navigation`
