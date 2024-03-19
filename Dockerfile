FROM --platform=$TARGETPLATFORM php:8.1-fpm

LABEL org.opencontainers.image.vendor="忐忑" \
      org.opencontainers.image.authors="1174865138@qq.com" \
      org.opencontainers.image.description="构建php镜像" \
      org.opencontainers.image.source="https://github.com/twbworld/php"

# ARG SWOOLE_VERSION=4.8.13
ARG REDIS_VERSION=6.0.2

COPY php.ini /usr/local/etc/php/
COPY www.conf /usr/local/etc/php-fpm.d/

# 安装php扩展: https://www.jianshu.com/p/20fcca06e27e
RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        zlib1g-dev \
        libzip-dev \
        cron \
        ssh \
        tzdata \
    && php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && mv composer.phar /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && composer selfupdate \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
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
        zip \
    && pecl install -o -f \
        redis-${REDIS_VERSION} \
        # swoole-${SWOOLE_VERSION} \
    && docker-php-ext-enable \
        redis \
        # swoole \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf \
    && echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf \
    && apt-get clean -y \
    && docker-php-source delete \
    && rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/cache/debconf/* \
        /var/log/* \
        /var/tmp/* \
        ${PWD}/*.tar.gz \
        composer-setup.php \
    && php -m

# COPY docker-phalcon-* /usr/local/bin/
