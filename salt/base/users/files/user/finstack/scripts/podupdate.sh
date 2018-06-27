#!/bin/bash
#
#  DESCRIPTION
#  This program retrieves a remote custom POD list for Fin Stack or 
#  SkySpark Server from IoT Warez's custom POD's remote storage based 
#  on the system's hostname.
#  
#  Once the list is retrieved, it then generates POD-Add and POD-Remove
#  files to use as vars and manipulates local file system via rsync
#  using SSH with secured key.
#
#  INFORMATION ON USAGE
#  This script requires that Fin Stack or SkySpark is installed on the
#  local host.
#  
#  This script should be setup under the "finstack" or "skyspark" user's
#  crontab.
#
#  sudo crontab -u finstack -e or sudo crontab -u skyspark -e
#
#  Add Line "05 04 * * * $HOME/IoT_Warez/updatescripts.sh; $HOME/scripts/
#  podupdate.sh > /tmp/$HOSTNAME'_podupdate_'`date '+\%b-\%d-\%Y'`.log 
#  2>&1; $HOME/scripts/sendlog.sh #Added by #IoT Warez, LLC"
#
#  ****************************************************************
#  ***															***
#  ***  AUTHOR													***
#  ***  Aaron Nolet @ IoT Warez, LLC <a.nolet@iotwarez.com>		***
#  ***															***
#  ****************************************************************

# ****************************
# * Modifiable Variable Defs *
# ****************************

RHOST=IoT_POD_Update@podupdate.iotwarez.com

# ************************************
# * Check if Fin or Sky and Set Vars *
# ************************************

if systemctl cat skyspark.service > /dev/null 2>&1; then
  FinSkyfan=$(systemctl cat skyspark.service |grep WorkingDirectory=/|sed 's/WorkingDirectory=\///')/lib/fan
  FinSkyhome=$(systemctl cat skyspark.service |grep WorkingDirectory=/|sed 's/WorkingDirectory=\///')
  HeapSize=$(cat /$FinSkyhome/etc/sys/config.props |grep java.options=|sed 's/java.options=-Xmx/Fin Stack Heap Size: /' |sed 's/"//g')
  FinSkystatus=$(/usr/sbin/service skyspark status|grep 'Active: ' |sed 's/Active: /SkySpark Service Status: /'|sed 's/   //')
elif systemctl cat finstack.service > /dev/null 2>&1; then
  FinSkyfan=$(cat /etc/init.d/finstack |grep HomeFolder=/|sed 's/HomeFolder=\///')/lib/fan
  FinSkyhome=$(cat /etc/init.d/finstack |grep HomeFolder=/|sed 's/HomeFolder=\///')
  HeapSize=$(cat /etc/init.d/finstack |grep HeapSize=|sed 's/HeapSize=/Fin Stack Heap Size: /' |sed 's/"//g')
  FinSkystatus=$(/usr/sbin/service finstack status|grep 'Active: ' |sed 's/Active: /Fin Stack Service Status: /'|sed 's/   //')
fi

# ************************
# * Static Variable Defs *
# ************************

MemStat=$(free -h)
HOSTNAME=$(hostname)
CPU=$(lscpu |grep 'Model name:' |sed 's/Model name:/Host Processor: /' |sed 's/  //g')
DISKS=$(df -h)
dt=$(date '+%d/%m/%Y %H:%M:%S');
my_ip=$(/sbin/ifconfig | grep -w inet |grep -v 127.0.0.1| awk '{print $2}' | cut -d ":" -f 2)
my_subnet=$(/sbin/ifconfig | grep -w inet |grep -v 127.0.0.1| awk '{print $4}' | cut -d ":" -f 2)
my_if=$(/sbin/ifconfig | grep HWaddr | cut -d " " -f 1)
my_mac=$(/sbin/ifconfig | grep HWaddr | awk '{ print $5 }')
my_wan_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
my_ifs=$(/sbin/ifconfig -a)

