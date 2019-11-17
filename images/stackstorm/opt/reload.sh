#!/bin/bash

export ST2_API_KEY=$(st2 apikey create -k -m '{"used_by": "my integration"}')

FILES=/st2-docker/opt/reload.d/*

for f in $FILES; 
do
  echo "Execute $f"
  bash "$f" -H
done

