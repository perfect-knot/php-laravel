FROM php:8.1-fpm-bookworm

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
        libicu-dev \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev \
        libzip-dev \
        zip \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        bcmath \
        exif \
        gd \
        intl \
        pcntl \
        pdo \
        pdo_mysql \
        zip \
    && rm -rf /var/lib/apt/lists/*
