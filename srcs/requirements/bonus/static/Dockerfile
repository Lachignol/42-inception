FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y nginx && \
	apt-get clean && rm -rf /var/lib/apt/list/*	

# je supprime le fichier de conf si il existe deja au cas ou
RUN rm -f /etc/nginx/conf.d/default.conf

# je copie le fichier de conf perso dans le repertoire de basee de nginx
COPY ./conf/default.conf /etc/nginx/conf.d/

# je copie le contenu de mon site dans le repertoire servi par nginx
COPY ./website/* /var/www/html

# # change l'utilisateur du repertoire a www-data
RUN chown -R www-data:www-data /var/www/html

# j'expose le port 1200 mais seulement dans le container
EXPOSE 1200
# lance nginx en mode non detacher - Daemon off est un truc special pour empecher le processus de se detacher en arriere plan ce qui permet au conteneur de rester actif tant que nginx tourne.
CMD ["nginx", "-g" , "daemon off;"]
