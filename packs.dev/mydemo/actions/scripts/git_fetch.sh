#!/bin/bash

function main() 
{
    #GIT_FETCH=$(git fetch | grep -E "master\+->\s+origin/master" | awk  "{print $1}")
    OUTPUT=$(git fetch | grep -E "$1\+->\s+origin/$1" | awk  "{print $2}")
    for o in "$OUTPUT"
    do
        if [[ $o =~ origin/$1 ]]
        then
          exit 0
        fi
    done

    exit 1
}


main