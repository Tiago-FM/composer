FROM php:7.2-alpine

ENV COMPOSER_VERSION 1.6.5
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH ${PATH}:/root/.composer/vendor/bin

RUN curl -L https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar > /usr/local/bin/composer

RUN chmod +x /usr/local/bin/composer
RUN composer global require hirak/prestissimo

# Install extensions :
    # Install runtime deps :
RUN apk add gpgme libxslt --no-cache
    # Install build deps, build and remove build deps :
RUN apk add autoconf gpgme-dev make g++ gcc libxslt-dev -t build-stack --no-cache && \
    docker-php-ext-install pdo pdo_mysql xsl iconv soap && \
    pecl install gnupg && \
    pecl install redis && \
    echo "extension=gnupg.so" > /usr/local/etc/php/conf.d/gnupg.ini && \ 
    echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini && \ 
    apk del build-stack --purge

ENTRYPOINT [ "php", "/usr/local/bin/composer" ]
