# ZFS

## Moving ZFS pool after re-install

See the available disks

    sudo fdisk -l

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
