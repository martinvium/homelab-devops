# Quadlet

Automatically start podman pod during system (re)boot.

Link container file to user specific config dir:

    cd ~/.config/containers/systemd
    ln -s ~/homelab-devops/podman/immich/immich.container .

Generate unit files from container files:

    systemctl --user daemon-reload

Check unit file was generated:
    
    systemctl --user list-unit-files

## Generating quadlet / systemd auto start

In order to automatically start start the containers after e.g. a reboot, podman recommends using something called quadlets,
which I suppose is an alternative to compose.yaml syntax. `podlet` does not support $ interpolation at the time of writing,
so inline everything that cannot be loaded via env file.

    sudo apt install build-essential
    sudo apt-get install rustup
    rustup default stable
    cargo install podlet
    mkdir quadlet
    podlet --file quadlet compose

Seems podman-generator / systemd doesn't support pods, so leaving out the --pod argument here.

Check that the container files compile into services correctly:

    /usr/lib/systemd/user-generators/podman-user-generator -v ~/.config/containers/systemd/

podlet compose doesn't actually generate complete quadlets, and you must manually create e.g. network units:

    $ cat .config/containers/systemd/immich.network
    [Unit]
    Description=Immich Network
    
    [Network]
    Subnet=192.168.30.0/24
    Gateway=192.168.30.1

And volumes:

    $ cat .config/containers/systemd/immich-model-cache.volume
    [Unit]
    Description=Model Cache Volume
    
    [Volume]

And corresponding entries in the relevant containers:

    Network=immich.network
    Volume=immich-model-cache.volume:/cache
