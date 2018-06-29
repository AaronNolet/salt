# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "cron/map.jinja" import cron_settings with context %}

cron.service:
{% if 'enabled' not in cron_settings or ( 'enabled' in cron_settings and cron_settings.enabled ) %}
    service.running:
        - name: {{ cron_settings.service }}
        - enable: True
{% else %}
    service.dead:
        - name: {{ cron_settings.service }}
        - enable: False
{% endif %}
