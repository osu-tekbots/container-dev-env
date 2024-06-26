FROM php:8.2-apache

RUN apt-get update && apt-get install -y libyaml-dev \
    # Investigate if YAML is included in modern PHP
    # && pecl install yaml-1.3.1 \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-enable mysqli \
    && a2enmod rewrite \
    && sed 's#;date.timezone =#date.timezone = America/Los_Angeles#' /usr/local/etc/php/php.ini-production \
        > /usr/local/etc/php/php.ini
    # && echo 'extension=yaml.so' >> /usr/local/etc/php/php.ini

WORKDIR /var/www/html

EXPOSE 80