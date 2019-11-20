#!/bin/bash



iptab=$(iptables -L -vn -t raw| grep "PREROUTING\|spt:80\|spt:443" | awk -F ":" '{print $2}' | sed -n "2,1p")

if [ "${iptab}" != "80 NOTRACK" ] ; then

iptables -t raw -I PREROUTING -p tcp  --sport 443 -j NOTRACK
iptables -t raw -I PREROUTING -p tcp  --sport 80 -j NOTRACK

echo "iptables -t raw -I PREROUTING -p tcp  --sport 80 -j NOTRACK" >> /etc/rc.local
echo "iptables -t raw -I PREROUTING -p tcp  --sport 443 -j NOTRACK" >> /etc/rc.local


iptables -L -vn -t raw

else
RED='\033[0;32m'
NC='\033[0m'
echo -e "iptables raw is existed. check you iptables list. ${RED}Please follow the instructions (iptables -L -vn -t raw)${NC}"

fi
