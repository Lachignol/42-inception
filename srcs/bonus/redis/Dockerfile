FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

# Installer redis server (sans les composants inutiles)
RUN apt-get install -y redis-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./tools/configurate.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

# Démarre le serveur Redis lors du lancement du container Docker
# L'option '--protected-mode no' désactive le mode protégé de Redis
# Le mode protégé bloque par défaut les connexions distantes non sécurisées
# Le désactiver permet à Redis d'accepter les connexions depuis d'autres machines
# Utile pour que Redis soit accessible sur un réseau docker ou LAN
# Attention : désactivation du mode protégé doit être compensée par d'autres mesures de sécurité (firewall, authentification)
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
