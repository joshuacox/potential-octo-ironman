#!/bin/bash

cd /root
wget https://raw.githubusercontent.com/joshuacox/potential-octo-ironman/athena171/cloud-config.yaml
coreos-install -d /dev/vda -C stable -c /root/cloud-config.yaml
