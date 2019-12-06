#!/bin/bash

set -e

function main()
{
  working_dir=$1
  ptn=$2

  counter=0

  if [ -d "$working_dir" ]; then
    cd $working_dir

     ids=$(sudo docker container ls | grep -E "${ptn}" | awk '{print $1}')
   
     for i in $ids;
     do
       sudo docker container stop $i \
       && sudo docker container rm $i;
       counter=`expr $counter + 1`
     done
  fi

  if [ $counter -eq 2 ]; then
    return_value=$(sudo docker-compose up -d --build)
    counter=`expr $counter + 1`
  fi
  
  echo $counter
  return

}

working_dir=$1
ptn=$2
counter=$(main $working_dir $ptn)


  if [ $counter -eq 3 ]; then
    exit 0
  else
    exit 1
  fi


