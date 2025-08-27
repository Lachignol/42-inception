FROM debian:bullseye

# Installer mariadb server (sans les composants inutiles)
RUN apt update -y && apt upgrade -y 

RUN apt-get install -y mariadb-server netcat -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chown mysql:mysql /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/configurate.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Démarrer le service MariaDB en mode non-démon (-u root pour lancer en premier plan comme PID 1)
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
