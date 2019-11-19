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
    sed -i -e 's|ansible_ssh_user: <JUNOS_USER>|ansible_ssh_user: '"$JUNOS_USER"'|' \
        -i -e 's|ansible_ssh_pass: <JUNOS_PASS>|ansible_ssh_pass: '"$JUNOS_PASS"'|' \
        /opt/stackstorm/packs/ansible/inventory/group_vars/junos

    sed -i -e 's|ansible_host=<WEBAPP_IP>|ansible_host='"$WEBAPP_IP"'|' \
        -i -e 's|ansible_port=<JUNOS_PORT> ansible_host=<JUNOS_IP>|ansible_port='"$JUNOS_PORT"' ansible_host='"$JUNOS_IP"'|' \
        /opt/stackstorm/packs/ansible/inventory/hosts

    st2 run ansible.playbook \
    inventory_file=/opt/stackstorm/packs/ansible/inventory/hosts \
    playbook=/opt/stackstorm/packs/ansible/playbook/ping.yaml
fi
echo "ANSIBLE_PACK_INSTALLED: ${OUTPUT}" 