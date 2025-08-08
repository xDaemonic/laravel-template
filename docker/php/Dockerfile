FROM php:8.3-fpm

WORKDIR /var/www/

# Install dependencies
RUN apt-get update && apt-get install -y \
    supervisor \
    build-essential \
    mariadb-client \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libicu-dev \
    locales \
    libzip-dev \
    gnupg2 \
    zip \
    vim \
    unzip \
    git \
    curl \
    cron 

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install intl
RUN docker-php-ext-install bcmath

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy config files
COPY ./crontab /etc/cron.d/crontab
COPY ./laravel-worker.conf /etc/supervisor/conf.d/laravel-worker.conf
COPY ./local.ini /usr/local/etc/php/conf.d/local.ini

CMD ["supervisord", "-n"]