#!/bin/bash

set -e

function main() 
{
  working_dir=$1
  branch=$2

  output=null
  
  if [ -d "$working_dir" ]; then
    cd $working_dir
    sudo git fetch -p
    sudo git checkout -q $branch
    latest_rev=$(sudo git ls-remote origin HEAD | awk '{print $1}')
    current_rev=$(sudo git rev-parse HEAD)
    if [ "$latest_rev" != "$current_rev" ]; then
      sudo git reset --hard $(git log --pretty=format:%H | tail -1)
      output=$(sudo git pull)
    fi
  fi

  echo $output
  return
}


working_dir=$1
branch=$2

return_value=$(main $working_dir $branch)
echo ${return_value:=null}
