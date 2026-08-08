FROM php:8.4-fpm-alpine

# Runtime libraries — these must persist.
RUN apk add --no-cache \
    nginx \
    tini \
    git \
    curl \
    unzip \
    libpng \
    oniguruma \
    libxml2 \
    libpq \
    libzip

# Build-time toolchain and headers, dropped once the extensions are compiled.
RUN apk add --no-cache --virtual .build-deps \
      $PHPIZE_DEPS \
      libpng-dev \
      oniguruma-dev \
      libxml2-dev \
      libpq-dev \
      libzip-dev \
 && docker-php-ext-install pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd zip opcache \
 && apk del --no-network .build-deps

RUN sed -i \
      -e 's|^;catch_workers_output = .*|catch_workers_output = yes|' \
      -e 's|^;decorate_workers_output = .*|decorate_workers_output = no|' \
      /usr/local/etc/php-fpm.d/www.conf
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN chown -R www-data:www-data /var/www

COPY shared/default.conf /etc/nginx/http.d/default.conf
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /var/www

EXPOSE 80 443

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
