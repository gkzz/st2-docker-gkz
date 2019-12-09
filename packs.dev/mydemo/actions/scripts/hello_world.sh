#!/bin/bash

saying=$1
expected=$2

output=$(echo "$saying")

if [ "$output" = "$expected" ]; then
  exit 0
else
  exit 12
fi
