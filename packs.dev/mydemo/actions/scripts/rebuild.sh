#!/bin/bash

function main()
{
  working_dir=$1
  ptn=$2

  counter=0
  ids=$(sudo docker container ls | grep -E "${ptn}" | awk '{print $1}')

  for i in $ids;
  do
    sudo docker container stop $i \
    && sudo docker container rm $i;
    counter=`expr $counter + 1`
  done
  
  echo $counter
  return

}

WORKING_DIR=$1
PTN=$2
COUNTER=$(main $WORKING_DIR $PTN)

if [ $COUNTER -eq 2 ]; then
  OUTPUT=$(sudo docker-compose up -d --build)
fi

echo ${OUTPUT:=null}
