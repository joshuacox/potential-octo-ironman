#!/bin/bash
# move in to oltorf
export BRANCH=octo
hostname octo.webhosting.coop
echo octo.webhosting.coop >/etc/hostname
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config
#mv sshd_config /etc/ssh/
wget https://raw.githubusercontent.com/joshuacox/octohost/master/bin/octo
echo -e  'y\n'|ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash
mv octo /usr/bin/
ufw accept 16222
ufw deny ssh
