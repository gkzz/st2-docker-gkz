#!/bin/bash

st2 login $ST2_USER -p $ST2_PASSWORD

export ST2_API_KEY=$(st2 apikey create -k -m '{"used_by": "my integration"}')

FILES=/st2-docker/opt/reload.d/*

for f in $FILES; 
do
  echo "Execute $f"
  bash "$f" -H
done

chown -R root:st2packs /opt/stackstorm/packs/mydemo/ \
&& chmod -R +x /opt/stackstorm/packs/mydemo/

actions_dir="/opt/stackstorm/packs/mydemo/actions" \
&& files=$(ls $actions_dir | grep -E "*.yaml")

for f in $files;
do
  st2 action create /opt/stackstorm/packs/mydemo/actions/$f
done

st2 run packs.setup_virtualenv

st2ctl reload --register-all

st2 run ansible.playbook \
inventory_file=/opt/stackstorm/packs/ansible/inventory/hosts \
playbook=/opt/stackstorm/packs/ansible/playbook/ping.yaml

st2 run slack.post_message \
message="Hello World! $HOSTNAME by $SLACKBOT_NAME"


