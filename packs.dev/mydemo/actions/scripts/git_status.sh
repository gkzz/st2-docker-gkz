#!/bin/bash

set -e

working_dir=$1
branch=$2
expected=$3

args=($working_dir $branch $expected)
for a in $args;
do
  echo $a
done


if [ -d "$working_dir" ]; then
  cd $working_dir
  sudo git fetch -p
  sudo git checkout -q $branch

  if [ "$expected" = "up_to_date" ]; then
    output=$(sudo git status | grep -E "(Your)\s+(branch)\s+(is)\s+(up-to-date)\s+(with)\s+('origin/$branch')" | awk '{print $6}' | grep -oP "$branch")
  elif [ "$expected" = "not_up_to_date" ]; then
    output=$(sudo git status | grep -E "(Your)\s+(branch)\s+(is)\s+(behind)\s+('origin/$branch')" | awk '{print $5}' | grep -oP "$branch")
  else
    echo "None of the condition met"
  fi
  
  output=$(echo ${output:="unknown"})

  if [ "$output" = "unknown" ]; then
    exit 102
  elif [ "$output" = "$branch" ]; then
    exit 0
  else
    exit 103
  fi
fi

exit 202
