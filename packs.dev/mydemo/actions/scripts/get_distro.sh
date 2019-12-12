#!/bin/bash

set -e

distro=$1

content=$(cat /etc/os-release)
echo $content | grep -E "ID=$distro" | awk '{print $5}' | grep -oP "$distro"

output=$(echo ${content:="unknown"})
echo "output: $output"

if [ "$output" = "$distro" ]; then
  echo "success"
  exit 0
else
  echo "failed"
  exit 102
fi
