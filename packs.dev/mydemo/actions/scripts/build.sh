#!/bin/bash

function gitPull() 
{
    cd $1
    OUTPUT=$(sudo git fetch | grep -E "$2\+->\s+origin/$2" | awk "{print $2}")
    for o in "$OUTPUT"
    do
        if [[ $o =~ origin/$2 ]]
        then
            sudo git checkout $2 \
            && sudo git merge origin/$2
            return 0
        fi
    done
    return 1
}


function rmContainer()
{
  for c in $1;
  do
    for i in $(docker container ls | grep -E '$c.*Up' | awk '{print $1}');
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
  if [ $(gitPull $1 $2) -eq 0 ]; then
    if [ $(rmContainer $3) -eq 0 ]; then
      OUTPUT=$(sudo docker-compose up -d --build)
    fi
    echo "GIT PULL: true"
    echo "DOCKER BUILD: ${OUTPUT}"
  fi
  echo "GIT PULL: false"
}

WORKING_DIR=$1
BRANCH=$2
CONTAINER_NAME=$3

main WORKING_DIR BRANCH CONTAINER_NAME
