#!/bin/bash
# move in to oltorf
#apt-get update
apt-get install -y qemu-kvm libvirt-bin bridge-utils dnsmasq
update-rc.d dnsmasq disable
export BRANCH=zaphod
export DOMAIN=thalhalla.net
hostname $BRANCH.$DOMAIN
echo $BRANCH.$DOMAIN >/etc/hostname
echo "domain $DOMAIN">/etc/resolv.conf
echo "search $DOMAIN">>/etc/resolv.conf
echo 'nameserver 8.8.8.8' >>/etc/resolv.conf
echo 'nameserver 8.8.4.4' >>/etc/resolv.conf
echo "#$BRANCH">>/etc/hosts
echo "10.0.23.88 $BRANCH.$HOSTNAME">>/etc/hosts
cp /etc/resolv.conf /etc/resolvconf/resolv.conf.d/base
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces > /dev/null 2>&1
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config > /dev/null 2>&1
mv sshd_config /etc/ssh/
echo -e  'y\n'|ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa > /dev/null 2>&1
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash > /dev/null 2>&1
