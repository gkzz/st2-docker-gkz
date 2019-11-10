#!/bin/bash

# https://docs.docker.com/install/linux/docker-ce/ubuntu

DOCKER_EXISTS=$(ls /var/run/ | grep -E "^docker$" | echo "$?")
DC_EXISTS=$(ls /usr/local/bin/ | grep -E "^docker-compose$" | echo "$?")
MAKE_EXISTS=$(ls /usr/bin/ | grep -E "^make$" | echo "$?")


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

if [ "$DOCKER_EXISTS" -ne 0 ]; then
    install_docker
else
    echo -e "\n###########################"
    echo "Docker is Already Installed"
    docker --version
fi

if [ "$DC_EXISTS" -ne 0 ]; then
    install_dc 
else
    echo -e "\n###########################"
    echo "Docker Compose is Already Installed"
    docker-compose --version
fi

if [ "$MAKE_EXISTS" -ne 0 ]; then
    sudo apt-get install build-essential
else
    echo -e "\n###########################"
    echo "Make is Already Installed!"
    make --version
fi