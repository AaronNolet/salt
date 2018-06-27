#!/bin/bash

# ****************************
# * Modifiable Variable Defs *
# ****************************

RHOST=IoT_POD_Update@podupdate.iotwarez.com

# ****************************
# * Synchronize Live Scripts *
# ****************************

HOSTNAME=$(hostname)
mkdir -p ~/scripts
/usr/bin/rsync -rltvhz -e "/usr/bin/ssh -i $HOME/.ssh/id_rsa" $RHOST:/volume1/podsync/_LiveScripts/ $HOME/scripts/
