#!/bin/bash

set -e

function main()
{
  working_dir=$1
  branch=$2

  counter=0

  if [ -d "$working_dir" ]; then
    cd $working_dir
    sudo git checkout -q $branch

    status=$(sudo git status | grep -E "Your branch is up to date with 'origin/${ptn}'." | awk '{print $8}')
    if [ "$status" = "'origin/${ptn}'." ]; then
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