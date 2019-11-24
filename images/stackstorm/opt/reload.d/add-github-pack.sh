#!/bin/bash

st2 pack install github
st2ctl reload --register-all

sed -i -e 's|token: "{{system.github_oauth_token}}"|token: "'"$GITHUB_OAUTH_TOKEN"'"|' \
    -i -e 's|user: "<TOKEN_OWNERNAME>"|user: "'"$TOKEN_OWNERNAME"'"|' \
    -i -e 's|password: "<TOKEN_OWNERPASSWORD>"|password: "'"$TOKEN_OWNERPASSWORD"'"|' \
    -i -e 's|    - user: "<REPO_OWNERNAME>"|    - user: "'"$REPO_OWNERNAME"'"|' \
    -i -e 's|      name: "<REPO_ACCTNAME>"|      name: "'"$REPO_ACCTNAME"'"|' \
    /opt/stackstorm/configs/github.yaml

st2ctl reload --register-all


OUTPUT=`st2 pack list | grep github`
if ! echo ${OUTPUT} > /dev/null 2>&1; then
    echo "[ Failed ] Add Github Pack"
else
    echo "[ Succeeded ] Add Github Pack"
    st2 rule enable github.deploy_pack_on_deployment_event
fi
echo "GITHUB_PACK_INSTALLED: ${OUTPUT}" 