#!/bin/sh
while [ -z "$NAME" ]; do read -r -p "Enter the name of the new branch you wish to create [NAME]: " NAME; echo "$NAME">>NAME; cat NAME; done ;
while [ -z "$IPADDRESS" ]; do read -r -p "Enter the name of the new branch you wish to create [IPADDRESS]: " IPADDRESS; echo "$IPADDRESS">>IPADDRESS; cat IPADDRESS; done ;
git checkout -b $NAME
sed -i "s/REPLACEME_NAME/$NAME/g" README.md
sed -i "s/REPLACEME_IPADDRESS/$IPADDRESS/g" README.md
sed -i "s/REPLACEME_NAME/$NAME/g" movein.sh
git commit -am "$NAME"
git push origin $NAME
rm NAME
rm IPADDRESS
