#firewall
iptables -t nat -A POSTROUTING -o eth2 -s 10.0.1.0/24 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth1 -s 10.0.2.0/24 -j MASQUERADE
