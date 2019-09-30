#!bin/bash

apt-get install gcc libkrb5-dev -y
st2 pack install ansible

ANSIBLE_OUTPUT=`st2 pack list | grep ansible`
if ! echo ${ANSIBLE_OUTPUT} > /dev/null 2>&1; then
    echo "[ Failed ] Add Ansible Pack"
else
    echo "[ Succeeded ] Add Ansible Pack"
fi
echo "ANSIBLE_OUTPUT: ${ANSIBLE_OUTPUT}"