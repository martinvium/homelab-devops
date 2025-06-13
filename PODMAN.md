# Podman

Alternative to docker/-compose that uses unprivileged containers by default.

## Installation

    sudo apt-get install podman podman-compose

## Running an application

    podman compose up -d

## Starting services at boot

https://docs.podman.io/en/latest/markdown/podman-system-service.1.html

Start the user systemd socket for a rootless service.

    systemctl --user start podman.socket

Configure the systemd socket to be automatically started after reboots, and run as the specified user.

    systemctl --user enable podman.socket
    loginctl enable-linger <USER>
