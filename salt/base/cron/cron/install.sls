# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "cron/map.jinja" import cron_settings with context %}

cron.install:
    pkg.installed:
        - name: {{ cron_settings.pkg }}
