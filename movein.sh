#!/bin/bash
# move in to oltorf
export BRANCH=astaroth
# apt-get update
apt-get -y install byobu
hostname octo.webhosting.coop
# rm -Rf /home/vagrant/.ssh > /dev/null 2>&1
deluser --remove-home --quiet vagrant
echo octo.webhosting.coop >/etc/hostname
echo 'domain webhosting.coop'>/etc/resolv.conf
echo 'search webhosting.coop'>>/etc/resolv.conf
echo 'nameserver 8.8.8.8' >>/etc/resolv.conf
echo 'nameserver 8.8.4.4' >>/etc/resolv.conf
echo '#Octo'>>/etc/hosts
echo '65.67.51.188 octo.webhosting.coop'>>/etc/hosts
cp /etc/resolv.conf /etc/resolvconf/resolv.conf.d/base
mkdir -p /etc/nginx/private
mkdir -p /etc/nginx/certs
cd /tmp
# deprecated this was merged into mainline
# wget https://raw.githubusercontent.com/joshuacox/octohost-cookbook/templateSSL.ctmpl/files/default/templateSSL.ctmpl
# mv templateSSL.ctmpl /etc/nginx/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/octohost > /dev/null 2>&1
mv octohost /etc/default/octohost
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/generateSelfSignedCert > /dev/null 2>&1
mv generateSelfSignedCert /usr/local/bin/
chmod +x /usr/local/bin/generateSelfSignedCert
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/octoconfigRestore > /dev/null 2>&1
mv octoconfigRestore /usr/local/bin/
chmod +x /usr/local/bin/octoconfigRestore
/usr/local/bin/octoconfigRestore
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/consulReset > /dev/null 2>&1
mv consulReset /usr/local/bin/
chmod +x /usr/local/bin/consulReset
/usr/local/bin/consulReset
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/refreshCerts > /dev/null 2>&1
mv refreshCerts /usr/local/bin/
chmod +x /usr/local/bin/refreshCerts
/usr/local/bin/refreshCerts
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/interfaces > /dev/null 2>&1
mv interfaces /etc/network/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/sshd_config > /dev/null 2>&1
mv sshd_config /etc/ssh/
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/export > /dev/null 2>&1
mv export /root/export
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$BRANCH/consulReset > /dev/null 2>&1
mv consulReset /root/consulReset
bash /root/consulReset
cd /root
git clone https://github.com/joshuacox/freezing-cyril.git
cd freezing-cyril
chmod +x LastDocker && cp LastDocker /usr/local/bin/
chmod +x EnterDocker && cp EnterDocker /usr/local/bin/
echo -e  'y\n'|ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa > /dev/null 2>&1
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/octoaddus.sh | bash > /dev/null 2>&1
# wget https://raw.githubusercontent.com/joshuacox/octohost/master/bin/octo > /dev/null 2>&1
# mv octo /usr/bin/
# chmod +x /usr/bin/octo
cd /usr/local/bin/
ln -s /usr/bin/gitreceive ./
ufw allow 9997 > /dev/null 2>&1
ufw allow 9998 > /dev/null 2>&1
ufw allow 9999 > /dev/null 2>&1
ufw allow 9200 > /dev/null 2>&1
ufw allow 9292 > /dev/null 2>&1
ufw allow 9300 > /dev/null 2>&1
ufw allow 5665 > /dev/null 2>&1
ufw allow 16222 > /dev/null 2>&1
ufw deny ssh > /dev/null 2>&1

mkdir -p /mktulu/exports
mkdir -p /exports

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

LINE_TO_ADD="65.67.51.187:/mktulu/exports /mktulu/exports nfs rw,vers=4,addr=65.67.51.187,clientaddr=65.67.51.188 0 0"
check_if_line_exists || add_line_to_FSTAB
LINE_TO_ADD='UUID=0be339b4-634e-4dee-b8e0-04030f238ad7 /exports      ext4 defaults 0 1'
check_if_line_exists || add_line_to_FSTAB
mount /mktulu/exports
echo '#!/bin/bash'>/root/untarexports.sh
echo 'cd /'>>/root/untarexports.sh
echo 'tar zxvf /mktulu/exports/exports-astaroth.tar.gz'>>/root/untarexports.sh
echo 'chown -R docker. exports'>>/root/untarexports.sh
chmod +x /root/untarexports.sh

mkdir -p /etc/consul.d
echo 'You should first untar exports and then reboot Astaroth now (hint look at /root/untarexports.sh)'
