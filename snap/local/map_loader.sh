#!/usr/bin/bash -e

MAP_DIRS=$SNAP_COMMON/maps
MAP_YAML_URL="$(snapctl get map-yaml-path)"

source $SNAP/usr/bin/url_management.sh

if [ -n "${MAP_YAML_URL}" ]; then
  MAP_NAME=$(basename "$MAP_YAML_URL")
  if get_url "${MAP_YAML_URL}" "${MAP_DIRS}/${MAP_NAME}"; then
    echo "Map yaml file downloaded successfully"
    # create symlink to use the map
    echo "Creating symlink"
    rm -f ${SNAP_COMMON}/maps/current_map.yaml
    ln -s "${MAP_DIRS}/${MAP_NAME}" ${SNAP_COMMON}/maps/current_map.yaml
    echo "Symlink created"
  else
    echo "Could not download yaml file"
    exit 1
  fi
fi

# Retrieve the map image name and format from the YAML file and download it
YAML_CONTENT=$(<$(readlink -f "${SNAP_COMMON}/maps/current_map.yaml"))
IMAGE_FIELD=$(echo "$YAML_CONTENT" | grep -oP 'image:\s*\K\S+')
BASE_URL=$(dirname "$MAP_YAML_URL")
IMAGE_MAP_URL=$BASE_URL/$IMAGE_FIELD

if [ -n "${IMAGE_MAP_URL}" ]; then
  echo $IMAGE_MAP_URL
  if get_url "${IMAGE_MAP_URL}" "${MAP_DIRS}/${IMAGE_FIELD}"; then
    echo "Image file downloaded successfully"
  else
    echo "Could not download image file"
    exit 1
  fi
fi

exec $@
