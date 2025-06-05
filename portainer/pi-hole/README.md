# Pi-hole on portainer

## Port 53 conflict

Disable systemd-resolved on the docker host:

https://askubuntu.com/questions/1394034/port-conflict-in-pi-hole-docker-installation-with-systemd-resolve-process

Step 5: Stop systemd-resolve from listening on port 53 -

Edit /etc/systemd/resolved.conf - uncomment the line with DNSStubListener and change yes to no.

    DNSStubListener=no

Restart systemd-resolved with:

    sudo systemctl restart systemd-resolved.service

Fix local dns resolution by removing the symlink to the systemd stub-resolv.conf and replace it with a link to a full resolv.conf

    sudo rm /etc/resolv.conf
    sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
