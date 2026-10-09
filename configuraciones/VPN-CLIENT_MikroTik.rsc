# VPN-CLIENT - MikroTik CHR

/ip address
add address=203.0.113.98/30 interface=ether1 comment="WAN hacia ISP"

/ip route
add dst-address=0.0.0.0/0 gateway=203.0.113.97

/ip ipsec profile
add name=FGT-REMOTE-JUMP \
    hash-algorithm=sha256 \
    enc-algorithm=des \
    dh-group=modp2048

/ip ipsec proposal
add name=FGT-REMOTE-JUMP \
    auth-algorithms=sha256 \
    enc-algorithms=des \
    pfs-group=none

/ip ipsec policy group
add name=FGT-REMOTE-JUMP

/ip ipsec policy
add group=FGT-REMOTE-JUMP \
    proposal=FGT-REMOTE-JUMP \
    template=yes

/ip ipsec peer
add name=FGT-REMOTE-JUMP \
    address=198.51.100.98/32 \
    exchange-mode=aggressive \
    profile=FGT-REMOTE-JUMP

/ip ipsec identity
add peer=FGT-REMOTE-JUMP \
    auth-method=pre-shared-key-xauth \
    secret="<PSK-REDACTED>" \
    username="vpnuser" \
    password="<PASSWORD-REDACTED>" \
    generate-policy=port-strict \
    mode-config=request-only \
    policy-template-group=FGT-REMOTE-JUMP

# VPN entrega una IP del pool 10.24.99.10-10.24.99.20
# Split tunnel únicamente hacia 10.24.96.138/32
