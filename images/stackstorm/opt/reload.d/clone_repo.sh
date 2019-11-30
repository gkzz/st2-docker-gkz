#!/bin/bash

mkdir -p /usr/src/app \
    && cd $_ \
    && git clone ${SECRET_GITHUB_CLONE_URL}