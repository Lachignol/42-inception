FROM debian:bullseye

# Met à jour la liste des paquets et installe les dernières versions disponibles
RUN apt-get update -y && apt-get upgrade -y

# Installe wget (outil pour télécharger des fichier et ici adminer) et PHP avec l'extension mysqli pour accéder aux bases de données MySQL/MariaDB
RUN apt-get install -y wget php php-mysqli

COPY ./tools/configurate.sh /setup.sh

RUN chmod +x /setup.sh && /setup.sh

# Démarre le serveur web intégré de PHP à l'adresse 0.0.0.0 sur le port 8080,
# avec le dossier /var/www/html comme racine des fichiers web
# Cela sert à héberger le contenu web via PHP directement, sans serveur Apache ou Nginx
ENTRYPOINT [ "php", "-S", "0.0.0.0:8080", "-t", "/var/www/html" ]
