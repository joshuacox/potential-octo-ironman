#!/bin/bash
# move in to oltorf
export BRANCH=astaroth
apt-get update
apt-get -y install byobu
hostname octo.webhosting.coop
echo octo.webhosting.coop >/etc/hostname
echo 'domain webhosting.coop'>/etc/resolv.conf
echo 'search webhosting.coop'>>/etc/resolv.conf
echo 'nameserver 8.8.8.8' >>/etc/resolv.conf
echo 'nameserver 8.8.4.4' >>/etc/resolv.conf
echo '#Octo'>>/etc/hosts
echo '65.67.51.188 octo.webhosting.coop'>>/etc/hosts
cp /etc/resolv.conf /etc/resolvconf/resolv.conf.d/base
cd /tmp
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/octoconfigRestore > /dev/null 2>&1
mv octoconfigRestore /usr/local/bin/
chmod +x /usr/local/bin/octoconfigRestore
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/refreshCerts > /dev/null 2>&1
mv refreshCerts /usr/local/bin/
chmod +x /usr/local/bin/refreshCerts
/usr/local/bin/refreshCerts
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces > /dev/null 2>&1
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config > /dev/null 2>&1
mv sshd_config /etc/ssh/
echo -e  'y\n'|ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa > /dev/null 2>&1
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/octoaddus.sh | bash > /dev/null 2>&1
# wget https://raw.githubusercontent.com/joshuacox/octohost/master/bin/octo > /dev/null 2>&1
# mv octo /usr/bin/
# chmod +x /usr/bin/octo
cd /usr/local/bin/
ln -s /usr/bin/gitreceive ./
ufw allow 16222 > /dev/null 2>&1
ufw deny ssh > /dev/null 2>&1

mkdir -p /mktulu/exports
LINE_TO_ADD="65.67.51.187:/mktulu/exports /mktulu/exports nfs rw,vers=4,addr=65.67.51.187,clientaddr=65.67.51.188 0 0"

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

check_if_line_exists || add_line_to_FSTAB
mount /mktulu/exports
echo '#!/bin/bash'>/root/untarexports.sh
echo 'cd /'>>/root/untarexports.sh
echo 'tar zxvf /mktulu/exports/export-astaroth.tar.gz'>>/root/untarexports.sh
echo 'chown -R docker. exports'>>/root/untarexports.sh
chmod +x /root/untarexports.sh

mkdir /etc/consul.d
echo 'You should first untar exports and then reboot Astaroth now (hint look at /root/untarexports.sh)'
