FROM ubuntu:16.04
MAINTAINER Oscar Jara <oajara@gmail.com>

# Install packages needed by the container
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get install -y php php-fpm php-mysql && \  
    apt-get install -y supervisor && \  
    rm -rf /var/lib/apt/lists/*
    
# Some Nginx housekeeping
RUN mkdir -p /etc/nginx/sites-available/ && \
    mkdir -p /etc/nginx/sites-enabled/ && \
    rm -Rf /var/www/* && \
    mkdir /var/www/nice_app/
    
# Copy Nginx and PHP configs
ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/php.ini /etc/php5/fpm/php.ini
ADD conf/www.conf /etc/php5/fpm/pool.d/www.conf

# vhost configuration for our NiceApp    
ADD conf/vhost.conf /etc/nginx/sites-available/default

# Config file for NiceApp
ADD conf/db.ini /var/www/nice_app/config/db.ini

# Supervisord configuration file
ADD conf/supervisord.conf /etc/supervisord.conf


WORKDIR /var/www/nice_app

EXPOSE 80

ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh
CMD ["/start.sh"]
    
