#!/bin/sh
while [ -z "$NAME" ]; do read -r -p "Enter the name of the new branch you wish to create [NAME]: " NAME; echo "$NAME">>NAME; cat NAME; done ;
while [ -z "$DOMAIN" ]; do read -r -p "Enter the domain of the new branch you wish to create [DOMAIN]: " DOMAIN; echo "$DOMAIN">>DOMAIN; cat DOMAIN; done ;
while [ -z "$IPADDRESS" ]; do read -r -p "Enter the IP address of the new branch you wish to create [IPADDRESS]: " IPADDRESS; echo "$IPADDRESS">>IPADDRESS; cat IPADDRESS; done ;
git checkout -b $NAME
sed -i "s/REPLACEME_NAME/$NAME/g" README.md
sed -i "s/REPLACEME_NAME/$NAME/g" movein.sh
sed -i "s/REPLACEME_DOMAIN/$DOMAIN/g" movein.sh
sed -i "s/REPLACEME_IPADDRESS/$IPADDRESS/g" movein.sh
git commit -am "$NAME"
git push origin $NAME
rm NAME
rm DOMAIN
rm IPADDRESS
