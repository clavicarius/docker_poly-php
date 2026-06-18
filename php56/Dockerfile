FROM php:5.6-apache

# Fix für alte Debian Jessie Repositories
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list \
 && sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list \
 && sed -i '/stretch-updates/d' /etc/apt/sources.list \
 && apt-get -o Acquire::Check-Valid-Until=false update

RUN apt-get install -y \
    libpng-dev \
    libicu-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    unzip

# GD sauber konfigurieren (für alte PHP Version nötig)
RUN docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
    mysqli \
    pdo \
    pdo_mysql \
    gd \
    intl \
    mbstring

# letzte kompatible Xdebug Version für PHP 5.6
RUN pecl install xdebug-2.5.5 \
 && docker-php-ext-enable xdebug

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Apache modules
RUN a2enmod rewrite