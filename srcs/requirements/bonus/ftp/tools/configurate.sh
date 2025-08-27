#!/bin/bash

mkdir -p /var/run/vsftpd/empty


# Charger secrets
FTP_USER=$(cat /run/secrets/ftp_user)
FTP_PASSWORD=$(cat /run/secrets/ftp_password)

cat <<EOF > /etc/vsftpd.conf
# run in standalone mode (listen for incomming connections on an IP and a port)
listen=YES
# require a user to login
anonymous_enable=NO
# permits local users in /etc/passwd logins
local_enable=YES
# enable file upload
write_enable=YES
# file permissions for newly user created files = 777(default) - 022(umask)
local_umask=022
# log upoads and downloads
xferlog_enable=YES
pasv_enable=YES
pasv_address=${INCEPTION_IP}
pasv_min_port=30000
pasv_max_port=30009
local_root=/home/${FTP_USER}
secure_chroot_dir=/var/run/vsftpd/empty
# http://vsftpd.beasts.org/vsftpd_conf.html
EOF

useradd -m -d /home/${FTP_USER} "${FTP_USER}"
echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
service vsftpd stop

/usr/sbin/vsftpd /etc/vsftpd.conf
