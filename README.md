
**docker-php-phalcon-swoole-redis**
===========

[![](https://img.shields.io/badge/docker-php%2d-phalcon%2d-swoole%2d-redis-099cec?logo=docker)](https://hub.docker.com/r/twbworld/php-phalcon-swoole-redis)
[![](https://img.shields.io/github/license/twbworld/docker-php-phalcon-swoole-redis)](https://github.com/twbworld/docker-php-phalcon-swoole-redis/blob/main/LICENSE)
[![](https://github.com/twbworld/docker-php-phalcon-swoole-redis/workflows/ci/badge.svg?branch=main)](https://github.com/twbworld/docker-php-phalcon-swoole-redis/actions)
[![](https://app.codacy.com/project/badge/Grade/c1c22bb4fc804d7d80b58cd5c5301646)](https://www.codacy.com/gh/twbworld/docker-php-phalcon-swoole-redis/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=twbworld/docker-php-phalcon-swoole-redis&amp;utm_campaign=Badge_Grade)

> PS: 该镜像下的php安装了phalcon/swoole/redis扩展,但并没安装redis程序

## 构建镜像

> 使用了Github-Actions构建并发布Docker容器, 配置文件 `.github/workflows/ci.yml`

## 使用

### Command line
```shell
docker run --rm -it --name php ghcr.io/twbworld/php-phalcon-swoole-redis:latest
```

### docker-compose

```shell
version: "3.8"
services:
    language:
        image: ghcr.io/twbworld/php-phalcon-swoole-redis:latest
        container_name: php
        environment:
            - TZ=Asia/Shanghai
        restart: always
```

> 可以把端口映射到宿主机

| 程序 | 默认端口 |
| ---- | ---- |
| php-fpm | 9000 |
| swoole | 9501 |

