#!/bin/bash

pack_name="mydemo_pack"


if [ -d "/opt/stackstorm/packs" ]; then
  cd /opt/stackstorm/packs
  if [ ! -d "/opt/stackstorm/packs/$pack_name" ]; then
    st2 pack install "https://github.com/${GITHUB_ACCT}/$pack_name.git"
    sudo /opt/stackstorm/virtualenvs/ansible/bin/pip install --upgrade pip
    sudo /opt/stackstorm/virtualenvs/$pack_name/bin/pip install -r requirements.txt.dev
    chown -R root:st2packs $pack_name
  fi
fi
