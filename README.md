# ros2-nav2-snap

The ros2-nav2 snap provides mapping, localization and navigation capabilities for a robot.

## Build

This package is distributed as a snap and as such is meant to be built using snapcraft:

`SNAPCRAFT_ENABLE_EXPERIMENTAL_EXTENSIONS=1 snapcraft`

## Install

Using the locally built snap, first install it with:

`snap install --dangerous ros2-nav2-*.snap`

It can also be installed directly from the store with:

`snap install ros2-nav2`

## Use

### Configuration

The ros2-nav2 snap is designed as a general package that offers navigation functionality for robots.
To ensure maximum flexibility for users, it is intentionally provided without any preset configurations.

The ros2-nav2 snap must be configured by means of snap parameters.
The available configuration parameters are listed below:

- [simulation](https://github.com/ubuntu-robotics/ros2-nav2-snap/blob/main/snap/hooks/install#L10) (string, default: "False")
- [slam-config](https://github.com/ubuntu-robotics/ros2-nav2-snap/blob/main/snap/hooks/install#L11) (string, default: "")
- [map-saver-config](https://github.com/ubuntu-robotics/ros2-nav2-snap/blob/main/snap/hooks/install#L16) (string, default: "")
- [map-yaml-path](https://github.com/ubuntu-robotics/ros2-nav2-snap/blob/main/snap/hooks/install#L15) (string, default: "")
- [map](https://github.com/ubuntu-robotics/ros2-nav2-snap/blob/main/snap/hooks/install#L14) (string, default="${SNAP_COMMON}/maps/current_map.yaml")
- [localization-config](https://github.com/ubuntu-robotics/ros2-nav2-snap/blob/main/snap/hooks/install#L13) (string, default: "")
- [navigation-config](https://github.com/ubuntu-robotics/ros2-nav2-snap/blob/main/snap/hooks/install#L12) (string, default: "")

The `slam-config`, `localization-config`, and `navigation-config` parameters are essential for the proper functioning of these applications.

These parameters must be set either to a local configuration file accessible within the SNAP environment (such as `$SNAP_COMMON`), or to a URL hosting the desired configuration.

Additionally, a set of configuration_templates is available at `$SNAP_COMMON/configuration_templates`. Those files are only meant to be a template, they can be modified and used by setting them to the parameters (e.g. `snap set ros2-nav2 slam-config="/var/snap/ros2-nav2/common/configuration_templates/slam_params_template.yaml"`).

In case you want to reinitialize the templates, you can simply issue the command `ros2-nav2.reset-config-templates` which will reset all configuration files.

As mentioned, those parameters can also be can also be configured with a URL as follows:

`snap set ros2-nav2 <app-name>-config="https://raw.githubusercontent.com/robot-repo/<app-name>_params.yaml"`

Note: the URL must be reachable by the snap. When using a URL, the configuration file will be downloaded everytime the app is launched. Therefore a configuration update upstream will be applied with the application relaunch.

### SLAM

The SLAM application allows to run the algorithm to map the environment.

Before launching it make sure to configure the `slam-config param` to an appropriate slam configuration yaml file.
This can either point to one of our templates, to a custom file within $SNAP_COMMON or to a URL as explained in the [Configuration section](#configuration).

Once configured, SLAM can be launched as follows:

`snap start rosbot-xl-nav.slam`

After starting, one can then drive the robot around to create a 2D representation of the environment.
Once the area is covered, the application can be stopped with:

`snap stop rosbot-xl-nav.slam`

When the application is terminated, the map is automatically saved at `$SNAP_COMMON/maps/current_map.{png,yaml}`.

### Map saver

After stopping the slam application, a map is automatically saved. This is achieved by calling a service to the map saver.
The map saver runs by default with the parameters provided upstream.
It can be optionally configured by setting the `map-save-config` parameter to either a local file or to a URL.

The only parameters that can be configured by means of a yaml file are `free_thresh_default` and `occupied_thresh_default`.

### Load map

In alternative to the creation of a map via SLAM, it is also possible to use a pre-existing map.

The map can be optionally loaded by configuring the `map-yaml-path` parameter to either a map placed in `$SNAP_COMMON/maps`, or to a URL that stores the desired map.

An example usage of loading a turtlebot3 map from upstream looks as follows:

`sudo snap set ros2-nav2 map-yaml-path=https://raw.githubusercontent.com/ros-planning/navigation2/main/nav2_bringup/maps/turtlebot3_world.yaml`

When setting this parameter to a URL, the map .yaml file and it's associated image will be downloaded and stored in `$SNAP_COMMON/maps`.
A soft symlink to the downloaded map will be created, so the map will be used by the localization algorithm.
Note: the URL must be reachable by the snap. When using a URL, the configuration file will be downloaded everytime the app is launched. Therefore a configuration update upstream will be applied with the application relaunch.

In case SLAM is performed, this parameter will be overwritten and the new generated map used instead.

### Localization

With the environment mapped, one can make use of the autonomous navigation.
To do so, the localization application has to be started. The localization allows the robot to localize itself in the map provided.

Before launching it make sure to configure the `localization-config param` to an appropriate localization configuration yaml file.
This can either point to one of our templates, to a custom file within $SNAP_COMMON or to a URL as explained in the [Configuration section](#configuration).
Once configured, localization can be started as follows:

`snap start ros2-nav2.localization`

Localization will publish the map for the navigation and localize the robot. It can be stopped with:

`snap stop ros2-nav2.localization`

### Navigation

The navigation application allows the robot to autonomously move around to a defined goal while avoiding obstacles.

Before launching it,  make sure to configure the `navigation-config param` to an appropriate navigation configuration yaml file. The snap parameter can either point to one of our templates, to a custom file within $SNAP_COMMON or to a URL as explained in the [Configuration section](#configuration).
Once configured, navigation can be started and stopped respectively with:

`snap start ros2-nav2.navigation`

`snap stop ros2-nav2.navigation`
