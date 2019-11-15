#!/bin/bash

PACKNAME="mydemo"

cp -r /opt/stackstorm/packs.dev/$PACKNAME /opt/stackstorm/packs/
#st2 action create /opt/stackstorm/packs/$PACKNAME/actions/orquesta-examples-slack.yaml
#st2 action create /opt/stackstorm/packs/$PACKNAME/actions/orquesta-ping-with-items.yaml
st2 action list --pack=$PACKNAME | grep "orquesta-examples-slack"