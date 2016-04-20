#!/bin/bash
# move in to oltorf
export BRANCH=zotac
export DOMAIN=thalhalla.net
apt-get update
apt-get install -y git python-pip wget curl sudo encfs uuid-runtime unzip bzip2 rsync vim fail2ban byobu vim ntp byobu
apt-get install -y rake build-essential ruby-dev libgecode-dev qemu qemu-kvm libvirt-bin qemu-utils ebtables dnsmasq bridge-utils dnsmasq virtinst
update-rc.d dnsmasq disable
hostname $BRANCH.$DOMAIN
echo $BRANCH.$DOMAIN >/etc/hostname
echo "domain $DOMAIN">/etc/resolv.conf
echo "search $DOMAIN">>/etc/resolv.conf
echo 'nameserver 8.8.8.8' >>/etc/resolv.conf
echo 'nameserver 8.8.4.4' >>/etc/resolv.conf
echo "#$BRANCH">>/etc/hosts
echo "10.0.23.52 $BRANCH.$HOSTNAME">>/etc/hosts
# cp /etc/resolv.conf /etc/resolvconf/resolv.conf.d/base
# cp /etc/resolv.conf /etc/resolv.conf
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces > /dev/null 2>&1
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config > /dev/null 2>&1
mv sshd_config /etc/ssh/
echo -e  'y\n'|ssh-keygen -q -t ecdsa -N "" -f ~/.ssh/id_ecdsa > /dev/null 2>&1
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash > /dev/null 2>&1
cd /usr/local
wget -c https://releases.hashicorp.com/packer/0.10.0/packer_0.10.0_linux_amd64.zip
cd bin
unzip /usr/local/packer_0.10.0_linux_amd64.zip

mkdir -p /$BRANCH/exports

# clients look like this
#LINE_TO_ADD="10.0.23.52:/$BRANCH/exports /$BRANCH/exports nfs rw,vers=4,addr=10.0.23.52,clientaddr=10.0.23.0/24 0 0"
LINE_TO_ADD="/$BRANCH/exports 10.0.23.0/24(rw)"

check_if_line_exists()
{
    # grep wont care if one or both files dont exist.
    grep -qsFx "$LINE_TO_ADD" /etc/exports
}

add_line_to_EXPORTS()
{
    EXPORTS=/etc/exports
    [ -w "$EXPORTS" ] || exports=/etc/exports
    printf "%s\n" "$LINE_TO_ADD" >> "$EXPORTS"
}

check_if_line_exists || add_line_to_EXPORTS

echo "You should reboot $BRANCH now"
cd /tmp
