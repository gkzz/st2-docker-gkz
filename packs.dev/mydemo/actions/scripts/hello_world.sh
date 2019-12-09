#!/bin/bash

saying=$1

if [ "$saying" = "hello world" ]; then
  echo "success"
  exit 0
else
  echo "failed"
  exit 12
fi
