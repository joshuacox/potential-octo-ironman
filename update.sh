#!/bin/bash
# update at cloudatcost
export DEBIAN_FRONTEND=noninteractive
APT_GET_CMD='apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew'

${APT_GET_CMD} update
${APT_GET_CMD} install apt-transport-https
${APT_GET_CMD} upgrade
${APT_GET_CMD} dist-upgrade
${APT_GET_CMD} install curl wget unzip vim \
  nfs-common rsync git byobu fail2ban bzip2 build-essential
