#!/bin/bash
# move in to
export BRANCH=4-30-111-153-htx.webhosting.coop
hostname 4-30-111-153-htx.webhosting.coop
apt-get update
apt-get -y install byobu vim fail2ban curl
echo 4-30-111-153-htx.webhosting.coop >/etc/hostname
echo 'domain webhosting.coop'>/etc/resolv.conf
echo 'search webhosting.coop'>>/etc/resolv.conf
echo 'nameserver 8.8.8.8' >>/etc/resolv.conf
echo 'nameserver 8.8.4.4' >>/etc/resolv.conf
echo '#ipa2'>>/etc/hosts
echo '65.67.51.189 4-30-111-153-htx.webhosting.coop'>>/etc/hosts
cp /etc/resolv.conf /etc/resolvconf/resolv.conf.d/base
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces > /dev/null 2>&1
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config > /dev/null 2>&1
mv sshd_config /etc/ssh/
echo -e  'y\n'|ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa > /dev/null 2>&1
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash > /dev/null 2>&1
#ufw allow 16222 > /dev/null 2>&1
#ufw deny ssh > /dev/null 2>&1

mkdir /exports

check_if_line_exists()
{
    # grep wont care if one or both files dont exist.
    grep -qsFx "$LINE_TO_ADD" /etc/fstab
}

add_line_to_FSTAB()
{
    FSTAB=/etc/fstab
    [ -w "$FSTAB" ] || FSTAB=/etc/fstab
    printf "%s\n" "$LINE_TO_ADD" >> "$FSTAB"
}


LINE_TO_ADD="/dev/vdb1 /exports ext4 rw 0 0"
check_if_line_exists || add_line_to_FSTAB

echo 'You should reboot 4-30-111-153-htx.webhosting.coop now'
