#!/bin/bash
# move in to cloudatcost
echo warthog.monitaur.net >/etc/hostname
apt-get update -yqq
apt-get get install -yqq apt-transport-https
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/warthog/sshd_config
mv sshd_config /etc/ssh/
# debmon sources
wget -O - http://debmon.org/debmon/repo.key 2>/dev/null | apt-key add -
echo 'deb http://debmon.org/debmon debmon-jessie main' >/etc/apt/sources.list.d/debmon.list
apt-get update -yqq
apt-get install -yqq icinga2 curl wget unzip vim rsync git byobu

# roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh|bash
# Install docker
bash /usr/local/bin/DebianDockerInstall
# Key me
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash

