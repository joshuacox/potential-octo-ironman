#!/bin/bash
# move in to oltorf
export BRANCH=astaroth
hostname octo.webhosting.coop
echo octo.webhosting.coop >/etc/hostname
cd /tmp
wget https://rawgithubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config
mv sshd_config /etc/ssh/
https://raw.githubusercontent.com/joshuacox/octohost/master/bin/octo
mv octo /usr/bin/
ufw accept 16222
ufw deny ssh
