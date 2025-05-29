# OMV

Trying out OMV to compare to other popular alternatives like TrueNAS.

## Requirements

- OS Partition
- Storage partitions for RAID

## Steps

1. Download & install OMV iso image
2. Reset admin password
3. System -> Update Management -> Update all
4. System -> Plugins
   1. Install `openmediavault-md` plugin
6. Storage
   1. Multiple Device -> Create Mirror or RAID 5
   2. File Systems -> Create on mirrored partition
   3. Shared Folders -> Create folder called `home`
7. Users -> Settings
   1. Enable  user home directories
   2. Choose newly created `home` Shared Directory
9. Enable SMB
   1. Enable
   2. Enable home folders
10. Create users
11. Create group for users
12. Create Storage -> Shared Folder
13. Configure static IP?
