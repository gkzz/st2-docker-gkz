#!/bin/bash

# https://docs.docker.com/install/linux/docker-ce/ubuntu

DOCKER_EXISTS=$(docker --version)
DC_EXISTS=$(docker-compose --version)
MAKE_EXISTS=$(make --version)


function install_docker {
    sudo apt-get update -y

    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
    
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
    sudo apt-key fingerprint 0EBFCD88
    
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
    
    sudo apt-get update
    
    sudo apt-get install docker-ce docker-ce-cli containerd.io

    sudo usermod -aG docker ubuntu
    
}

function install_dc {
    # https://docs.docker.com/compose/install/

    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    sudo chmod +x /usr/local/bin/docker-compose

}

if [ ! $DOCKER_EXISTS ]; then
    install_docker
else
    echo "$DOCKER_EXISTS"
fi

if [ ! $DC_EXISTS ]; then
    install_dc 
else
    echo "$DC_EXISTS"
fi

if [ ! $MAKE_EXISTS ]; then
    sudo apt-get install build-essential
else
    echo "$MAKE_EXISTS"
fi





sudo apt-get install build-essential