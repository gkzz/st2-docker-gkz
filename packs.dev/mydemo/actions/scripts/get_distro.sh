#!/bin/bash

set -e

distro=$1

output=$(cat /etc/os-release)
echo $output | grep -E "ID=$distro" | awk '{print $5}' | grep -oP "$distro"

if [ "$output" = "ubuntu" ]; then
  echo "success"
  exit 0
else
  echo "failed"
  exit 12
fi
