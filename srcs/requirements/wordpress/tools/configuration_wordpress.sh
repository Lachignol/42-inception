#!/bin/sh
set -e

: "${WORDPRESS_DB_HOST:?Variable WORDPRESS_DB_HOST est requise}"

vars="WORDPRESS_DB_USER WORDPRESS_DB_PASSWORD WORDPRESS_DB_NAME WP_ADMIN_NAME WP_ADMIN_PASS WP_ADMIN_MAIL WP_USER_NAME WP_USER_PASS WP_USER_MAIL WP_USER_ROLE WP_TITLE"

for var in $vars; do
  # Récupérer le chemin du secret depuis la variable d'env existante
  filepath=$(printenv "$var")

  # Vérifier que le fichier existe et n'est pas vide pour éviter erreurs
  if [ -f "$filepath" ] && [ -s "$filepath" ]; then
    # Remplacer la variable par le contenu du fichier secret
    export "$var"="$(cat "$filepath")"
  else
    echo "Attention : fichier secret manquant ou vide pour la variable $var ($filepath)" >&2
  fi
done

cd /var/www/wordpress
chmod -R 755 /var/www/wordpress/
chown -R www-data:www-data /var/www/wordpress/

mkdir -p /run/php
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf

# Télécharger WordPress seulement si absent
if [ ! -f wp-settings.php ]; then
  wp core download --allow-root
fi

# Générer wp-config.php si absent
if [ ! -f wp-config.php ]; then
  wp core config --dbhost="${WORDPRESS_DB_HOST}" \
    --dbname="${WORDPRESS_DB_NAME}" \
    --dbuser="${WORDPRESS_DB_USER}" \
    --dbpass="${WORDPRESS_DB_PASSWORD}" --allow-root
fi

# Installer WP seulement si la base n'a pas la table 'wp_options'
if ! wp db query "SHOW TABLES LIKE 'wp_options';" --allow-root | grep wp_options > /dev/null 2>&1; then
  wp core install --url="ascordil.42.fr" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_NAME}" --admin_password="${WP_ADMIN_PASS}" --admin_email="${WP_ADMIN_MAIL}" --allow-root
  wp user create "${WP_USER_NAME}" "${WP_USER_MAIL}" --user_pass="${WP_USER_PASS}" --role="${WP_USER_ROLE}" --allow-root
else
  echo "WordPress déjà installé, démarrage du service..."
fi

wp plugin install redis-cache --activate --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp redis enable --allow-root

php-fpm7.4 -F -R

