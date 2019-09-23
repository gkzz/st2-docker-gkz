#!/bin/bash

ST2_API_KEY=$(st2 apikey create -k -m '{"name": "${YOURBOTNAME}"}')
sed -i -e "s/export ST2_API_KEY=\"${ST2_API_KEY}\"/export ST2_API_KEY=${ST2_API_KEY}/" \
    -i -e "s/# export HUBOT_ADAPTER=slack/export HUBOT_ADAPTER=slack/" \
    -i -e "s/# export HUBOT_SLACK_TOKEN=xoxb-CHANGE-ME-PLEASE/export HUBOT_SLACK_TOKEN=${HUBOT_SLACK_TOKEN}/" \
    /opt/stackstorm/chatops/st2chatops.env

st2ctl reload --register-all && service st2chatops restart