FROM php:8.2.1-apache

RUN apt-get update && \
    apt-get -y install apt-transport-https git curl vim --no-install-recommends && \
    rm -r /var/lib/apt/lists/* && \
    curl -sSL -o /tmp/mo https://git.io/get-mo && \
    chmod +x /tmp/mo


# SimpleSAMLphp
ARG SIMPLESAMLPHP_VERSION
RUN curl -sSL -o /tmp/simplesamlphp.tar.gz https://github.com/simplesamlphp/simplesamlphp/releases/download/v1.19.7/simplesamlphp-1.19.7.tar.gz && \
    tar xzf /tmp/simplesamlphp.tar.gz -C /tmp && \
    mv /tmp/simplesamlphp-* /var/www/simplesamlphp && \
    touch /var/www/simplesamlphp/modules/exampleauth/enable && \
    echo "<?php" > /var/www/simplesamlphp/metadata/shib13-sp-remote.php 

COPY config/simplesamlphp/config.php config/simplesamlphp/authsources.php /var/www/simplesamlphp/config/

COPY config/simplesamlphp/saml20-sp-remote.php /var/www/simplesamlphp/metadata

COPY config/simplesamlphp/server.crt config/simplesamlphp/server.pem /var/www/simplesamlphp/cert/

# Apache
ENV HTTP_PORT 8080

COPY config/apache/ports.conf.mo /tmp
RUN /tmp/mo /tmp/ports.conf.mo > /etc/apache2/ports.conf
COPY config/apache/simplesamlphp.conf.mo /tmp
RUN /tmp/mo /tmp/simplesamlphp.conf.mo > /etc/apache2/sites-available/simplesamlphp.conf

RUN a2dissite 000-default.conf default-ssl.conf && \
    a2enmod rewrite && \
    a2ensite simplesamlphp.conf

# Clean up
RUN rm -rf /tmp/*

# Set work dir
WORKDIR /var/www/simplesamlphp

# General setup
EXPOSE ${HTTP_PORT}

