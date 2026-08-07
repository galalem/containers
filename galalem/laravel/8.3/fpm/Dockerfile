FROM php:8.3-fpm

RUN apt update && apt install -y \
    nginx \
    tini \
    git \
    curl \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    libzip-dev
RUN apt clean && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd zip opcache
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN chown -R www-data:www-data /var/www

COPY shared/default.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/default \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /var/www

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
