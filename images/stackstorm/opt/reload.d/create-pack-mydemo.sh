#!/bin/bash

PACKNAME="mydemo"

cp -r /opt/stackstorm/packs.dev/$PACKNAME /opt/stackstorm/packs/
st2 action list --pack=$PACKNAME | grep "orquesta-examples-slack"