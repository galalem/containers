FROM php:8.4-fpm-alpine

RUN apk add --no-cache \
    nginx \
    tini \
    git \
    curl \
    unzip \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    postgresql-dev \
    libzip-dev
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd zip opcache
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN chown -R www-data:www-data /var/www

COPY shared/default.conf /etc/nginx/http.d/default.conf
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /var/www

EXPOSE 80 443

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
