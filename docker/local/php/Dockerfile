FROM php:8.1.21-fpm-alpine3.18

RUN set -eux \
    && apk add --no-cache \
        icu-libs \
        libintl

RUN set -eux \
    && apk add --no-cache --virtual .build-deps \
        icu-dev \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-configure pdo_mysql --with-zlib-dir=/usr \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-source delete \
    && apk del .build-deps

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY files/php.ini /usr/local/etc/php/php.ini
COPY files/php-fpm.conf /usr/local/etc/php-fpm.conf

WORKDIR /var/www
COPY --chown=www-data:www-data . /var/www

CMD ["php-fpm", "--nodaemonize"]
