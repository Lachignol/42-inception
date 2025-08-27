FROM debian:bullseye
# Mettre à jour le système et installer curl
RUN apt-get update && apt-get install -y curl

# Télécharger et copier le binaire Portainer (exemple pour Linux amd64, adapter selon besoin)
RUN curl -L https://github.com/portainer/portainer/releases/latest/download/portainer-linux-amd64 -o /usr/local/bin/portainer \
    && chmod +x /usr/local/bin/portainer

# Exposer le port 9000 pour l'interface web de Portainer
EXPOSE 9000

# Commande par défaut pour lancer Portainer
CMD ["/usr/local/bin/portainer", "--http", "--host", "0.0.0.0"]

