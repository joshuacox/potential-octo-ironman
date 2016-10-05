#!/bin/bash
# move in to a jessie machine
# this should be branch name
TMP=mktemp -d --suffix=MOVETMP
MY_NAME=monitaurpi
echo $MY_NAME.monitaur.net >/etc/hostname
hostname $MY_NAME
apt-get update -yqq
apt-get install -yqq apt-transport-https netselect-apt
#netselect-apt -ns -t 25 -o /etc/apt/sources.list jessie
#sed -i 's/centarra/gigenet/g' /etc/apt/sources.list
cd $TMP
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/$MY_NAME/sshd_config
mv sshd_config /etc/ssh/
# debmon sources
wget -O - http://debmon.org/debmon/repo.key 2>/dev/null | apt-key add -
echo 'deb http://debmon.org/debmon debmon-jessie main' >/etc/apt/sources.list.d/debmon.list
apt-get update -yqq
apt-get install -yqq icinga2 curl wget unzip vim \
rsync git byobu fail2ban bzip2 sudo build-essential \
wvdial ppp elinks hostapd dnsmasq autossh \
python-dev python-pip

# beaver
pip install beaver

# roustabout
curl https://raw.githubusercontent.com/joshuacox/roustabout/master/bootstraproustabout.sh|bash

# Key me
echo -e 'y\n'|ssh-keygen -q -t ecdsa -N "" -f ~/.ssh/id_ecdsa > /dev/null 2>&1
curl https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/addus.sh | bash

wget https://raw.github.com/lurch/rpi-serial-console/master/rpi-serial-console -O /usr/bin/rpi-serial-console && sudo chmod +x /usr/bin/rpi-serial-console
/usr/bin/rpi-serial-console disable

cd $TMP
git clone https://github.com/oblique/create_ap
cd create_ap
make install

cat >> /etc/create_ap.conf << EOF
CHANNEL=default
GATEWAY=10.0.56.1
WPA_VERSION=2
SHARE_METHOD=nat
NO_VIRT=1
COUNTRY=US
DAEMONIZE=0
WIFI_IFACE=wlan0
INTERNET_IFACE=eth0
SSID=1105oltorf.webhosting.coop
PASSPHRASE=REPLACEME_PASSPHRASE
USE_PSK=0
EOF

REPLACEME_PASSPHRASE=tr -cd '[:alnum:]' < /dev/urandom | fold -w8 | head -n1
sed -i "s/REPLACEME_PASSPHRASE/$REPLACEME_PASSPHRASE/" /etc/create_ap.conf

wget https://raw.githubusercontent.com/adafruit/FONA_PPP/master/fona -O /etc/ppp/peers/ting
sed -i 's/\*\*\*\*/wholesale/g' /etc/ppp/peers/ting
sed -i 's!^#/dev/ttyAMA0!/dev/ttyS0!g' /etc/ppp/peers/ting

echo "auto ting" > /etc/network/interfaces.d/ppp0
echo "iface ting inet ppp" >> /etc/network/interfaces.d/ppp0
echo "    provider ting" >> /etc/network/interfaces.d/ppp0

mkdir -p /root/git
cd /root/git

git clone https://github.com/joshuacox/local-debian.git
git clone https://github.com/joshuacox/local-nginx.git
git clone https://github.com/joshuacox/mkdomoticz.git
git clone https://github.com/joshuacox/mkTrojanHorse.git

cd /root/git/local-debian
make stretch
cd /root/git/local-nginx
make temp
sleep 10
make grab
make prod
cd /root/git/mkdomoticz
make init
sleep 10
make grab
make run

cat >> /root/restart.sh << EOFRESTART
EOFRESTART
chmod +x /root/restart.sh

line='@reboot /bin/bash /root/restart.sh'
(crontab -u root -l; echo "$line" ) | crontab -u root -

rm -Rf $TMP
