FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    vim \
    unzip \
    nodejs \
    git \
    npm \
    curl

RUN docker-php-ext-configure zip && \
    docker-php-ext-install pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV COMPOSER_ALLOW_SUPERUSER=1
WORKDIR /var/www

EXPOSE 9000
CMD ["php-fpm"]