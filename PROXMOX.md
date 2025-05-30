# Proxmox

## Cloud-init

- https://www.youtube.com/watch?v=Kv6-_--y5CM&t=504s
- https://github.com/JamesTurland/JimsGarage/tree/main/Kubernetes/Cloud-Init

### Steps

(modified image url)
(my storage was `local-lvm`)

1. Download the ISO using the GUI: https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
2. Create the VM via CLI
```bash
qm create 5000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
cd /var/lib/vz/template/iso/
qm importdisk 5000 lunar-server-cloudimg-amd64-disk-kvm.img <YOUR STORAGE HERE>
qm set 5000 --scsihw virtio-scsi-pci --scsi0 <YOUR STORAGE HERE>:vm-5000-disk-0
qm set 5000 --ide2 <YOUR STORAGE HERE>:cloudinit
qm set 5000 --boot c --bootdisk scsi0
qm set 5000 --serial0 socket --vga serial0
```
3. Expand the VM disk size to a suitable size (suggested 10 GB)
```bash
qm disk resize 5000 scsi0 10G
```
4. Visit Hardware (VM 5000)
   1. Disable memory balooning (optionally change to 4096MB)
   2. Change Processor to be: Host
   3. Enable HDD SSD Emulation
5. Visit Cloud-Init (VM 5000)
   1. Set User to: ubuntu
   2. Set a password
   3. Add your public SSH key
   4. Enable IP Config: DHCP
7. Right click VM 5000 and click "Convert to Template"
8. Deploy new VMs by cloning the template (full clone)
