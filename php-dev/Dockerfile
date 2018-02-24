FROM ubuntu:16.04

MAINTAINER Flaverton Rodrigues Rosa <flavertonrodrigues@gmail.com>

RUN apt-get update && apt-get install -y \
    build-essential \
    apache2 \
    libapache2-mod-php5 \
    php5 \
    php5-mysql \
    php-pear

RUN pecl install xdebug

RUN a2enmod rewrite \
    && service apache2 restart

EXPOSE 80