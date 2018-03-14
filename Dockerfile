FROM php:7.1-alpine

ENV COMPOSER_VERSION 1.6.3
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH ${PATH}:/root/.composer/vendor/bin

RUN curl -L https://github.com/composer/composer/releases/download/${COMPOSER_VERSION}/composer.phar > /usr/local/bin/composer

RUN chmod +x /usr/local/bin/composer
ENTRYPOINT [ "php", "/usr/local/bin/composer" ]
