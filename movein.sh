#!/bin/bash
# move in to cloudatcost
DEBIAN_FRONTEND=noninteractive
MY_NAME=trusty-cloudatcost-base
echo $MY_NAME.monitaur.net >/etc/hostname
hostname $MY_NAME
apt-get update -yq
apt-get install -yq apt-transport-https
apt-get upgrade -yq
# new kernel
apt-get install -yq linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
mv sshd_config /etc/ssh/
# icinga ppa
#add-apt-repository -y ppa:formorer/icinga
#apt-get update -yq
#apt-get upgrade -yq
#apt-get install -yq icinga2

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
