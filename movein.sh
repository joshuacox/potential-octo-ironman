#!/bin/bash
# move in to oltorf
BRANCH=ipa3
IP_ADDR=65.67.51.185
deluser --force --remove-home --remove-all-files vagrant
rm -rf /home/vagrant
hostname $BRANCH.webhosting.coop
apt-get update
apt-get -y install byobu vim fail2ban curl
echo $BRANCH.webhosting.coop >/etc/hostname
echo 'domain webhosting.coop'>/etc/resolv.conf
echo 'search webhosting.coop'>>/etc/resolv.conf
echo 'nameserver 8.8.8.8' >>/etc/resolv.conf
echo 'nameserver 8.8.4.4' >>/etc/resolv.conf
echo "# $BRANCH">>/etc/hosts
echo "$IP_ADDR $BRANCH.webhosting.coop">>/etc/hosts
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

LINE_TO_ADD="65.67.51.187:/mktulu/exports /exports nfs rw,vers=4,addr=65.67.51.187,clientaddr=$IP_ADDR 0 0"
check_if_line_exists || add_line_to_FSTAB

LINE_TO_ADD="/dev/vdb1 /var/lib/docker ext4 rw 0 0"
check_if_line_exists || add_line_to_FSTAB

LINE_TO_ADD="/dev/vdc1 /exports ext4 rw 0 0"
check_if_line_exists || add_line_to_FSTAB

curl https://gist.githubusercontent.com/joshuacox/25f7228a33e96f78d2a5/raw/44f6a574b08a9f93047a1d642eb705363b3d7bcb/docker2overlay|bash
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=1/' /etc/default/grub
sed -i 's/GRUB_HIDDEN_TIMEOUT_QUIET=.*/GRUB_HIDDEN_TIMEOUT_QUIET=false/' /etc/default/grub
sed -i 's/GRUB_HIDDEN_TIMEOUT=.*/GRUB_HIDDEN_TIMEOUT_QUIET=/' /etc/default/grub
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT=""/' /etc/default/grub
update-grub2

echo "You should reboot $BRANCH.webhosting.coop now"
