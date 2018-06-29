base:
  'nginx*':
    - nginx
    - users

  'IoT-Fin-Edge*':
    - users
    - ufw
    - cron
