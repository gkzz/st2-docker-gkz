#!/bin/bash

export ST2_API_KEY=$(st2 apikey create -k -m '{"used_by": "my integration"}')

FILES=/st2-docker/opt/reload.d/*

for f in $FILES; 
do
  echo "Execute $f"
  bash "$f" -H
done

chown -R root:st2packs /opt/stackstorm/packs/mydemo/ \
&& chmod -R +x /opt/stackstorm/packs/mydemo/


st2ctl reload --register-all

