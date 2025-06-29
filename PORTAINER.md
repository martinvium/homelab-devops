# Portainer

## Installing Docker

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    apt-cache policy docker-ce
    sudo apt install docker-ce

Verify it's working:

    sudo systemctl status docker

Avoid typing sudo for docker commands:

    sudo usermod -aG docker ${USER}

Exit and reconnect to the VM.

## Install Portainer

Create persistent volume:

    docker volume create portainer_data

Download and run the portainer container:

    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts

Access the portainer web interfacet at:

    https://<ip-address>:9443/

## Docker Standalone Environments

1. Create 2 additional VM's
2. Install docker on them with SU (repeat Installing Docker steps)
3. Add them under environments in Portainer
4. Run the agent command on each VM
5. Add the VM's host and IP in portainer

## Running Services

You will need Portainer to be able to access the templates/stacks defined in your github repository, to do that you need to generate a fine-grained [personal access token](https://github.com/settings/personal-access-tokens) (only needs Contents -> Read only, disable webhooks).

1. Add a compose file under https://github.com/martinvium/homelab-devops/tree/main/portainer/<app>/docker-compose.yml
2. Visit Stacks -> Create stack
4. Enable authentication add paste in the token created above
5. Point the path to file added above
6. Leave reference at default HEAD
