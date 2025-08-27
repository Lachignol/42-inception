#!/bin/sh

mkdir -p /etc/nginx/certs

# Générer une clé privée non chiffrée et un certificat auto-signé valide 365 jours
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/nginx/certs/privkey.pem \
  -out /etc/nginx/certs/fullchain.pem \
  -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=Inception/CN=wil.42.fr"
  
# Ajuster les permissions
chmod 600 /etc/nginx/certs/privkey.pem
chmod 644 /etc/nginx/certs/fullchain.pem

