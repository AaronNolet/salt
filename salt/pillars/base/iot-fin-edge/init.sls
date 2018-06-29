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
    task1:
      type: 'present'
      name: '$HOME/IoT_Warez/updatescripts.sh; $HOME/scripts/podupdate.sh > /tmp/$HOSTNAME\'_podupdate_\'`date \'+\\%b-\\%d-\\%Y\'`.log 2>&1; $HOME/scripts/sendlog.sh"
      user: 'finstack'
      minute: 5
      hour: 4
      comment: 'Added by IoT Warez, LLC'
