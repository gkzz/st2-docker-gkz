#!bin/bash

apt-get install gcc libkrb5-dev -y
st2 pack install ansible
/opt/stackstorm/virtualenvs/ansible/bin/pip install --upgrade pip
/opt/stackstorm/virtualenvs/ansible/bin/pip install paramiko

chmod -R 755 /opt/stackstorm/packs/ansible
chown -R root:st2packs /opt/stackstorm/packs/ansible


target=ansible
content=$(st2 pack list | grep -E "$target" | awk '{print $2}')
output=$(echo ${content:="unknown"})

if [ "$output" = "unknown" ]; then
  echo "[ Failed ] Add Ansible Pack"
else
    echo "[ Succeeded ] Add Ansible Pack"
    cp -r /opt/stackstorm/packs.dev/ansible/* /opt/stackstorm/packs/ansible/
    sed -i -e 's|ansible_port: <JUNOS_PORT>|ansible_port: '"$JUNOS_PORT"'|' \
        -i -e 's|ansible_ssh_user: <JUNOS_USER>|ansible_ssh_user: '"$JUNOS_USER"'|' \
        -i -e 's|ansible_ssh_pass: <JUNOS_PASS>|ansible_ssh_pass: '"$JUNOS_PASS"'|' \
        /opt/stackstorm/packs/ansible/inventory/group_vars/junos

    sed -i -e 's|<WEBAPP_IP>|'"$WEBAPP_IP"'|' \
        -i -e 's|<JUNOS_IP>|'"$JUNOS_IP"'|' \
        /opt/stackstorm/packs/ansible/inventory/hosts

    #st2 run ansible.playbook \
    #inventory_file=/opt/stackstorm/packs/ansible/inventory/hosts \
    #playbook=/opt/stackstorm/packs/ansible/playbook/gather_facts_junos.yaml

fi
echo "ANSIBLE_PACK_INSTALLED: ${output}" 