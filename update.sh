#!/bin/bash
# update at cloudatcost
DEBIAN_FRONTEND=noninteractive
APT=apt-get  -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew -yqq
$APT update
$APT install apt-transport-https
$APT upgrade
$APT dist-upgrade
$APT install linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential 
