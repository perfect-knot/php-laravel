FROM php:8.0-fpm-buster as base
LABEL maintainer="derek@perfect-knot.com"

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date="$BUILD_DATE"
LABEL org.label-schema.vcs-ref="$VCS_REF"

RUN apt-get update && apt-get install -y \
        libicu-dev \
        libpng-dev \
        libzip-dev \
        zip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
        bcmath \
        gd \
        intl \
        pcntl \
        pdo \
        pdo_mysql \
        zip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

FROM base as dev

RUN apt-get update && apt-get install -y \
        git \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
ENV COMPOSER_MEMORY_LIMIT=-1

FROM base
