FROM debian:bullseye

# je met a jours et installe les dependances et je clean un peu apres linstallation (fichier cache)
RUN apt-get update && apt-get install -y nginx openssl && \
	apt-get clean && rm -rf /var/lib/apt/list/*	

# Supprimer la conf par défaut si presente pour éviter conflits
RUN rm -f /etc/nginx/conf.d/default.conf

# je copie mon fichier de conf mais apres il sera mieu de le faire dans le docker compose
COPY ./conf/default.conf /etc/nginx/conf.d/

# Copier et lancer le script pour générer les certificats SSL auto-signés
COPY ./tools/generate_certificates.sh /usr/local/bin/generate_cert.sh
RUN chmod +x /usr/local/bin/generate_cert.sh && /usr/local/bin/generate_cert.sh


# Cree le repertoire wordpress
RUN mkdir -p /var/www/wordpress

# change l'utilisateur du repertoire a www-data
RUN chown -R www-data:www-data /var/www/wordpress
# j'expose le port 443 mais seulement dans le container
EXPOSE 443

# lance nginx en mode non detacher - Daemon off est un truc special pour empecher le processus de se detacher en arriere plan ce qui permet au conteneur de rester actif tant que nginx tourne.
CMD ["nginx", "-g" , "daemon off;"]
