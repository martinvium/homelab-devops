# Ansible Devops

Configuring my homelab using ansible.

## Installation

```
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## Configuration

Add the ansible configuration file:

    vim $HOME/ansible.cfg

And add the following to it:

    [default]
    inventory=inventory.ini

Add an inventory:

    vim $HOME/inventory.ini

Add an example group to the inventory e.g.

    [example]
    user@192.168.1.100

Confirm it's working:

    ansible example -m ping

Or:

    ansible example -a "free -h"
