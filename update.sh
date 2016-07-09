#!/bin/bash
# update at cloudatcost
export DEBIAN_FRONTEND=noninteractive
apt-get  -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew -yqq update
apt-get  -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew -yqq install apt-transport-https
apt-get  -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew -yqq upgrade
apt-get  -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew -yqq dist-upgrade
apt-get  -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew -yqq install linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential 
