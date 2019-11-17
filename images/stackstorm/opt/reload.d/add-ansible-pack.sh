#!bin/bash

apt-get install gcc libkrb5-dev -y
st2 pack install ansible
st2ctl reload --register-all

OUTPUT=`st2 pack list | grep ansible`
if ! echo ${ANSIBLE_OUTPUT} > /dev/null 2>&1; then
    echo "[ Failed ] Add Ansible Pack"
else
    echo "[ Succeeded ] Add Ansible Pack"
    cp -r /opt/stackstorm/packs.dev/ansible/* /opt/stackstorm/packs/ansible/*
    st2 run ansible.playbook \
    inventory_file=/opt/stackstorm/packs/ansible/inventory/hosts \
    playbook=/opt/stackstorm/packs/ansible/playbook/ping.yaml
fi
echo "ANSIBLE_PACK_INSTALLED: ${OUTPUT}" 