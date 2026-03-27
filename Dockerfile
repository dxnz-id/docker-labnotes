# ======================
# STAGE 1: BUILDER
# ======================
FROM dunglas/frankenphp AS builder

# Install semua tools build (composer, npm, dll)
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
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN install-php-extensions \
    pdo_mysql \
    gd \
    intl \
    zip \
    opcache

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Copy semua app (biar artisan bisa jalan)
COPY app /app

# Run Laravel command (optional, sesuai Dockerfile lu)
RUN php artisan storage:link || true 

# ======================
# STAGE 2: RUNTIME (FINAL)
# ======================
FROM dunglas/frankenphp:latest

# Install PHP extensions aja (minimal)
RUN install-php-extensions \
    pdo_mysql \
    gd \
    intl \
    zip \
    opcache

WORKDIR /app

# Copy hasil jadi dari builder
COPY --from=builder /app /app

# Copy config
COPY custom-php.ini /usr/local/etc/php/conf.d/custom-php.ini

# Env
ENV SERVER_NAME=":80"

# untuk mode worker:
# ENV FRANKENPHP_CONFIG="worker /app/public/frankenphp-worker.php"