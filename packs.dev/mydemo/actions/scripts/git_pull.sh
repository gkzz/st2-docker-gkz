#!/bin/bash

function main() 
{
  
  WORKING_DIR=$1
  REPO_URL=$2
  BRANCH=$3

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
    $OUTPUT=$(git clone $REPO_URL $WORKING_DIR))
    echo $OUTPUT
    return
  fi
}

WORKING_DIR=$1
REPO_URL=$2
BRANCH=$3

main $WORKING_DIR $REPO_URL $BRANCH