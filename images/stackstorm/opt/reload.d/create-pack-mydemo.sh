#!/bin/bash

pack="st2-mydemo-pack"


if [ -d "/opt/stackstorm/packs" ]; then
  cd /opt/stackstorm/packs
  if [ ! -d "/opt/stackstorm/packs/$pack" ]; then
    st2 packs install \
      "https://${GITHUB_SECRET_TOKEN}:x-oauth-basic@github.com/${GITHUB_ACCT}/$pack.git"
    chown -R root:st2packs $pack
  fi
fi
