#!/bin/bash

set -e

function main() 
{
  working_dir=$1
  branch=$2
  up_to_date=$3

  counter=0

  ptn=null
  if $up_to_date; then
    ptn="Your branch is up to date with 'origin/$branch'." 
  else
    ptn="Your branch is behind 'origin/$branch'"
  fi
  

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
up_to_date=$3

counter=$(main $working_dir $branch $up_to_date)


if [ $counter -eq 1 ]; then
  exit 0
fi

exit 1

