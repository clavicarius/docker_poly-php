FROM php:7.4-apache

# Systempakete installieren
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libicu-dev \
    libonig-dev \
    libzip-dev \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# PHP Extensions installieren
RUN docker-php-ext-install \
    mysqli \
    pdo \
    pdo_mysql \
    gd \
    intl \
    mbstring

# Xdebug kompatibel mit PHP 7.4 installieren
RUN pecl channel-update pecl.php.net \
    && pecl install xdebug-3.1.6 \
    && docker-php-ext-enable xdebug

# Apache Module aktivieren
RUN a2enmod rewrite

# Composer aus offiziellem Image übernehmen
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Arbeitsverzeichnis
WORKDIR /var/www/html