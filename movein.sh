#!/bin/bash
# move in to cloudatcost
export DEBIAN_FRONTEND=noninteractive
MY_NAME=trusty-cloudatcost-base
apt-get update -y ; \
apt-get install -y apt-transport-https ; \
apt-get upgrade -y ; \
apt-get dist-upgrade -y ; \
echo 0 2>/dev/null
apt-get install -y linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential
apt-get update -y ; \
apt-get install -y apt-transport-https ; \
apt-get upgrade -y ; \
apt-get dist-upgrade -y ; \
echo 0 2>/dev/null
apt-get install -y linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential
apt-get update -y ; \
apt-get install -y apt-transport-https ; \
apt-get upgrade -y ; \
apt-get dist-upgrade -y ; \
echo 0 2>/dev/null
apt-get install -y linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential
apt-get update -y ; \
apt-get install -y apt-transport-https ; \
apt-get upgrade -y ; \
apt-get dist-upgrade -y ; \
echo 0 2>/dev/null
apt-get install -y linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
mv sshd_config /etc/ssh/
# icinga ppa
#add-apt-repository -y ppa:formorer/icinga
#apt-get update -y
#apt-get upgrade -y
#apt-get install -y icinga2

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
