#!/bin/bash

function main() 
{
  
  WORKING_DIR=$1
  BRANCH=$2

  OUTPUT=null
  
  if [ -d "$WORKING_DIR" ]; then
    cd $WORKING_DIR
    git fetch -p
    git checkout -q $BRANCH
    latest_rev=$(git ls-remote origin HEAD | awk '{print $1}')
    current_rev=$(git rev-parse HEAD)
    if [ "$latest_rev" != "$current_rev" ]; then
      git reset --hard $(git log --pretty=format:%H | tail -1)
      $OUTPUT=$(git pull)
      echo $OUTPUT
      return
    fi
  else
    return 1
  fi
}

WORKING_DIR=$1
BRANCH=$2

main $WORKING_DIR $BRANCH