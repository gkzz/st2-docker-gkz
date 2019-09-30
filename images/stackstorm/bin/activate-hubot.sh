#!bin/bash

export ST2_API_KEY=$(st2 apikey create -k -m '{"name": "'$YOURBOTNAME'"}')
sed -i -e 's/export ST2_API_KEY="${ST2_API_KEY}"/export ST2_API_KEY='"$ST2_API_KEY"'/' \
    -i -e 's/# export HUBOT_ADAPTER=slack/export HUBOT_ADAPTER=slack/' \
    -i -e 's/# export HUBOT_SLACK_TOKEN=xoxb-CHANGE-ME-PLEASE/export HUBOT_SLACK_TOKEN='"$HUBOT_SLACK_TOKEN"'/' \
    /opt/stackstorm/chatops/st2chatops.env

st2ctl reload --register-all && service st2chatops restart

echo "#################"

ST2_OUTPUT=`service st2chatops status | grep running`
if ! echo ${ST2_OUTPUT} > /dev/null 2>&1; then
    echo "[ Failed ] Activate Hubot"
else
    echo "[ Succeeded ] Activate Hubot"
    source /st2-docker/bin/add-ansible-pack.sh
fi
echo "ST2_OUTPUT: ${ST2_OUTPUT}"