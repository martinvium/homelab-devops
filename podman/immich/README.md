# Immich

## Pre-requisites

- podman
- podman-compose

## Configuration

Create a ZFS dataset (if using):

    sudo zfs create data/immich

Create a user to run:

    sudo adduser --system --group immich

Assign the dataset to the user:

    chown -R immich:immich /data/immich/

Copy .env.example to .env

    cp .env.example .env

Edit .env replacing the default with a randomized password

    vim .env

## Run

    podman compose up -d

To register for the admin user, access the web application at `http://<machine-ip-address>:2283`
