# Installation of new VirtualBox host

This is an example of installing VirtualBox/Vagrant/Ansible on an Ubuntu server.

## Dependencies

- Ubuntu (24.04)
- OpenSSH

## Networking

Configure a static IP by editing the configuration:

	sudo nvim /etc/netplan/50-cloud-init.yaml

And updating it to look something like this:

```
network:
  version: 2
  ethernets:
    eno1:
      dhcp4: false
      addresses:
        - 192.168.1.100/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
```

Apply configuration:

	sudo netplan apply

## Virtualization

### Ensure host supports virtualization

	sudo apt install cpu-checker
	sudo kvm-ok

### Installing VirtualBox

	sudo apt install virtualbox

This modifies secure boot, which requires you to enter a temporary password, before
rebooting the system, selecting to install "MOK" and re-enter the password on the
target machine.

After installing the MOK and rebooting again, you run:

	sudo apt install --reinstall virtualbox-dkms

If you for some reason dismiss the MOK dialog triggering by installing virtualbox
on the target machine, you can re-enroll using this command:

	sudo mokutil -i /var/lib/shim-signed/mok/MOK.der


### Installing Vagrant

https://developer.hashicorp.com/vagrant/downloads

	wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
	sudo apt update && sudo apt install vagrant

## Errors

## VirtualBox installation error

This error is expected, and probably just means Secure Boot is not permitting virtualbox shenanigans_

```
Setting up virtualbox (7.0.16-dfsg-2ubuntu1.1) ...
Job for virtualbox.service failed because the control process exited with error code.
See "systemctl status virtualbox.service" and "journalctl -xeu virtualbox.service" for details.
invoke-rc.d: initscript virtualbox, action "restart" failed.
× virtualbox.service - LSB: VirtualBox Linux kernel module
     Loaded: loaded (/etc/init.d/virtualbox; generated)
     Active: failed (Result: exit-code) since <datetime> UTC; 8ms ago
       Docs: man:systemd-sysv-generator(8)
    Process: 7532 ExecStart=/etc/init.d/virtualbox start (code=exited, status=1/FAILURE)
        CPU: 55ms

<datetime> <hostname> systemd[1]: Starting virtualbox.service - LSB: VirtualBox Linux kernel module...
<datetime> <hostname> virtualbox[7532]:  * Loading VirtualBox kernel modules...
<datetime> <hostname> virtualbox[7532]:  * modprobe vboxdrv failed. Please use 'dmesg' to find out why
<datetime> <hostname> virtualbox[7532]:    ...fail!
<datetime> <hostname> systemd[1]: virtualbox.service: Control process exited, code=exited, status=1/FAILURE
<datetime> <hostname> systemd[1]: virtualbox.service: Failed with result 'exit-code'.
<datetime> <hostname> systemd[1]: Failed to start virtualbox.service - LSB: VirtualBox Linux kernel module.
```
