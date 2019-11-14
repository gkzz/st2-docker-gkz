#!/bin/bash

export ST2_API_KEY=$(st2 apikey create -k -m '{"used_by": "my integration"}')

st2 pack install slack

sed -i -e 's|webhook_url: "https://hooks.slack.com/services/<replace me>"|webhook_url: "'"$INCOMING_WEBHOOK_URL"'"|' \
    -i -e 's|channel: "<DST_CHANNEL>"|channel: "'"$DST_CHANNEL"'"|' \
    -i -e 's|username: "<SLACKBOT_NAME>"|username: "'"$SLACKBOT_NAME"'"|' \
    -i -e 's|action_token: "<SLACKBOT_TOKEN>"|action_token: "'"$SLACKBOT_TOKEN"'"|' \
    -i -e 's|- "<DST_CHANNEL>"|- "'"$DST_CHANNEL"'"|' \
    /opt/stackstorm/configs/slack.yaml

st2ctl reload --register-all

st2 run slack.post_message message="Hello World! $HOSTNAME by $SLACKBOT_NAME"