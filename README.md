
**docker-php**
===========

[![](https://img.shields.io/badge/docker-php%2d-phalcon%2d-swoole%2d-redis-099cec?logo=docker)](https://hub.docker.com/r/twbworld/php)
[![](https://img.shields.io/github/license/twbworld/docker-php)](https://github.com/twbworld/docker-php/blob/main/LICENSE)
[![](https://github.com/twbworld/docker-php/workflows/ci/badge.svg?branch=main)](https://github.com/twbworld/docker-php/actions)
[![](https://app.codacy.com/project/badge/Grade/c1c22bb4fc804d7d80b58cd5c5301646)](https://www.codacy.com/gh/twbworld/docker-php/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=twbworld/docker-php&amp;utm_campaign=Badge_Grade)

> PS: 该镜像下的php安装了phalcon/redis等一系列扩展(奇怪安装swoole失败),但并没安装redis程序

## 构建镜像

> 使用了Github-Actions构建并发布Docker容器, 配置文件 `.github/workflows/main.yml`

## 使用

### Command line
```shell
docker run --rm -it --name php ghcr.io/twbworld/php:latest
```

### docker-compose

```shell
version: "3"
services:
    php:
        image: ghcr.io/twbworld/php:latest
```

> 可以把端口映射到宿主机

| 程序 | 默认端口 |
| ---- | ---- |
| php-fpm | 9000 |
| swoole | 9501 |
