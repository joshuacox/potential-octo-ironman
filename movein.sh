#!/bin/bash
# move in to a jessie machine
# this should be branch name
MY_NAME=julius
echo $MY_NAME.monitaur.net >/etc/hostname
hostname $MY_NAME
apt-get update -yqq
apt-get install -yqq apt-transport-https netselect-apt
netselect-apt -ns -t 25 -o /etc/apt/sources.list jessie
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
mv sshd_config /etc/ssh/
# debmon sources
wget -O - http://debmon.org/debmon/repo.key 2>/dev/null | apt-key add -
echo 'deb http://debmon.org/debmon debmon-jessie main' >/etc/apt/sources.list.d/debmon.list
apt-get update -yqq
apt-get install -yqq icinga2 curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential

# roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh|bash
# Install docker
bash /usr/local/bin/DebianDockerInstall
# Key me
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash
