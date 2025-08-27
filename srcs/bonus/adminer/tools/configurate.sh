#!/bin/sh

# Crée le répertoire /var/www/html s'il n'existe pas déjà (-p pour éviter l'erreur si dossier déjà présent)
mkdir -p /var/www/html
# Change le propriétaire et le groupe du dossier /var/www/html et de tout son contenu récursivement (-R)
# Ceci donne les droits à l'utilisateur www-data (souvent utilisé par les serveurs web comme Apache ou Nginx)
chown -R www-data:www-data /var/www/html
# Télécharge le fichier adminer-4.8.1.php depuis GitHub et le sauvegarde sous le nom index.php dans /var/www/html
# L'option -O précise le chemin et le nom du fichier de sortie
wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/html/index.php
