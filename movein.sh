#!/bin/bash
# move in to GCE
DEBIAN_FRONTEND=noninteractive
MY_NAME=id-thalhalla-com
MY_HOSTNAME=id.thalhalla.com

echo $MY_HOSTNAME > /etc/hostname
hostname $MY_HOSTNAME
hostnamectl set-hostname $MY_HOSTNAME

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
https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/id-thalhalla-com-1/sshd_config
mv sshd_config /etc/ssh/
# icinga ppa
#add-apt-repository -yqq ppa:formorer/icinga
#apt-get update -yqq
#apt-get upgrade -yqq
#apt-get install -yqq icinga2

# Install docker
#   with roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/UbuntuDockerInstall|bash
# Key me
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash
systemctl stop docker
echo 'DOCKER_OPTS="-s overlay"' >> /etc/default/docker
rm -Rf /var/lib/docker/*
echo 'LABEL=docker-id1 /var/lib/docker ext4 rw,relatime,data=ordered 0 0' >> /etc/fstab
echo 'LABEL=exports-id1 /exports ext4 rw,relatime,data=ordered 0 0' >> /etc/fstab
mount /var/lib/docker
mount /exports
#systemctl start docker
echo 'you need to reboot now to accept the new kernel'
