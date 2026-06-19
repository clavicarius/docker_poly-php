FROM php:5.6-apache

# Jessie auf archive.debian.org umstellen
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list \
 && sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list \
 && sed -i '/stretch-updates/d' /etc/apt/sources.list

# Update mit deaktivierter Gültigkeitsprüfung
RUN apt-get -o Acquire::Check-Valid-Until=false update

# Pakete installieren (ohne Signaturprüfung)
RUN apt-get install -y --allow-unauthenticated \
    libpng-dev \
    libicu-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    unzip