# Immich

## Pre-requisites

- podman
- podman-compose

## Configuration

1. Ensure XDG_DATA_HOME is defined in .bashrc
2. Copy .env.example to .env
3. Edit .env replacing the default with a randomized password

## Run

    podman compose up -d

To register for the admin user, access the web application at `http://<machine-ip-address>:2283`
