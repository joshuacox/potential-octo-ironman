#!/bin/bash
# move in to cloudatcost
MY_NAME=gluster32
echo $MY_NAME.monitaur.net >/etc/hostname
hostname $MY_NAME
apt-get update -yqq
apt-get install -yqq apt-transport-https
# new kernel
apt-get install -yqq linux-image-generic-lts-vivid linux-headers-generic-lts-vivid
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
mv sshd_config /etc/ssh/
# icinga ppa
add-apt-repository -y ppa:formorer/icinga
apt-get update -yqq
apt-get upgrade -yqq
apt-get install -yqq curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential
apt-get install -yqq icinga2

# roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh|bash
# Install docker
bash /usr/local/bin/UbuntuDockerInstall
# Key me
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash
service docker stop
rm -Rf /var/lib/docker/*
echo 'DOCKER_OPTS="-s overlay"' >> /etc/default/docker
echo 'you need to reboot now to accept the new kernel'
