#!/bin/sh
while [ -z "$NAME" ]; do read -r -p "Enter the name you wish to associate with this container [NAME]: " NAME; echo "$NAME">>NAME; cat NAME; done ;
sed -i "s/REPLACME_NAME/$NAME/g" README.md
sed -i "s/REPLACME_NAME/$NAME/g" movein.sh
rm NAME
