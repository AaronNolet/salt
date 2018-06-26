#
# Install NginX webserver, setup global configuration
#

# Install package and setup service
install-common:
  pkg.installed:
    - pkgs:
      - htop
      - unzip

install-fail2ban:
  pkg.installed:
    - pkgs:
      - fail2ban

fail2ban:
  service.running:
    - require:
      - pkg: install-fail2ban
    - watch:
      - file: /etc/fail2ban/jail.conf

# Main fail2ban jail configurationf file
/etc/fail2ban/jail.conf:
  file.managed:
    - source: salt://iot-fin-edge/files/etc/fail2ban/jail.conf
    - require:
      - pkg: install-fail2ban

install-default-jre:
  pkg.installed:
    - pkgs:
      - default-jre

/etc/environment:
  file.append:
    - require:
      - pkg: install-default-jre
    - text:
      - JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
