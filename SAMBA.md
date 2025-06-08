# SAMBA

SAMBA filesharing

https://ubuntu.com/tutorials/install-and-configure-samba#1-overview

## Installation

    sudo apt update
    sudo apt install samba

We can check if the installation was successful by running:

    whereis samba

## Adding a shared folder

Now that Samba is installed, we need to create a directory for it to share:

    mkdir /media/movies

The configuration file for Samba is located at /etc/samba/smb.conf. To add the new directory as a share, we edit the file by running:

    sudo vi /etc/samba/smb.conf

At the bottom of the file, add the following lines:

    [sambashare]
        comment = Movies
        path = /media/movies
        read only = no
        browsable = yes

Now that we have our new share configured, save it and restart Samba for it to take effect:

    sudo service smbd restart

Update the firewall rules to allow Samba traffic:

    sudo ufw allow samba
