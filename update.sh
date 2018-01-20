#!/bin/bash
# update
export DEBIAN_FRONTEND=noninteractive
apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew update
apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew install apt-transport-https
apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew upgrade
apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew dist-upgrade
apt-get -yqq -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew \
  install linux-image-generic linux-headers-generic \
  curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential \
  htop sysstat iotop
