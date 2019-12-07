#!/bin/bash

set -e

function main() 
{
  working_dir=$1
  branch=$2

  counter=0
  
  if [ -d "$working_dir" ]; then
    cd $working_dir
    sudo git fetch -p
    sudo git checkout -q $branch
    latest_rev=$(sudo git ls-remote origin HEAD | awk '{print $1}')
    current_rev=$(sudo git rev-parse HEAD)
    if [ "$latest_rev" = "$current_rev" ]; then
      counter=`expr $counter + 1`
    fi
  fi

  echo $counter
  return
}


working_dir=$1
branch=$2

counter=$(main $working_dir $branch)

  if [ $counter -eq 1 ]; then
    exit 0
  else
    exit 1
  fi
