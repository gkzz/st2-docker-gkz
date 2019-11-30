#!/bin/bash

function main() 
{
    OUTPUT=$(git fetch | grep -E "$1\+->\s+origin/$1" | awk "{print $2}")
    for o in "$OUTPUT"
    do
        if [[ $o =~ origin/$1 ]]
        then
            git checkout $1 \
            && git merge origin/$1
        fi
    done
}


main