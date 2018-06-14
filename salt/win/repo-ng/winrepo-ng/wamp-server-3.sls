wamp-server-3:
  '3.0.4':
    {% if grains['cpuarch'] == 'AMD64' %}
    full_name: 'Wampserver64 3.0.4'
    installer: 'http://tenet.dl.sourceforge.net/project/wampserver/WampServer%203/WampServer%203.0.0/wampserver3_x64_apache2.4.18_mysql5.7.11_php5.6.19-7.0.4.exe'
    uninstaller: 'c:\wamp64\uninstall_services.bat'
    uninstall_flags: '& c:\wamp64\unins000.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    {% else %}
    full_name: 'Wampserver 3.0.4'
    installer: 'http://tenet.dl.sourceforge.net/project/wampserver/WampServer%203/WampServer%203.0.0/wampserver3.0.4_x86_apache2.4.18_mysql5.7.11_php5.6.19-7.0.4.exe'
    uninstaller: 'c:\wamp\uninstall_services.bat'
    uninstall_flags: '& c:\wamp\unins000.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    {% endif %}
    install_flags: '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
    msiexec: False
    locale: en_US
    reboot: False
