#!/bin/bash

# login
st2 login $ST2_USER -p $ST2_PASSWORD

# publish ST2_API_KEY
export ST2_API_KEY=$(st2 apikey create -k -m '{"used_by": "my integration"}')

# install packs, clone my repo
FILES=/st2-docker/opt/reload.d/*
for f in $FILES; 
do
  echo "Execute $f"
  bash "$f" -H
done

# change owner, mode of mydemo_pack
chown -R root:st2packs /opt/stackstorm/packs/mydemo_pack/ \
&& chmod -R +x /opt/stackstorm/packs/mydemo_pack/

# create, and reload my specified actions one by one
# if you don't need to, just run the following commnad
st2ctl reload --register-all

#actions_dir="/opt/stackstorm/packs/mydemo_pack/actions" \
#&& files=$(ls $actions_dir | grep -E "*.yaml")
#for f in $files;
#do
#  st2 action create /opt/stackstorm/packs/mydemo_pack/actions/$f
#done
#
#pack_name="mydemo_pack" \
#&& st2 run packs.setup_virtualenv packs=$pack_name



# run actions
st2 run ansible.playbook \
inventory_file=/opt/stackstorm/packs/ansible/inventory/hosts \
playbook=/opt/stackstorm/packs/ansible/playbook/ping.yaml

st2 run slack.post_message \
message="Hello World! $HOSTNAME by $SLACKBOT_NAME"

#st2 run mydemo_pack.poll-repo

#st2 run mydemo_pack.my-first-wf


