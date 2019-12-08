#!/bin/bash

set -e

function main() 
{
  working_dir=$1
  branch=$2
  up_to_date=$3

  counter=0

  if [ -d "$working_dir" ]; then
    cd $working_dir
    sudo git fetch -p
    sudo git checkout -q $branch
    if $up_to_date; then
      status=$(sudo git status | grep -E "Your branch is up to date with 'origin/$branch'." | awk '{print $8}')
    else
      status=$(sudo git status | grep -E "Your branch is behind 'origin/$branch'.*" | awk '{print $5}')
    fi

    status=$(echo ${status:-unknown})
    if [ "$status" = "'$branch'" ]; then
      counter=`expr $counter + 1`
    fi
  fi

  echo $counter
  return
}


working_dir=$1
branch=$2
up_to_date=$3

counter=$(main $working_dir $branch $up_to_date)


if [ $counter -eq 1 ]; then
  exit 0
fi

exit 1

