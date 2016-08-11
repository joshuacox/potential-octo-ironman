#!/bin/bash
# move in to oltorf
export BRANCH=orange.freeipa
export DOMAIN=monitaur.net
hostname $BRANCH.$DOMAIN
#echo $BRANCH.$DOMAIN >/etc/hostname
#echo "domain $DOMAIN">/etc/resolv.conf
#echo "search $DOMAIN">>/etc/resolv.conf
echo 'nameserver 8.8.8.8' >>/etc/resolv.conf
echo 'nameserver 8.8.4.4' >>/etc/resolv.conf
echo 'DNS1=8.8.8.8' >>/etc/sysconfig/network-scripts/ifcfg-eth0
echo 'DNS2=8.8.4.4' >>/etc/sysconfig/network-scripts/ifcfg-eth0
#echo "#$BRANCH">>/etc/hosts
#echo "$IP_ADDRESS $BRANCH.$HOSTNAME">>/etc/hosts
cp /etc/resolv.conf /etc/resolvconf/resolv.conf.d/base
cd /tmp
#wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config > /dev/null 2>&1
#mv sshd_config /etc/ssh/
echo -e  'y\n'|ssh-keygen -q -t ecdsa -N "" -f ~/.ssh/id_ecdsa > /dev/null 2>&1
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash > /dev/null 2>&1


# yum
yum  -y update
yum  -y install epel-release
yum  -y install vim  fail2ban git bind-utils

# Docker
curl -fsSL https://get.docker.com/ | sh
service docker start
chkconfig docker on

# Install Packer
#cd /usr/local
#wget -c https://releases.hashicorp.com/packer/0.10.0/packer_0.10.0_linux_amd64.zip
#cd bin
#unzip /usr/local/packer_0.10.0_linux_amd64.zip

#mkdir -p /$BRANCH/exports

# clients look like this
#LINE_TO_ADD="10.0.23.52:/$BRANCH/exports /$BRANCH/exports nfs rw,vers=4,addr=10.0.23.52,clientaddr=10.0.23.0/24 0 0"
#LINE_TO_ADD="/$BRANCH/exports 10.0.23.0/24(rw)"

#mkdir /$BRANCH/exports

check_if_line_exists()
{
    # grep wont care if one or both files dont exist.
    grep -qsFx "$LINE_TO_ADD" /etc/exports
}

add_line_to_EXPORTS()
{
    EXPORTS=/etc/fstab
    [ -w "$EXPORTS" ] || exports=/etc/exports
    printf "%s\n" "$LINE_TO_ADD" >> "$EXPORTS"
}

#cd /tmp
#LINE_TO_ADD="65.67.51.187:/mktulu/exports /exports nfs rw,vers=4,addr=65.67.51.187,clientaddr=65.67.51.188 0 0"
#check_if_line_exists || add_line_to_FSTAB

#LINE_TO_ADD="/dev/vdb1 /var/lib/docker btrfs rw 0 0"
#check_if_line_exists || add_line_to_FSTAB

#LINE_TO_ADD="/dev/vdc1 /exports btrfs rw 0 0"
#check_if_line_exists || add_line_to_FSTAB

#echo "You should reboot $BRANCH.$DOMAIN now"
