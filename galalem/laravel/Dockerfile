FROM php:8.2-fpm

RUN apt update && apt install -y \
    nginx \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev
RUN apt clean && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN chown -R www-data:www-data /var/www

COPY default.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www

EXPOSE 80 443

CMD ["sh", "-c", "nginx && php-fpm"]
