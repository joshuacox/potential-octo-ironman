#!/bin/bash
# move in to oltorf
export BRANCH=mktulu
hostname mktulu.thalhalla.net
echo mktulu.thalhalla.net >/etc/hostname
apt-get update
apt-get install -y git python-pip wget curl sudo encfs uuid-runtime unzip bzip2 rsync vim fail2ban rake build-essential ruby-dev
gem intall bundler
pip install debops ansible netaddr ldap
cd /tmp
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash > /dev/null 2>&1
wget https://rawgithubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config
mv sshd_config /etc/ssh/
