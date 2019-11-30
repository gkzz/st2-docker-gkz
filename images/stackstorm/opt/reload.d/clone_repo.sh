#!/bin/bash

mkdir -p /usr/src/app \
    && cd $_

if [ ! -d ${SERVICE_DIR} ] 
then
    git clone \
    "https://${GITHUB_SECRET_TOKEN}:x-oauth-basic@github.com/${GITHUB_ACCT}/${SERVICE_DIR}.git"
fi

chown -R root:st2packs ${SERVICE_DIR}