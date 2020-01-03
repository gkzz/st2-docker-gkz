#!/bin/bash

pack_name="mydemo_pack"


if [ -d "/opt/stackstorm/packs" ]; then
  cd /opt/stackstorm/packs
  if [ ! -d "/opt/stackstorm/packs/$pack_name" ]; then
    st2 pack install "https://github.com/${GITHUB_ACCT}/$pack_name.git"
    /opt/stackstorm/virtualenvs/ansible/bin/pip install --upgrade pip
    /opt/stackstorm/virtualenvs/$pack_name/bin/pip install -r /st2-docker/opt/requirements.txt.dev
    chmod -R 755 /opt/stackstorm/packs/$pack_name
    chown -R root:st2packs /opt/stackstorm/packs/$pack_name
  fi
fi
