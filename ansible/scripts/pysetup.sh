#/usr/bin/env bash

pip install --upgrade pip
pip install ansible PyGithub
ansible-galaxy collection install azure.azcollection --force
pip install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
wget -q https://raw.githubusercontent.com/ansible-collections/kubernetes.core/main/requirements.txt
pip install -r requirements.txt
rm requirements.txt
ansible-galaxy collection install kubernetes.core --force
ansible-galaxy collection install community.general