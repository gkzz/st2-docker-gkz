#!/bin/bash

mkdir -p /usr/src/app \
    && chown -R root:st2packs app/ \
    && cd /usr/src/app \
    && git clone ${SECRET_GITHUB_CLONE_URL}