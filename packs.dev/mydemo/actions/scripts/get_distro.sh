#!/bin/bash

set -e

distro=$1

output=$(cat /etc/os-release | grep -E "^ID=$distro" | grep -oP "$distro")

if [ "$output" = "ubuntu" ]; then
  echo "success"
  exit 0
else
  echo "failed"
  exit 12
fi
