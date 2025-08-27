FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

# Installer redis server (sans les composants inutiles)
RUN apt-get install -y redis-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./tools/configurate.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

ENTRYPOINT [ "redis-server", "--protected-mode", "no" ]
# RUN apt update -y && apt upgrade -y 
#
# RUN apt-get install redis -y  && apt-get install php7.4-redis -y \

# COPY ./conf/my.cnf /etc/redis/redis.conf 
# RUN chown mysql:mysql /etc/mysql/mariadb.conf.d/50-server.cnf
#
# COPY ./tools/configurate.sh /usr/local/bin/docker-entrypoint.sh
# RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Démarrer le service redis 
# CMD ["redis-cli"]
# ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
