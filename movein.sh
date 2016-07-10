#!/bin/bash
# move in to a jessie machine
# this should be branch name
MY_NAME=jessie-cloudatcost-base
apt-get update -yqq
apt-get install -yqq apt-transport-https netselect-apt
netselect-apt -ns -t 25 -o /etc/apt/sources.list jessie
sed -i 's/centarra/gigenet/g' /etc/apt/sources.list
# debmon sources
wget -O - http://debmon.org/debmon/repo.key 2>/dev/null | apt-key add -
echo 'deb http://debmon.org/debmon debmon-jessie main' >/etc/apt/sources.list.d/debmon.list

cd /tmp
wget -c https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/update.sh
update () {
  bash /tmp/update.sh
}
COUNTZERO=0
while [ $COUNTZERO -lt 4  ]
do
  if [ ! -f /usr/bin/git ]
    then update
  fi
  COUNTZERO=$[$COUNTZERO+1]
done
# SSH
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
mv sshd_config /etc/ssh/

# roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh|bash
# Install docker
bash /usr/local/bin/DebianDockerInstall
# Key me
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash
