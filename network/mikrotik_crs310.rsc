# 2026-01-31 15:58:38 by RouterOS 7.21.1
# software id = 2VI1-GK8N
#
# model = CRS310-8G+2S+
# serial number = HG909WQVNFB
/interface bridge
add admin-mac=D4:01:C3:62:50:2C auto-mac=no comment=defconf name=bridge
/interface ethernet
set [ find default-name=ether1 ] comment=WAN
/interface list
add name=WAN
add name=LAN
/interface bridge port
add bridge=bridge comment=defconf interface=ether1
add bridge=bridge comment=defconf interface=ether2
add bridge=bridge comment=defconf interface=ether3
add bridge=bridge comment=defconf interface=ether4
add bridge=bridge comment=defconf interface=ether5
add bridge=bridge comment=defconf interface=ether6
add bridge=bridge comment=defconf interface=ether7
add bridge=bridge comment=defconf interface=ether8
add bridge=bridge comment=defconf interface=sfp-sfpplus1
add bridge=bridge comment=defconf interface=sfp-sfpplus2
/ip firewall connection tracking
set udp-timeout=10s
/interface list member
add interface=ether1 list=WAN
add interface=ether2 list=LAN
add interface=ether3 list=LAN
add interface=ether4 list=LAN
add interface=ether5 list=LAN
add interface=ether6 list=LAN
add interface=ether7 list=LAN
add interface=ether8 list=LAN
add interface=sfp-sfpplus1 list=LAN
add interface=sfp-sfpplus2 list=LAN
/interface ovpn-server server
add mac-address=FE:91:49:9E:39:08 name=ovpn-server1
/ip address
add address=192.168.1.2/24 comment=defconf interface=ether2 network=192.168.1.0
/ip dns
set servers=1.1.1.1
/ip hotspot profile
set [ find default=yes ] html-directory=hotspot
/ip ipsec profile
set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/system clock
set time-zone-name=Europe/Copenhagen
/system identity
set name="MikroTik CRS310"
