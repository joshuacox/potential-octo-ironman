#!/bin/bash
# move in to oltorf
export BRANCH=mktulu
hostname mktulu.thalhalla.net
echo mktulu.thalhalla.net >/etc/hostname
apt-get update -qq
apt-get install -y -qq git python-pip wget curl sudo encfs
pip install debops ansible netaddr ldap
cd /tmp
wget https://rawgithubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config
mv sshd_config /etc/ssh/
