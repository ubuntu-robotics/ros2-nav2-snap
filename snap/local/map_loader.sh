#!/usr/bin/bash -e

MAP_YAML_URL="$(snapctl set map-yaml-path)"

## TODO get the png image from the yaml directly, the url is the same just replace the end with the name retrieved in the file

if [ -n "${MAP_YAML_URL}" ]; then
  echo "PGN URL defined downloading it"
  MAP_NAME=$(basename "$MAP_YAML_URL")
  YAML_MAP_PATH="$SNAP_COMMON/map/${MAP_NAME}"
  if get_url "${MAP_YAML_URL}" "${YAML_MAP_PATH}"; then
    echo "Map yaml file dowloaded successfully"
    # create symlink to use the map
    rm -f ${SNAP_COMMON}/maps/current_map.yaml
    ln -s ${YAML_MAP_PATH} ${SNAP_COMMON}/maps/current_map.yaml
  else
    echo "Could not download yaml file"
  fi
fi
