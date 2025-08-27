FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y
# Installe les paquets nécessaires : cron (pour planifier les tâches), rsync (outil de synchronisation de fichiers),
# et mariadb-client pour gérer les bases de données MariaDB/MySQL
RUN apt-get install -y cron rsync mariadb-client
COPY ./tools/configurate.sh /configurate.sh
COPY ./tools/backup.sh /backup.sh
RUN chmod +x /configurate.sh && chmod +x /backup.sh && /configurate.sh
# Lance cron au premier plan (avec -f) lorsque le container démarre pour exécuter les tâches planifiées
ENTRYPOINT [ "cron", "-f" ]
