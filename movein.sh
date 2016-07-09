#!/bin/bash
# move in to cloudatcost
DEBIAN_FRONTEND=noninteractive
apt-get update -yqq/ &>/dev/null ; \
apt-get install -yqq/ apt-transport-https &>/dev/null ; \
apt-get upgrade -yqq/ &>/dev/null ; \
apt-get dist-upgrade -yqq/ &>/dev/null ; \
echo 0
apt-get install -yqq/ linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential &>/dev/null
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
mv sshd_config /etc/ssh/
# icinga ppa
#add-apt-repository -yqq/ ppa:formorer/icinga
#apt-get update -yqq/
#apt-get upgrade -yqq/
#apt-get install -yqq/ icinga2

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
