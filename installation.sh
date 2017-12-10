echo 'yes' | sudo apt-get install ansible
ansible-playbook -i 'localhost,' -c local eth_node.yml
