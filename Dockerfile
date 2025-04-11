FROM dunglas/frankenphp:php8.3

ENV SERVER_NAME=":80"

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    zip \
    libmariadb-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    npm 

RUN docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    zip \
    intl \
    gd \
    bcmath \
    && docker-php-ext-enable pdo_mysql zip intl gd bcmath

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer install && \
    npm install && \
    npm run build

RUN php artisan key:generate && \
    php artisan storage:link && \
    php artisan optimize