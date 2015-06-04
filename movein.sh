#!/bin/bash
# move in to oltorf
export BRANCH=tyr
hostname tyr.thalhalla.com
echo tyr.thalhalla.com >/etc/hostname
apt-get update
apt-get install -y git python-pip wget curl sudo encfs uuid-runtime unzip bzip2 rsync vim fail2ban byobu vim ntp
apt-get install -y rake build-essential ruby-dev libgecode-dev qemu-kvm libvirt-bin qemu-utils ebtables dnsmasq
gem install bundler
pip install debops ansible netaddr ldap
cd /tmp
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash > /dev/null 2>&1
wget https://raw.githubusercontent.com/thalhalla/potential-octo-ironman/$BRANCH/interfaces
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/thalhalla/potential-octo-ironman/$BRANCH/sshd_config
mv sshd_config /etc/ssh/
