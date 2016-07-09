#!/bin/bash
# move in to cloudatcost
DEBIAN_FRONTEND=noninteractive
MY_NAME=trusty-cloudatcost-base

cd /tmp
wget -c https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/update.sh
update () {
  bash /tmp/update.sh
}
COUNTZERO=0
while [ $COUNTZERO -lt 4  ]
do
  if [ ! -f /boot/vmlinuz-3.19.0-64-generic ]
    then update
  fi
  COUNTZERO=$[$COUNTZERO+1]
done

cd /tmp
wget -c https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
mv sshd_config /etc/ssh/
# icinga ppa
#add-apt-repository -yqq ppa:formorer/icinga
#apt-get update -yqq
#apt-get upgrade -yqq
#apt-get install -yqq icinga2

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
