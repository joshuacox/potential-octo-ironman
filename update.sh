#!/bin/bash
# move in to cloudatcost
DEBIAN_FRONTEND=noninteractive
MY_NAME=trusty-cloudatcost-base
apt-get update -yqq &>/dev/null ; \
apt-get install -yqq apt-transport-https &>/dev/null ; \
apt-get upgrade -yqq &>/dev/null ; \
apt-get dist-upgrade -yqq &>/dev/null ; \
apt-get install -yqq linux-image-generic-lts-vivid linux-headers-generic-lts-vivid \
curl wget unzip vim rsync git byobu fail2ban bzip2 sudo build-essential &>/dev/null
