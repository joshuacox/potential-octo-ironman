#!/bin/bash
# move in to oltorf
export BRANCH=dackero
hostname im.deploycoop.com.
echo im.deploycoop.com. >/etc/hostname
cd /tmp
wget https://rawgithubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config
mv sshd_config /etc/ssh/
ufw accept 16222
ufw deny ssh
