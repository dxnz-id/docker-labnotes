FROM dunglas/frankenphp

RUN install-php-extensions \
    pdo_mysql \
    gd \
    intl \
    zip \
    opcache \
    oci8

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
    nano \
    npm 

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy custom php.ini
COPY custom-php.ini /usr/local/etc/php/conf.d/custom-php.ini

# Hanya saat development:
ENV SERVER_NAME=":80"

# untuk mode worker:
# ENV FRANKENPHP_CONFIG="worker /app/public/frankenphp-worker.php