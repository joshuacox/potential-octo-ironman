#!/bin/bash
# move in to xenial
DEBIAN_FRONTEND=noninteractive
MY_NAME=xenial
TMP=$(mktemp -d --suffix=updatetmp)

cd ${TMP}
wget -c https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/update.sh
update () {
  bash ${TMP}//update.sh
}

#wget -c https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
#mv sshd_config /etc/ssh/

cd ${TMP}
# roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh|bash
# sprunge
curl -s https://raw.githubusercontent.com/joshuacox/sprunge/master/install.sh |bash

# Install docker
bash /usr/local/bin/XenialDockerInstall
# Key me
mkdir -p /root/.ssh
chmod 0600 /root/.ssh
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/myaddus.sh | bash
rm -Rf ${TMP}

#WHC
useradd whc
gpasswd -a whc docker
# gits
mkdir -p /home/whc/git
mkdir -p /home/whc/.ssh
cp /root/.ssh/authorized_keys /home/whc/.ssh/authorized_keys
cd /home/whc/git

git clone https://github.com/joshuacox/docker-icinga2.git
git clone https://github.com/joshuacox/mkmattermost.git
git clone https://github.com/joshuacox/mkRedmine.git
git clone https://github.com/joshuacox/docker-gitlab.git
cd docker-gitlab;git checkout envfile

#chown and chmod
chown -R whc. /home/whc
chmod 0600 /home/whc/.ssh
