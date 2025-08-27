# Supprime tous les fichiers dans le répertoire de sauvegarde WordPress pour nettoyer avant la nouvelle sauvegarde
rm -rf /home/backup/wordpress/*

# Crée les répertoires nécessaires pour stocker les backups des fichiers WordPress et de la base de données
mkdir -p /home/backup/wordpress /home/backup/database

# Synchronise les fichiers du site WordPress (dans /var/www/html) vers le dossier de backup
# L'option -a préserve les permissions, timestamps, etc.
rsync -a /var/www/html/ /home/backup/wordpress/


MARIADB_USER=$(cat /run/secrets/db_user)
MARIADB_PASSWORD=$(cat /run/secrets/db_password)
MARIADB_DATABASE=$(cat /run/secrets/db_name)

# Export de la base de données MySQL/MariaDB en dump SQL
# Effectue un dump complet de la base de données vers un fichier SQL dans le dossier de backup
mysqldump -h mariadb -P 3306 \
    -u ${MARIADB_USER} \
    -p${MARIADB_PASSWORD} \
    ${MARIADB_DATABASE} > /home/backup/database/db_backup.sql
