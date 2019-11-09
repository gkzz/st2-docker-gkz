#!/bin/bash

function help {
  cat <<- EOF
    overview：wheter run "docker-compose up -d --build", or not
    usage：bash sh/setup.sh [-h|-b|-n|
    option：
      -h  this message
      -b ->> run "docker-compose up -d --build", after removing all contrainers
      -n ->> run "nothing" after removing them
EOF
    exit 1

}

while getopts ":bn" OPT;

do
    case ${OPT} in
        b)
          BUILD_FLAG=1;
            ;;
        n)
          BUILD_FLAG=0;
            ;;
        \?)
          help
            ;;
    esac
done

shift $((OPTIND - 1))

IDS=$(docker container ls -aq)

for i in $IDS
do
  echo "$i"
  docker container stop $i && docker container rm $i
done

#IMAGES=$(docker images -aq)
#for i in $IMAGES
#do
#  echo "$i"
#  docker image rmi "$i"
#done

docker container prune --force
docker image prune --force
docker volume prune --force

docker-compose down -v

if [ "$BUILD_FLAG" -eq 1  ]; then
  echo 'Run "docker-compose up -d --build"'
  docker-compose up -d --build
elif [ "$BUILD_FLAG" -eq 0 ]; then
  echo 'Not Run "docker-compose up -d --build"'
else
  echo "option is unexpected."
  help
fi