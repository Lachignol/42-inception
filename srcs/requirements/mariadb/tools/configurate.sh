#!/bin/sh
echo "Starting custom MariaDB entrypoint..."

# Charger secrets
MARIADB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MARIADB_USER=$(cat /run/secrets/db_user)
MARIADB_PASSWORD=$(cat /run/secrets/db_password)
MARIADB_DATABASE=$(cat /run/secrets/db_name)

# Préparer dossier socket
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

echo "Initialisation base vide..."
mysqld --skip-networking &
  pid=$!

  #service mariadb start

  # Boucle d'attente que MariaDB soit joignable
RETRIES=30
until mysqladmin ping --silent; do
  echo "MariaDB n'est pas encore prête, attente 1 seconde..."
  sleep 1
  RETRIES=$((RETRIES - 1))
  if [ $RETRIES -le 0 ]; then
    echo "Erreur : le service MariaDB n'a pas démarré dans les temps"
    exit 1
  fi
done

echo "MariaDB est démarré et prêt"

# Créer base, utilisateur et droits
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;"
mariadb -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';"
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
mariadb -e "FLUSH PRIVILEGES;"

 echo "reboot"

 # Arrêt du serveur temporaire
 mysqladmin -u root -p"${MARIADB_ROOT_PASSWORD}" shutdown

echo "Démarrage du serveur MariaDB au premier plan..."
exec mysqld_safe

