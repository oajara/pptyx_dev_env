#!/bin/bash

# Always chown webroot for better mounting
chown -Rf www-data: /var/www/nice_app

mkdir /run/php && chown www-data /run/php

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf
