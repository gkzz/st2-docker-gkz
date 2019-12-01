#!/bin/bash

function gitPull() 
{
  
  WORKING_DIR=$1
  REPO_URL=$2
  BRANCH=$3
  
  if [ -d "$WORKING_DIR" ]; then
    cd $WORKING_DIR
    git fetch -p
    git checkout -q $BRANCH
    latest_rev=$(git ls-remote origin HEAD | awk '{print $1}')
    current_rev=$(git rev-parse HEAD)
    if [ "$latest_rev" != "$current_rev" ]; then
      git reset --hard $(git log --pretty=format:%H | tail -1)
      git pull
      return 0
    fi
  else
      git clone $REPO_URL $WORKING_DIR
      return 0
  fi
}


function rmContainer()
{
  CONTAINER_NAME=$1
  for c in $CONTAINER_NAME;
  do
    for i in $(docker container ls | grep -E '\$c.*Up' | awk '{print $1}');
    do
      docker container stop $i && docker container rm $i;
      return 0
    done
  done
  return 1
}

function main()
{
  OUTPUT=null
  if [ $(gitPull $1 $2 $3 $4) -eq 0 ]; then
    if [ $(rmContainer $3) -eq 0 ]; then
      OUTPUT=$(sudo docker-compose up -d --build)
    fi
    echo "GIT PULL: true"
    echo "DOCKER BUILD: ${OUTPUT}"
  fi
  echo "GIT PULL: false"
}


WORKING_DIR=$1
REPO_URL=$2
BRANCH=$3
CONTAINER_NAME=$4

main $WORKING_DIR $REPO_URL $BRANCH $CONTAINER_NAME
