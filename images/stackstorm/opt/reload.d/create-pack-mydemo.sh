#!/bin/bash

pack_name="mydemo_pack"


if [ -d "/opt/stackstorm/packs" ]; then
  cd /opt/stackstorm/packs
  if [ ! -d "/opt/stackstorm/packs/$pack_name" ]; then
    st2 packs install "https://github.com/${GITHUB_ACCT}/$pack_name.git"
    chown -R root:st2packs $pack_name
  fi
fi
