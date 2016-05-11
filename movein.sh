#!/bin/bash
# move in to cloudatcost
MY_NAME=zotrusty
echo $MY_NAME.monitaur.net >/etc/hostname
hostname $MY_NAME
apt-get update -yqq
apt-get get install -yqq apt-transport-https
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
mv sshd_config /etc/ssh/
# icinga ppa
add-apt-repository -y ppa:formorer/icinga
apt-get update -yqq
apt-get install -yqq icinga2 curl wget unzip vim rsync git byobu fail2ban bzip2 build-essential

# roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh|bash
# Install docker
bash /usr/local/bin/UbuntuDockerInstall
# Key me
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash
