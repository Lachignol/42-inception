#!/bin/bash


# Crée le répertoire /var/run/vsftpd/empty s'il n'existe pas
# Ce dossier est utilisé comme un répertoire sécurisé "chroot" pour vsftpd
mkdir -p /var/run/vsftpd/empty


# Charger secrets
FTP_USER=$(cat /run/secrets/ftp_user)
FTP_PASSWORD=$(cat /run/secrets/ftp_password)

cat <<EOF > /etc/vsftpd.conf
# Mode standalone : le serveur écoute les connexions entrantes
listen=YES
# Interdit la connexion anonyme
anonymous_enable=NO
# Autorise les connexions avec les utilisateurs locaux (définis dans /etc/passwd)
local_enable=YES
# Autorise les opérations d'écriture (upload de fichiers)
write_enable=YES
# Définit les permissions des fichiers créés par les utilisateurs locaux (ici 755)
local_umask=022
# Active la journalisation des transferts
xferlog_enable=YES
# Active le mode passif FTP, utile pour le passage à travers les pare-feux
pasv_enable=YES
# Plage de ports utilisés pour les connexions passives
pasv_min_port=30000
pasv_max_port=30009
# Définit le répertoire racine FTP pour les utilisateurs locaux
local_root=/var/www/wordpress
# Répertoire sécurisé utilisé pour éviter certains types d'attaques (chroot)
secure_chroot_dir=/var/run/vsftpd/empty
# http://vsftpd.beasts.org/vsftpd_conf.html
EOF

# Crée un utilisateur système avec un home directory spécifique
useradd -m -d /home/${FTP_USER} "${FTP_USER}"

# Définit le mot de passe de l'utilisateur FTP chargé depuis les secrets
echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd

# Arrête le service vsftpd s'il est déjà en fonctionnement (pour éviter conflit)
service vsftpd stop

#/usr/sbin/vsftpd /etc/vsftpd.conf
# Démarre le démon vsftpd avec la configuration générée
/usr/sbin/vsftpd /etc/vsftpd.conf
