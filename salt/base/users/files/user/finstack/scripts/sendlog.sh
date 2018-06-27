#!/bin/bash
HOSTNAME=$(hostname)
DATE=`date +%b-%d-%Y`
LOGFILE="/tmp/"$HOSTNAME"_podupdate_"$DATE".log"
/usr/bin/rsync -rltvhz $LOGFILE -e "/usr/bin/ssh -i $HOME/.ssh/id_rsa" IoT_POD_Update@podupdate.iotwarez.com:/volume1/podsync/_logs/$HOSTNAME/
rm $LOGFILE
