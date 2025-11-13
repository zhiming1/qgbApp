FROM php:8.3-fpm

# 基础依赖
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring zip bcmath

# 安装 Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# 容器里的工作目录
WORKDIR /var/www/html