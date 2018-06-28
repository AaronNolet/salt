users:

  finstack:
    fullname: Fin Stack
    createhome: True
    shell: /bin/false
    user_files:
      enabled: True
      file_mode: 555
    ssh_keys:
      privkey: salt://users/files/ssh_keys/podupdate_id_rsa
    ssh_known_hosts:
      fingerprint: pEdpv/sHzHjLRzndr/UQbNR0p2r8ukrkujYn+F2eQzs

  iotwarez:
    fullname: IoT Warez LLC
    groups:
      - sudo
      - adm
      - cdrom
      - dip
      - plugdev
      - lxd
      - lpadmin
    optional_groups:
      - finstack
    sudo_rules:
      - ALL=(ALL) NOPASSWD:ALL
    ssh_auth_file:
      - ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgB0908KGs/cZX/FfC/s1RolMZo5FCd67gANjShVKPHj1cmZ3rqgk5lmQLMIUCqn7Z+rdOmAGp49gjvDE9Dn54GyTryVS5/njiKD4y3p3RGYxGuelOUuLODF3F0ttTpmg8hxBmK/fxt7f1QuTAbeBsfVkllnUvsyAYRDDKJCynQoUru1TiWbmAM7wNYlm96otb0ni7NaPIw49OoC31JHmPI2ddty3Yg4B3D3ikJcmYkg9SwVUxXsZZSgB+m/PdidjZFieHRiTOsSigiZQJxR9pCKhX+VlD0+rJh8J1cBdwpHHPrfWO2IyTP4kMOYCmUHNS1u+EN8FBhobvmOGLUyRe+92d9O0QuJ7vV7szuexWRFrvXRa77OlSw9Wf/Ly79t6O6vwCyGOXpvQ4drLIAHnQ0+vvWtITsUfLNJWgipOBIUq8J+y98ziqHArhh1EesKYzaJDqUJs04qC+zkDqr97NGXp/wpX74029qwDOkySNM2ZPR98NehPSERFpgj8CQufTFEP5t2/zEer/7M9721K7qybqxT7sRfCmA1UGbOGze/ZYKlPxqPfmsmKD5pjPQe/MrkYuqZgd13r8o1KvG66+gRiqXLS24uHwKdgdz90jrYeuHXl23OgcwfJv4u4kf1anXbwKuB4SXJ4fKpFjKpnZkDsN+o6P3Hh4ssUO61a3Zjcw== rsa-key-20180626
