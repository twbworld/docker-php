FROM --platform=$TARGETPLATFORM php:7.4-fpm

LABEL org.opencontainers.image.vendor="忐忑" \
      org.opencontainers.image.authors="1174865138@qq.com" \
      org.opencontainers.image.description="构建php镜像" \
      org.opencontainers.image.source="https://github.com/twbworld/php"

#ARG SWOOLE_VERSION=4.5.2
#ARG REDIS_VERSION=5.3.1
ARG PHALCON_VERSION=4.1.2 \
    PSR_VERSION=1.0.0 \
    PHALCON_EXT_PATH=php7/64bits

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
    # Download PSR, see https://github.com/jbboehr/php-psr
    && curl -L -O https://github.com/jbboehr/php-psr/archive/v${PSR_VERSION}.tar.gz \
        -O https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz \
    && tar -zxvf ${PWD}/v${PSR_VERSION}.tar.gz \
    && tar -zxvf ${PWD}/v${PHALCON_VERSION}.tar.gz \
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
        ${PWD}/php-psr-${PSR_VERSION} \
        ${PWD}/cphalcon-${PHALCON_VERSION}/build/${PHALCON_EXT_PATH} \
    && pecl install -o -f \
        # swoole \
        redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable \
        redis \
        # swoole \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf \
    && echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf \
    && apt-get autoclean \
    && rm -rf \
        ${PWD}/*.tar.gz \
        ${PWD}/php-psr-${PSR_VERSION} \
        ${PWD}/cphalcon-${PHALCON_VERSION} \
        /var/lib/apt/lists/* \
    && php -m

# COPY docker-phalcon-* /usr/local/bin/
