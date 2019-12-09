#!/bin/bash

saying=$1
expected=$2

if [ "$saying" = "$expected" ]; then
  echo "success"
  exit 0
else
  echo "failed"
  exit 12
fi
