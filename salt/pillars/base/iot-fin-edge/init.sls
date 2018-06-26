ufw:
  enabled: True
  settings:
    ipv6: False
  applications:
    OpenSSH:
      enabled: True
      comment: Allow SSH
    Saltmaster:
      enabled: True
    Fin_Stack:
      enabled: True
