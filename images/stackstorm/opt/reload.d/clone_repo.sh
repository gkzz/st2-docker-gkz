#!/bin/bash

mkdir -p /usr/src/app \
    && chown -R root:st2packs app/ \
    && cd /usr/src/app

if [ ! -d ${SERVICE_DIR} ] 
then
    git clone \
    "https://${GITHUB_SECRET_TOKEN}:x-oauth-basic@github.com/${GITHUB_ACCT}/${SERVICE_DIR}.git"
fi