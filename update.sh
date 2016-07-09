#!/bin/bash
# update at cloudatcost
DEBIAN_FRONTEND=noninteractive
apt-get update -yqq ; \
apt-get install -yqq apt-transport-https ; \
apt-get upgrade -yqq ; \
apt-get dist-upgrade -yqq ; \
apt-get install -yqq linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential 