#
#
echo "Script run on $dt"
echo ""
printf -v res %80s
printf '%s\n' "${res// /-}"
echo "***** Host Information *****"
printf -v res %80s
printf '%s\n' "${res// /-}"
echo ""
echo "Host: $HOSTNAME"
echo "$CPU"
echo ""
echo "$FinSkystatus"
echo "Fin Stack Installed at: $FinSkyhome"
echo "$HeapSize"
echo ""
echo ""echo "Interface: $my_if"
echo "IP Address: $my_ip"
echo "Subnet: $my_subnet"
echo "Mac Address: $my_mac"
echo ""
echo "WAN IP: $my_wan_ip"
echo ""
echo "Host Memory:"
echo "------------"
echo "$MemStat"
echo ""
echo "Host Storage:"
echo "-------------"
echo "$DISKS"
echo ""
printf -v res %80s
printf '%s\n' "${res// /-}"
echo "***** Custom Pod Sync Results *****"
printf -v res %80s
printf '%s\n' "${res// /-}"
echo ""

# ********************************
# * Get Remote Custom POD's List *
# ********************************

/usr/bin/rsync -rltvhz -e "/usr/bin/ssh -i $HOME/.ssh/id_rsa" $RHOST:/volume1/podsync/_hosts/$HOSTNAME.lst $HOME/

# ********************************************************
# * Generate POD-Add and POD-Remove Files to Use as Vars *
# ********************************************************

sed 's|+ |/volume1/podsync/|' $HOME/$HOSTNAME.lst |grep volume |sed 's/\r/ :/' |tr -d '\n' |sed 's/ :$//' > $HOSTNAME'_POD-Add'.lst
sed 's|- |-f "R |' $HOME/$HOSTNAME.lst |grep \\-f |sed 's/\r/" /' |tr -d '\n' |sed 's/.pod$/.pod"/' > $HOSTNAME'_POD-Remove'.lst

# *****************************************
# * Get Required POD's From Remote Server *
# *****************************************

if [ -s $HOME/$HOSTNAME'_POD-Add'.lst ];
then
/usr/bin/rsync -rltvhz -e "/usr/bin/ssh -i $HOME/.ssh/id_rsa" $RHOST:`cat $HOME/$HOSTNAME'_POD-Add'.lst` $HOME/tmp/
else
echo ""
echo "**** No Pods Assigned to Your Host --- Download Terminated...  ****"
echo ""
fi
/usr/bin/rsync -avh --include-from=$HOME/$HOSTNAME.lst --delete-excluded $HOME/tmp/ $HOME/pods/

# *******************************************************************************************************************
# * Manipulate the Fin Stack POD's (Add New POD's, Protect Existing POD's, Risk POD's to be Removed and Delete Them *
# *******************************************************************************************************************

eval /usr/bin/rsync -rltvhz --delete --delete-excluded --include-from=$HOME/$HOSTNAME.lst `cat $HOME/$HOSTNAME'_POD-Remove'.lst` -f \"P *\" $HOME/pods/ /$FinSkyfan/
echo ""
printf -v res %80s
printf '%s\n' "${res// /-}"
echo "***** All Host Network Interfaces *****"
printf -v res %80s
printf '%s\n' "${res// /-}"
echo ""
echo "$my_ifs"
echo ""
printf -v res %80s
printf '%s\n' "${res// /-}"
echo "**** Pod Files on Host *****"
printf -v res %80s
printf '%s\n' "${res// /-}"
echo ""
sleep 30
pods=$(cat /tmp/watchfile2)
echo "$pods"
echo ""
printf -v res %80s
printf '%s\n' "${res// /-}"
echo "**** Fail2Ban Banned IP's by Service *****"
printf -v res %80s
printf '%s\n' "${res// /-}"
echo ""
if [ -e /tmp/Banned_IPs.log ]
then
fail2ban=$(cat /tmp/Banned_IPs.log)
echo "$fail2ban"
else
echo "Banned_IPs.log file does not exist..."
fi