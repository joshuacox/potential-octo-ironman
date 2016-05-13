#!/bin/bash
# move in to oltorf
export BRANCH=rose
export DOMAIN=webhosting.coop
export IP_ADDRESS=104.233.77.64
hostname $BRANCH.$DOMAIN
#echo $BRANCH.$DOMAIN >/etc/hostname
#echo "domain $DOMAIN">/etc/resolv.conf
#echo "search $DOMAIN">>/etc/resolv.conf
echo 'nameserver 8.8.8.8' >>/etc/resolv.conf
echo 'nameserver 8.8.4.4' >>/etc/resolv.conf
echo 'DNS1=8.8.8.8' >>/etc/sysconfig/network-scripts/ifcfg-eth0
echo 'DNS2=8.8.4.4' >>/etc/sysconfig/network-scripts/ifcfg-eth0
echo "#$BRANCH">>/etc/hosts
echo "$IP_ADDRESS $BRANCH.$HOSTNAME">>/etc/hosts
#cp /etc/resolv.conf /etc/resolvconf/resolv.conf.d/base
cd /tmp
#wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config > /dev/null 2>&1
#mv sshd_config /etc/ssh/
echo -e  'y\n'|ssh-keygen -q -t ecdsa -N "" -f ~/.ssh/id_ecdsa > /dev/null 2>&1
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash > /dev/null 2>&1

# Docker
curl -fsSL https://get.docker.com/ | sh
service docker start
chkconfig docker on

# yum
yum  -y update
yum  -y install vim 

echo "You should reboot $BRANCH.$DOMAIN now"
