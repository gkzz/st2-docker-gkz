#!/bin/bash

st2 pack install slack

target=slack
content=$(st2 pack list | grep -E "$target" | awk '{print $2}')
output=$(echo ${content:="unknown"})

if [ "$output" = "unknown" ]; then
  echo "[ Failed ] Add Slack Pack"
else
  echo "[ Succeeded ] Add Slack Pack"
  sed -i -e 's|webhook_url: "https://hooks.slack.com/services/<replace me>"|webhook_url: "'"$INCOMING_WEBHOOK_URL"'"|' \
      -i -e 's|channel: "<DST_CHANNEL>"|channel: "'"$DST_CHANNEL"'"|' \
      -i -e 's|username: "<SLACKBOT_NAME>"|username: "'"$SLACKBOT_NAME"'"|' \
      -i -e 's|action_token: "<SLACKBOT_TOKEN>"|action_token: "'"$SLACKBOT_TOKEN"'"|' \
      -i -e 's|- "<DST_CHANNEL>"|- "'"$DST_CHANNEL"'"|' \
      /opt/stackstorm/configs/slack.yaml
fi
echo "SLACK_PACK_INSTALLED: ${output}" 