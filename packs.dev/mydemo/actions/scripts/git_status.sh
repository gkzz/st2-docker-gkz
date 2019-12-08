#!/bin/bash

function main() 
{
  working_dir=$1
  branch=$2
  expected=$3

  counter=0

  if [ -d "$working_dir" ]; then
    cd $working_dir
    sudo git fetch -p
    sudo git checkout -q $branch
    if [ "$expected" -eq "up_to_date" ]; then
      output=$(sudo git status | grep -E "(Your)\s+(branch)\s+(is)\s+(up-to-date)\s+(with)\s+('origin/$branch')." | awk '{print $6}' | grep -oP "$branch")
    elif [ "$expected" -eq "not_up_to_date" ]; then
      output=$(sudo git status | grep -E "(Your)\s+(branch)\s+(is)\s+(behind)\s+('origin/$branch')\s+.*" | awk '{print $5}' | grep -oP "$branch")
    else
      echo $counter
      return
    fi

    output=$(echo ${output:=unknown})
    if [ "$output" = "$branch" ]; then
      counter=`expr $counter + 1`
    fi
  fi

  echo $counter
  return
}


working_dir=$1
branch=$2
expected=$3

counter=$(main $working_dir $branch $expected)


if [ $counter -eq 1 ]; then
  exit 0
else
  exit 1
fi


