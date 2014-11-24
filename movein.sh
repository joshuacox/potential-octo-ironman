#!/bin/bash
# move in to oltorf
hostname octo.webhosting.coop
echo octo.webhosting.coop >/etc/hostname
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/master/interfaces
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/master/sshd_config
mv sshd_config /etc/ssh/
https://raw.githubusercontent.com/joshuacox/octohost/master/bin/octo
mv octo /usr/bin/
ufw accept 16222
ufw deny ssh
