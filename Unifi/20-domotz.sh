#!/bin/sh
CONTAINER=domotz-agent
# Starts a Domotz container that is deleted after it is stopped.
# All configs stored in /mnt/data/domotz
if podman container exists ${CONTAINER}; then
  podman start ${CONTAINER}
else
  mkdir -p /mnt/data/domotz/config/
  touch /mnt/data/domotz/config/domotz.json
  podman run --net=host --cap-add=NET_ADMIN --mount type=bind,source=/mnt/data/domotz/config/domotz.json,target=/opt/domotz/etc/domotz.json --name domotz-agent -d  avassdal/domotz-arm64
fi
