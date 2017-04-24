#!/bin/bash
# move in to xenial
DEBIAN_FRONTEND=noninteractive
MY_NAME=xenial
TMP=$(mktemp -d --suffix=updatetmp)

cd /tmp
wget -c https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/update.sh
update () {
  bash /tmp/update.sh
}

cd /tmp
#wget -c https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
#mv sshd_config /etc/ssh/
# icinga ppa
#add-apt-repository -yqq ppa:formorer/icinga
#apt-get update -yqq
#apt-get upgrade -yqq
#apt-get install -yqq icinga2

# roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh|bash
# sprunge
curl -s https://raw.githubusercontent.com/joshuacox/sprunge/master/install.sh |bash

# Install docker
bash /usr/local/bin/XenialDockerInstall
# Key me
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/myaddus.sh | bash
systemctl docker stop
rm -Rf /var/lib/docker/*
echo 'DOCKER_OPTS="-s overlay"' >> /etc/default/docker
echo 'you need to reboot now to accept the new kernel'
rm -Rf ${TMP}

useradd whc
gpasswd -a whc docker
# gits
mkdir -p /home/whc/git
cd /home/whc/git

git clone https://github.com/joshuacox/docker-icinga2.git
git clone https://github.com/joshuacox/mkmattermost.git
git clone https://github.com/joshuacox/mkRedmine.git
git clone https://github.com/joshuacox/docker-gitlab.git
cd docker-gitlab;git checkout envfile
