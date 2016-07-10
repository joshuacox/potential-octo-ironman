#!/bin/bash
# update at cloudatcost
export DEBIAN_FRONTEND=noninteractive
apt-get -yqq -o update
apt-get -yqq -o install apt-transport-https
apt-get -yqq -o upgrade
apt-get -yqq -o dist-upgrade
apt-get -yqq -o install \
curl wget unzip vim rsync git byobu \
fail2ban bzip2 sudo build-essential icinga2
