ufw:
  enabled: True
  settings:
    ipv6: False
  applications:
    OpenSSH:
      enabled: True
    Saltmaster:
      enabled: True
    Fin_Stack:
      enabled: True

cron:
  enabled: True
  tasks:

    podsync:
      type: 'present'
      name: '/bin/bash {'}$HOME/IoT_Warez/updatescripts.sh; $HOME/scripts/podupdate.sh > /tmp/$HOSTNAME"_podupdate_"`date "+\%b-\%d-\%Y"`.log 2>&1; $HOME/scripts/sendlog.sh{'}'
      user: 'finstack'
      minute: 05
      hour: 04
      comment: 'Added by IoT Warez, LLC'

    fail2ban-allstatus:
      type: 'present'
      name: '/home/finstack/scripts/fail2ban-allstatus.sh'
      user: 'root'
      minute: 00
      hour: 04
      comment: 'Added by IoT Warez, LLC'
