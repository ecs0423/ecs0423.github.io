#!/bin/sh
# change web password
echo "ecs2018gw
ecs2018gw
" | passwd

# setup firewall
# iptables -I INPUT -p tcp --dport 443 -j DROP;iptables -I INPUT -s 118.163.94.0/8 -p tcp --dport 443 -j ACCEPT
# 22: ssh
# iptables -I INPUT -p tcp --dport 22 -j DROP;iptables -I INPUT -s 118.163.94.0/8 -p tcp --dport 22 -j ACCEPT
# iptables -I INPUT -p tcp --dport 8080 -j DROP;iptables -I INPUT -s 125.227.58.0/8 -p tcp --dport 8080 -j ACCEPT
# iptables -I INPUT -p tcp --dport 502 -j DROP;iptables -I INPUT -s 125.227.58.0/8 -p tcp --dport 502 -j ACCEPT
# iptables -I INPUT -p tcp --dport 503 -j DROP;iptables -I INPUT -s 125.227.58.0/8 -p tcp --dport 503 -j ACCEPT
# iptables-save

# get replace file
wget --no-check-certificate http://oknow23.github.io/restart_app.tgz
tar xvzf restart_app.tgz
mv nginx_passwd /etc/nginx/
mv restart_app.sh /opt/gateway;mv rc.local /etc;rm -f restart_app.tgz;rm -f update.sh

# change back dns server
sed -i 's/8.8.8.8/127.0.0.1/g' /etc/resolv.conf;cat /etc/resolv.conf
echo 'Done!'
