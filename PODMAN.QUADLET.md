# Quadlet

Automatically start podman pod during system (re)boot.

Link container file to user specific config dir:

    cd ~/.config/containers/systemd
    ln -s ~/homelab-devops/podman/immich/immich.container .

Generate unit files from container files:

    systemctl --user daemon-reload

Check unit file was generated:
    
    systemctl --user list-unit-files
