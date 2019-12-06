#!/bin/bash

function main() 
{
  WORKING_DIR=$1
  BRANCH=$2

  output=null
  
  if [ -d "$WORKING_DIR" ]; then
    cd $WORKING_DIR
    sudo git fetch -p
    sudo git checkout -q $BRANCH
    latest_rev=$(sudo git ls-remote origin HEAD | awk '{print $1}')
    current_rev=$(sudo git rev-parse HEAD)
    if [ "$latest_rev" != "$current_rev" ]; then
      sudo git reset --hard $(git log --pretty=format:%H | tail -1)
      output=$(sudo git pull)
    fi
  fi

  echo $output
  return
}

OUTPUT=null

WORKING_DIR=$1
BRANCH=$2

OUTPUT=$(main $WORKING_DIR $BRANCH)
echo $OUTPUT
