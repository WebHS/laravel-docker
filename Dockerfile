# Base imagem with PHP 7.2
FROM php:7.2

# Update packages
RUN apt-get update

# Install libs dependencies
RUN apt-get install -qq \
    bash \
    curl \
    g++ \
    gcc \
    git \
    libc-dev \
    libpng-dev \
    make \
    mysql-client \
    nodejs \
    openssh-client \
    rsync

# Install PHP and composer dependencies
RUN apt-get install -qq git curl libmcrypt-dev libjpeg-dev libpng-dev libfreetype6-dev libbz2-dev

# Clear out the local repository of retrieved package files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PECL and PEAR extensions
RUN pecl install \
    xdebug

# Install and enable php extensions
RUN docker-php-ext-enable \
    xdebug

# Install needed extensions
RUN docker-php-ext-install \
    mbstring \
    gd \
    pdo_mysql \
    zip
    
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd

# Install Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Laravel Envoy
RUN composer global require "laravel/envoy=~1.0"
