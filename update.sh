#!/bin/bash
# update at cloudatcost
export DEBIAN_FRONTEND=noninteractive
apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew update
apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew install apt-transport-https
apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew upgrade
apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew dist-upgrade
apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew install linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential 
