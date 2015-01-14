#!/bin/bash
# move in to oltorf
#hostname octo.webhosting.coop
#echo octo.webhosting.coop >/etc/hostname
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/saruman/ifcfg-eth0
mv ifcfg-eth0 /etc/sysconfig/network-scripts/
#wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/saruman/sshd_config
#mv sshd_config /etc/ssh/
