FROM php:8.4-fpm

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
RUN sed -i \
      -e 's|^;catch_workers_output = .*|catch_workers_output = yes|' \
      -e 's|^;decorate_workers_output = .*|decorate_workers_output = no|' \
      /usr/local/etc/php-fpm.d/www.conf
# Refuse to build on a base image without the PHP2Shell fixes (CVE-2026-109618/109619).
RUN php -r 'exit(version_compare(PHP_VERSION, "8.4.27", ">=") ? 0 : 1);' \
 || { echo "PHP $(php -r 'echo PHP_VERSION;') is older than 8.4.27; base image is stale" >&2; exit 1; }
COPY shared/security.ini /usr/local/etc/php/conf.d/zz-security.ini
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
