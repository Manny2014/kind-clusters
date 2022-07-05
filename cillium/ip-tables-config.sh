
#API SERVER (get from ~/.kube/config
# --> 127.0.0.1:44647 

# UNDO
# sudo iptables -t nat -v -L PREROUTING -n --line-number
# sudo iptable -t nat -D PREROUTING <line-num>


iptables -t nat -I PREROUTING -i ens8 -p tcp --dport 6443 -j DNAT --to-destination 127.0.0.1:44647
iptables -t nat -I OUTPUT -o lo -p tcp --dport 6443 -j DNAT --to-destination 127.0.0.1:44647

