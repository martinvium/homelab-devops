# Plex

# Downloading

1. Visit https://www.plex.tv/media-server-downloads/?cat=computer&plat=linux#plex-media-server
2. Download the appropriate version of the package e.g. Ubuntu intel/amd64
3. Upload the file to VM from WSL

```
/mnt/c/Users/<username>/Downloads
scp plexmediaserver_1.41.7.9823-59f304c16_amd64.deb ubuntu@192.168.1.x:~/
```

## Installing

https://support.plex.tv/articles/200288586-installation/

SSH to the VM and run

    sudo dpkg -i plexmediaserver_1.19.4.2935-79e214ead_amd64.deb

## Mounting SMB shares

https://forums.plex.tv/t/how-to-mount-media-from-your-nas-shares-on-linux-using-cifs-smb/197957

    sudo apt-get install cifs-utils
    sudo mkdir /media/movies
    sudo chown plex:plex /media/movies/
    sudo chmod 755 /media/movies/

Create "plex" user in SMB host and grant access to the movies SMB share.

Add credentials to `/etc/plex.cred`:

    sudo vim /etc/plex.cred

Example credentials:

    username=plex
    password=<password>

Secure username and password:

    sudo chmod 600 /etc/plex.cred

Add the following to `/etc/fstab`:

    //192.168.1.x/movies  /media/movies   cifs    credentials=/etc/plex.cred,uid=999,gid=988,vers=3.0,nounix  0   0

Use `id` or `cat /etc/password | grep plex` to find uid/gid

### Additional reading

https://support.plex.tv/articles/201122318-mounting-network-resources/
https://web.archive.org/web/20130822142600/https://help.ubuntu.com/community/MountWindowsSharesPermanently
https://askubuntu.com/questions/1341844/how-do-i-permanently-mount-a-windows-network-share-in-ubuntu
