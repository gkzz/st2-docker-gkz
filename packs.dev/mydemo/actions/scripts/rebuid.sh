#!/bin/bash



function main()
{
  counter=0
  CONTAINERS_NAME=$1
  for c in $CONTAINERS_NAME;
  do
    for i in $(docker container ls | grep -E '\$c.*Up' | awk '{print $1}');
    do
      docker container stop $i && docker container rm $i;
      counter=`expr $counter + 1`
    done
  done

  if [ $counter -eq 2 ]; then
    exit 0
  else
    exit 1
  fi

}

OUTPUT=null
CONTAINERS_NAME=$1

if [[ $(main $CONTAINERS_NAME) ]]; then
  OUTPUT=$(sudo docker-compose up -d --build)
fi

echo ${OUTPUT}
