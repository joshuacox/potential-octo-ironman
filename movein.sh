#!/bin/bash
# move in to oltorf
export BRANCH=ichabod
hostname ichabod.thalhalla.net
echo ichabod.thalhalla.net >/etc/hostname
cd /tmp
wget https://rawgithubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config
mv sshd_config /etc/ssh/
ufw accept 16222
ufw deny ssh
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash
