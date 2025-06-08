# ZFS

## Installing ZFS on Ubuntu

https://ubuntu.com/tutorials/setup-zfs-storage-pool#4-checking-pool-status

    sudo apt install zfsutils-linux

Check ZFS is correctly installed using:

    whereis zfs

Check installed drives by running:

    sudo fdisk -l

Carefully note down the device names of drives you want to pool.

## Moving ZFS pool after re-install

After re-installing the host system, to recover the pools, you get an error trying to create a pool using the existing drives:

    sudo zpool create data mirror /dev/sda1 /dev/sdb1
    invalid vdev specification
    use '-f' to override the following errors:
    /dev/sda1 is part of potentially active pool 'data'
    /dev/sdb1 is part of potentially active pool 'data'

You can reimport the pool using the following command:

    sudo zpool import -f data

Now the pool should be ONLINE:

    sudo zpool list
