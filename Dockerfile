FROM php:7.3-fpm

LABEL maintainer="twb<1174865138@qq.com><github.com/twbworld>"
LABEL description="构建php-phalcon-swoole-redis镜像"

ARG PHALCON_VERSION=4.0.6
ARG SWOOLE_VERSION=4.5.2
ARG REDIS_VERSION=5.3.1
ARG PSR_VERSION=1.0.0
ARG PHALCON_EXT_PATH=php7/64bits

# 安装php扩展: https://www.jianshu.com/p/20fcca06e27e
RUN set -xe \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
            libfreetype6-dev \
            libjpeg62-turbo-dev \
            libpng-dev \
        && rm -r /var/lib/apt/lists/* \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) \
            gd \
            bcmath \
            calendar \
            exif \
            gettext \
            sockets \
            dba \
            mysqli \
            pcntl \
            pdo_mysql \
            shmop \
            sysvmsg \
            sysvsem \
            sysvshm \
        && pecl install \
            swoole-${SWOOLE_VERSION} \
            redis-${REDIS_VERSION} \
        && docker-php-ext-enable \
            redis \
            swoole \
        # Download PSR, see https://github.com/jbboehr/php-psr
        && curl -LO https://github.com/jbboehr/php-psr/archive/v${PSR_VERSION}.tar.gz \
        && tar xzf ${PWD}/v${PSR_VERSION}.tar.gz \
        # Download Phalcon
        && curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz \
        && tar xzf ${PWD}/v${PHALCON_VERSION}.tar.gz \
        && docker-php-ext-install -j $(getconf _NPROCESSORS_ONLN) \
            ${PWD}/php-psr-${PSR_VERSION} \
            ${PWD}/cphalcon-${PHALCON_VERSION}/build/${PHALCON_EXT_PATH} \
        # Remove all temp files
        && rm -r \
            ${PWD}/v${PSR_VERSION}.tar.gz \
            ${PWD}/php-psr-${PSR_VERSION} \
            ${PWD}/v${PHALCON_VERSION}.tar.gz \
            ${PWD}/cphalcon-${PHALCON_VERSION} \
        && php -m

# USER 33
# COPY docker-phalcon-* /usr/local/bin/
