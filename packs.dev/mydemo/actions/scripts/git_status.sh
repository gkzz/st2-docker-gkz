#!/bin/bash

set -e

function main() 
{
  working_dir=$1
  branch=$2
  merged=$3

  ptn=null
  if "$merged"; then
    ptn="Your branch is up to date with 'origin/$branch'." 
  else
    ptn="Your branch is behind 'origin/$branch'"
  fi
  

  counter=0
  if [ -d "$working_dir" ]; then
    cd $working_dir
    sudo git fetch -p
    sudo git checkout -q $branch
    status=$(git status | grep -E "$ptn")
    status=$(echo ${status:-unknown})
    if [ "$status" = "$ptn" ]; then
      counter=`expr $counter + 1`
    fi
  fi

  echo $counter
  return
}


working_dir=$1
branch=$2
merged=$3

counter=$(main $working_dir $branch $merged)

if [ $counter -eq 1 ]; then
  exit 0
fi

exit 1

