# ros2-nav2-snap

The ros2-nav2 snap provides mapping, localization and navigation capabilities for a robot.

## Build

This package is distributed as a snap and as such is meant to be built using snapcraft:

`SNAPCRAFT_ENABLE_EXPERIMENTAL_EXTENSIONS=1 snapcraft`

## Install

Using the locally built snap, first install it

`snap install --dangerous ros2-teleop-*.snap`

It can also be installed directly from the store:

`snap install ros2-nav2`

## Use

### Slam

This application allows for mapping the environment. It can be launch as follows,

`snap start rosbot-xl-nav.slam`

One can then drive the robot around to create a 2D representation of the environment. Once the area is covered, stop the application with,

`snap stop rosbot-xl-nav.slam`

When the application is stopped, the map is automatically saved at `$SNAP_COMMON/maps/current_map.{png,yaml}`.

The slam application parameters can be configured via the following snap parameter:

    - slam-config (string, default: '')

The slam configuration file can be either edited from the templates available at `$SNAP_COMMON/configuration_templates` and used via:

`snap set ros2-nav2 slam-config="$SNAP_COMMON/configuration_templates/slam_params_template.yaml"`

In case you want to reinitialise the templates, you can simply issue the command `ros2-nav2.reset-config-templates` which will reset all configuration files.
In alternative, a custom file can be placed in `$SNAP_COMMON/config`. Then, it must be configured to the local file as follows:

`snap set ros2-nav2 slam-config="$SNAP_COMMON/config/slam_params.yaml"`

The local configuration should be at a path accessible to the snap such as `$SNAP_COMMON`.
Otherwise, it can be provided by means of a URL. In such case, the snap will download the file and place it in `$SNAP_COMMON/config/slam_params.yaml`.

To configure the slam-config param to a URL:

`snap set ros2-nav2 slam-config="https://raw.githubusercontent.com/robot-repo/slam_params.yaml"`

Note: the URL must be reachable by the snap. When using a URL, the configuration file will be downloaded everytime the app is launched. Therefore a configuration update upstream will be applied with the application relaunch.

### Map saver

After stopping the slam application a map is automatically saved. This is achieved by calling a service to the map saver.
The map saver can be configured via the following snap parameter:

    - map-saver-config (string, default: '')

Without a configuration the map_saver will be called with the default parameters provided upstream.
The parameters that can be configured by means of a yaml file are `free_thresh_default` and `occupied_thresh_default`.

The map-saver configuration file can be either edited from the templates available at `$SNAP_COMMON/configuration_templates` and used via:

`snap set ros2-nav2 map-saver-config="$SNAP_COMMON/configuration_templates/map_saver_template.yaml"`

In case you want to reinitialise the templates, you can simply issue the command `ros2-nav2.reset-config-templates` which will reset all configuration files.
In alternative, a custom file can be placed in `$SNAP_COMMON/config`. Then, it must be configured to the local file as follows:

`snap set ros2-nav2 map-saver-config="$SNAP_COMMON/config/map_saver_params.yaml"`

The local configuration should be at a path accessible to the snap such as `$SNAP_COMMON`.

Otherwise, it can be provided by means of a URL. In such case, the snap will download the file and place it in `$SNAP_COMMON/config/map_saver_params.yaml`.

To configure the map-saver-config param to a URL:

`snap set ros2-nav2 map-saver-config="https://raw.githubusercontent.com/robot-repo/map_saver_params.yaml"`

Note: the URL must be reachable by the snap. When using a URL, the configuration file will be downloaded everytime the app is launched. Therefore a configuration update upstream will be applied with the application relaunch.

### Load map

The map can be either created with the slam application or loaded from URL.

The optional parameter provided to load a map is:

    - map-yaml-path (string, default: '')

The parameter can be set to a local configuration file as follows:

`snap set ros2-nav2 map-yaml-path="$SNAP_COMMON/config/map.yaml"`

The local configuration should be at a path accessible to the snap such as `$SNAP_COMMON`.

Otherwise, the parameter can point to a URL as follow:

`sudo snap set ros2-nav2 map-yaml-path=https://raw.githubusercontent.com/ros-planning/navigation2/main/nav2_bringup/maps/turtlebot3_world.yaml`

When setting this parameter to a URL, the map .yaml file and it's associated image will be downloaded and stored in `$SNAP_COMMON/maps`.
A soft symlink to the downloaded map will be created, so the map will be used by the localization algorithm.
Note: the URL must be reachable by the snap. When using a URL, the configuration file will be downloaded everytime the app is launched. Therefore a configuration update upstream will be applied with the application relaunch.

If SLAM is performed, this parameter will be overwritten and the new generated map used.

### Localization

With the environment mapped, one can make use of the autonomous navigation.
To do so, the localization application has to be started. The localization allows the robot to localize itself in the map provided.
It can be started and stopped respectively with,

`snap start ros2-nav2.localization`

`snap stop ros2-nav2.localization`

The localization application parameters can be configured via the following snap parameter:

    - localization-config (string, default: '')

The localization configuration file can be either edited from the templates available at `$SNAP_COMMON/configuration_templates` and used via:

`snap set ros2-nav2 localization-config="$SNAP_COMMON/configuration_templates/localization_params_template.yaml"`

In case you want to reinitialise the templates, you can simply issue the command `ros2-nav2.reset-config-templates` which will reset all configuration files.
In alternative, a custom file can be placed in `$SNAP_COMMON/config`. Then, it must be configured to the local file as follows:

`snap set ros2-nav2 localization-config="$SNAP_COMMON/config/localization_params.yaml"`

The local configuration should be at a path accessible to the snap such as `$SNAP_COMMON`.

Otherwise, it can be provided by means of a URL. In such case, the snap will download the file and place it in `$SNAP_COMMON/config/localization_params.yaml`.

To configure the localization-config param to a URL:

`snap set ros2-nav2 localization-config="https://raw.githubusercontent.com/robot-repo/localization_params.yaml"`

Note: the URL must be reachable by the snap. When using a URL, the configuration file will be downloaded everytime the app is launched. Therefore a configuration update upstream will be applied with the application relaunch.

### Navigation

The navigation application allows the robot to autonomously move around to a defined goal while avoiding obstacles.
It can be started and stopped respectively with:

`snap start ros2-nav2.navigation`

`snap stop ros2-nav2.navigation`

The navigation application parameters can be configured via the following snap parameter:

    - navigation-config (string, default: '')

The navigation configuration file can be either edited from the templates available at `$SNAP_COMMON/configuration_templates` and used via:

`snap set ros2-nav2 navigation-config="$SNAP_COMMON/configuration_templates/nav2_params_template.yaml"`

In case you want to reinitialise the templates, you can simply issue the command `ros2-nav2.reset-config-templates` which will reset all configuration files.
In alternative, a custom file can be placed in `$SNAP_COMMON/config`. Then, it must be configured to the local file as follows:

`snap set ros2-nav2 navigation-config="$SNAP_COMMON/configuration-templates/navigation_params.yaml"`

The local configuration should be at a path accessible to the snap such as `$SNAP_COMMON`.

Otherwise, it can be provided by means of a URL. In such case, the snap will download the file and place it in `$SNAP_COMMON/config/navigation_params.yaml`.

To configure the navigation-config param to a URL:

`snap set ros2-nav2 navigation-config="https://raw.githubusercontent.com/robot-repo/navigation_params.yaml"`

Note: the URL must be reachable by the snap. When using a URL, the configuration file will be downloaded everytime the app is launched. Therefore a configuration update upstream will be applied with the application relaunch.
