#!/bin/sh

if ! grep "uptun" /proc/net/dev > /dev/null; then
    ip tuntap add name uptun mode tun
fi
ip addr del 45.45.0.1/16 dev uptun 2> /dev/null
ip addr add 45.45.0.1/16 dev uptun
ip addr del cafe::1/64 dev uptun 2> /dev/null
ip addr add cafe::1/64 dev uptun
ip link set uptun up

sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -I INPUT -i uptun -j ACCEPT

