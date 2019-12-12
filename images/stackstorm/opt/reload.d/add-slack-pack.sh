#!/bin/bash

st2 pack install slack

sed -i -e 's|webhook_url: "https://hooks.slack.com/services/<replace me>"|webhook_url: "'"$INCOMING_WEBHOOK_URL"'"|' \
    -i -e 's|channel: "<DST_CHANNEL>"|channel: "'"$DST_CHANNEL"'"|' \
    -i -e 's|username: "<SLACKBOT_NAME>"|username: "'"$SLACKBOT_NAME"'"|' \
    -i -e 's|action_token: "<SLACKBOT_TOKEN>"|action_token: "'"$SLACKBOT_TOKEN"'"|' \
    -i -e 's|- "<DST_CHANNEL>"|- "'"$DST_CHANNEL"'"|' \
    /opt/stackstorm/configs/slack.yaml


OUTPUT=`st2 pack list | grep slack`
if ! echo ${OUTPUT} > /dev/null 2>&1; then
    echo "[ Failed ] Add Slack Pack"
else
    echo "[ Succeeded ] Add Slack Pack"
fi
echo "SLACK_PACK_INSTALLED: ${OUTPUT}" 