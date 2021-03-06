#!/bin/bash

# User-data script:
# cd ~
# git clone https://github.com/jcihocki/openvpn-server-conf.git
# cd openvpn-server-conf
# sudo bash server-setup.sh


# Add openvpn repos to apt
wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg|apt-key add -
export UVERSION=`lsb_release -a|tail -n 1|cut -f 2`
echo "deb http://build.openvpn.net/debian/openvpn/stable ${UVERSION} main" > /etc/apt/sources.list.d/openvpn-aptrepo.list
apt-get update

# Expect allows us to script user input to the road warrior script
yes|apt-get install expect


# Install road warrior openvpn setup, scripting input with expect tool
export PUBLIC_IP=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
wget https://git.io/vpn -O ../openvpn-install.sh && expect -f automate-road-warrior.sh


# Update openvpn version to latest 2.4 stable for Ubuntu 16
yes|apt-get install openvpn

# Update server config
cp server.conf /etc/openvpn/server/server-1194.conf

systemctl stop openvpn

# make sure of it
killall /usr/sbin/openvpn

systemctl enable openvpn-server@server-1194.service
systemctl start openvpn-server@server-1194.service
