# Quadlet

Automatically start podman pod during system (re)boot.

NOTE: Using [Pod] (--pod with podlet) requires podman 5.x which is not part of Ubuntu LTS at time of writing (available in 24.10+).

Link container file to user specific config dir:

    find "$PWD/quadlet" -type f -name '*' -exec ln -s {} ~/.config/containers/systemd \;

Generate unit files from container files:

    systemctl --user daemon-reload

Check unit file was generated:
    
    systemctl --user list-unit-files | grep immich

Starting services:

    systemctl --user start immich.pod

Check all dependent services are actually running:

    systemctl --user | grep immich

You can debug relevant information using

    journalctl --user -xeu immich-pod
    journalctl --user -xeu immich-server

## Generating quadlet / systemd auto start

In order to automatically start start the containers after e.g. a reboot, podman recommends using something called quadlets,
which I suppose is an alternative to compose.yaml syntax. `podlet` does not support $ interpolation at the time of writing,
so inline everything that cannot be loaded via env file.

    sudo apt install build-essential
    sudo apt-get install rustup
    rustup default stable
    cargo install podlet
    mkdir quadlet
    podlet --overwrite --file quadlet compose --pod

After generating the quadlets there are a couple of manual steps:

1. Remove redundant prefixes added by the pod e.g. `immich-immich-server.container` become `immich-server.container`
2. Add Install section to pod file to enable it on boot:
   ```
   [Install]
   WantedBy=default.target
   ```

https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html#enabling-unit-files

Once you are happy with the generated quadlets, you can symlink them to your systemd folder:

    find "$PWD/quadlet" -type f -name '*' -exec ln -s {} ~/.config/containers/systemd \;

## Debugging

https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html#debugging-unit-files

Check that the container files compile into services correctly (recommended):

    QUADLET_UNIT_DIRS="$PWD/quadlet" /usr/lib/systemd/system-generators/podman-system-generator --user --dryrun

Alternatively, show only the errors with:

    systemd-analyze {--user} --generators=true verify example.service
