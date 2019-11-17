#!bin/bash

apt-get install gcc libkrb5-dev -y
st2 pack install ansible
st2ctl reload --register-all

OUTPUT=`st2 pack list | grep ansible`
if ! echo ${ANSIBLE_OUTPUT} > /dev/null 2>&1; then
    echo "[ Failed ] Add Ansible Pack"
else
    echo "[ Succeeded ] Add Ansible Pack"
    cp -r /opt/stackstorm/packs.dev/ansible/* /opt/stackstorm/packs/ansible/
        sed -i -e 's|ansible_ssh_user: <ssh_user>|ansible_ssh_user: '"$SSH_USER"'|' \
        -i -e 's|ansible_ssh_pass: <ssh_pass>|ansible_ssh_pass: '"$SSH_PASS"'|' \
        /opt/stackstorm/packs/ansible/inventory/hosts

    sed -i -e 's|webapp ansible_host=<webapp_ip>|webapp ansible_host='"$WEBAPP_IP"'|' \
        -i -e 's|jumper ansible_port=<junos_port> ansible_host=<junos_ip>|
                jumper ansible_port='"$JUNOS_PORT"' ansible_host='"$JUNOS_IP"'|' \
        /opt/stackstorm/packs/ansible/inventory/group_vars/junos

    st2 run ansible.playbook \
    inventory_file=/opt/stackstorm/packs/ansible/inventory/hosts \
    playbook=/opt/stackstorm/packs/ansible/playbook/ping.yaml
fi
echo "ANSIBLE_PACK_INSTALLED: ${OUTPUT}" 