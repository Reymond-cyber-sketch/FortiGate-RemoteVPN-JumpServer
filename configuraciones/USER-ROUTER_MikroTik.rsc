# USER-ROUTER - MikroTik CHR

/interface bridge
add name=BR-USERS

/interface bridge port
add bridge=BR-USERS interface=ether2
add bridge=BR-USERS interface=ether5
add bridge=BR-USERS interface=ether6

/ip address
add address=10.10.10.2/30 interface=ether1 comment="Transit hacia FortiGate"
add address=10.24.96.1/25 interface=BR-USERS comment="Gateway usuarios"
add address=10.24.96.129/29 interface=ether4 comment="Gateway WEB-LAN"

/ip pool
add name=POOL-VLAN10 ranges=10.24.96.10-10.24.96.120

/ip dhcp-server
add name=DHCP-VLAN10 interface=BR-USERS address-pool=POOL-VLAN10

/ip dhcp-server network
add address=10.24.96.0/25 gateway=10.24.96.1

/ip route
add dst-address=0.0.0.0/0 gateway=10.10.10.1
