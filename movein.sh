#!/bin/bash
# move in to oltorf
export BRANCH=zaphod
export DOMAIN=thalhalla.net
apt-get update
apt-get install -y git python-pip wget curl sudo encfs uuid-runtime unzip bzip2 rsync vim fail2ban byobu vim ntp
apt-get install -y rake build-essential ruby-dev libgecode-dev qemu qemu-kvm libvirt-bin qemu-utils ebtables dnsmasq bridge-utils dnsmasq virtinst
update-rc.d dnsmasq disable
hostname $BRANCH.$DOMAIN
echo $BRANCH.$DOMAIN >/etc/hostname
echo "domain $DOMAIN">/etc/resolv.conf
echo "search $DOMAIN">>/etc/resolv.conf
echo 'nameserver 8.8.8.8' >>/etc/resolv.conf
echo 'nameserver 8.8.4.4' >>/etc/resolv.conf
echo "#$BRANCH">>/etc/hosts
echo "10.0.23.88 $BRANCH.$HOSTNAME">>/etc/hosts
# cp /etc/resolv.conf /etc/resolvconf/resolv.conf.d/base
# cp /etc/resolv.conf /etc/resolv.conf
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces > /dev/null 2>&1
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config > /dev/null 2>&1
mv sshd_config /etc/ssh/
echo -e  'y\n'|ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa > /dev/null 2>&1
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash > /dev/null 2>&1
cd /opt
git clone https://git.openstack.org/openstack-dev/devstack
cd /usr/local
wget -c https://dl.bintray.com/mitchellh/packer/packer_0.7.5_linux_amd64.zip
cd bin
unzip /usr/local/packer_0.7.5_linux_amd64.zip
