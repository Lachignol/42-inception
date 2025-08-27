FROM debian:bullseye

RUN apt-get update && apt-get install -y --no-install-recommends \
    php php7.4-fpm php7.4-mysql curl mariadb-client ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/configuration_wordpress.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
# CMD ["php-fpm7.4", "-F", "-R"]

