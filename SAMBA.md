# SAMBA

SAMBA filesharing

https://ubuntu.com/tutorials/install-and-configure-samba#1-overview
https://wiki.samba.org/index.php/Setting_up_Samba_as_a_Standalone_Server

## Installation

    sudo apt update
    sudo apt install samba

We can check if the installation was successful by running:

    whereis samba

## Group for users accessing shared folders

    sudo groupadd family

Adding users to the group

    sudo usermod -a -G family username

## Adding a shared folder

Now that Samba is installed, we need to create a directory for it to share:

    sudo mkdir /media/movies
    sudo chown :family /media/movies

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

## Adding users

https://wiki.samba.org/index.php/Setting_up_Samba_as_a_Standalone_Server

    useradd -s /sbin/nologin username
    passwd username
    smbpasswd -a username

Any password can be used for `passwd` since the user cannot login anyways without a shell.

## Configuring SAMBA to also create local users

Samba can be configured to automatically create linux user accounts after successful samba authentication, using the [global] add user script smb.conf option. Unfortunately this option does not work as intended at end-user access time, but it can be leveraged to simplify adding users to your samba Standalone Server. Because, when adding a samba user with

    # smbpasswd -a demoUser
    New SMB password: Passw0rd
    Retype new SMB password: Passw0rd
    Added user demoUser.

Samba will automatically call the configured add user script, and create the local linux user for you.

A very simple sample add_user.sh script could be something like:

    #!/bin/bash
    adduser --no-create-home --shell /usr/sbin/nologin --user-group $1

Both the linux and the samba user will be deleted with

    # pdbedit -x demoUser
