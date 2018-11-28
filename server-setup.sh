#!/bin/bash

# User-data script: 
# cd ~
# git clone https://github.com/jcihocki/openvpn-server-conf.git
# cd openvpn-server-conf
# sudo bash server-setup.sh


cd ~

echo "deb http://build.openvpn.net/debian/openvpn/stable xenial main" > /etc/apt/sources.list.d/openvpn-aptrepo.list
apt-get update
yes|apt-get install expect

export PUBLIC_IP=`curl http://169.254.169.254/latest/meta-data/public-ipv4`

# Install road warrior openvpn setup
wget https://git.io/vpn -O openvpn-install.sh && expect -f automate-road-warrior.sh


# Update openvpn version to latest 2.4 stable for Ubuntu 16

wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg|apt-key add -
apt-get install openvpn

cp server.conf /etc/openvpn/server.conf

/etc/init.d/openvpn restart


