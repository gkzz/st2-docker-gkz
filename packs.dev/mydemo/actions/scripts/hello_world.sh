#!/bin/bash

saying=$1
expected=$2

output=$(echo "$saying, everyday" | awk '{print $2}' | grep -oP "$expected")

if [ "$output" = "$expected" ]; then
  exit 0
else
  exit 12
fi
