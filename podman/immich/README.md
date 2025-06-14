# Immich

## Pre-requisites

- podman
- podman-compose

## Configuration

Create a ZFS dataset (if using):

    sudo zfs create data/immich

Enable the user with systemctl

    loginctl enable-linger <USER>

Copy .env.example to .env

    cp .env.example .env

Edit .env replacing the default with a randomized password

    vim .env

## Run

    podman compose up -d

To register for the admin user, access the web application at `http://<machine-ip-address>:2283`

## Run as a different user

Create a user to run:

    sudo adduser --system --group immich

Assign the dataset to the user:

    chown -R immich:immich /data/immich/

## Generating quadlet / systemd auto start

In order to automatically start start the containers after e.g. a reboot, podman recommends using something called quadlets, which I suppose is an alternative to compose.yaml syntax. `podlet` does not support $ interpolation at the time of writing, so inline everything that cannot be loaded via env file.

    sudo apt install build-essential
    sudo apt-get install rustup
    rustup default stable
    cargo install podlet
    podlet compose --pod > .container
