#!bin/bash

apt-get install gcc libkrb5-dev -y
st2 pack install ansible
st2ctl reload --register-all

OUTPUT=`st2 pack list | grep ansible`
if ! echo ${ANSIBLE_OUTPUT} > /dev/null 2>&1; then
    echo "[ Failed ] Add Ansible Pack"
else
    echo "[ Succeeded ] Add Ansible Pack"
    cp packs.dev/ansible/ansible.cfg /opt/stackstorm/packs/ansible/
    st2 run ansible.playbook \
    inventory_file=/packs.dev/ansible/inventory/hosts \
    playbook=/packs.dev/ansible/playbook/ping.yaml
fi
echo "ANSIBLE_PACK_INSTALLED: ${OUTPUT}" 