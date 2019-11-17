#!/bin/bash

export ST2_API_KEY=$(st2 apikey create -k -m '{"used_by": "my integration"}')

SCRIPTS = /opt/reload.d/*

for f in $SCRIPTS; 
do
  echo "Execute $f"
  bash "$f" -H
done

