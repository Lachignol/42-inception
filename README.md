# Projet Inception - École 42

## Description
Ce projet Inception consiste à construire une mini-infrastructure Docker complète dans une machine virtuelle, composée de plusieurs services conteneurisés interconnectés avec Docker Compose. Chaque service tourne dans son propre container Docker construit à partir d'une image personnalisée basée sur l'avant-dernière version stable d'Alpine ou Debian. Le projet inclut la mise en place d'un réseau Docker, de volumes persistants, et d'une infrastructure sécurisée avec un NGINX en point d'entrée HTTPS avec TLSv1.2 ou TLSv1.3.

## Contenu rendu
- Le dossier `srcs` contenant tous les fichiers nécessaires à la configuration (Dockerfiles, configurations, fichiers de scripts, docker-compose.yml, etc.).
- Un `Makefile` à la racine, permettant de builder les images et démarrer l'infrastructure via Docker Compose.
- Un dossier `secrets` avec les fichiers de mots de passe et autres informations confidentielles (non versionnés dans Git).
- Un fichier `.env` pour stocker vos variables d'environnement utilisées dans le projet.

## Services à déployer

| Service       | Description                                   | Image Base                   | Remarques                              |
|---------------|-----------------------------------------------|-----------------------------|---------------------------------------|
| NGINX         | Serveur web avec TLSv1.2 ou TLSv1.3 uniquement | Alpine/Debian (avant-dernière version) | Point d'entrée HTTPS unique, reverse proxy |
| WordPress     | CMS WordPress + php-fpm sans NGINX             | Alpine/Debian (avant-dernière version) | Service séparé sans NGINX               |
| MariaDB       | Base de données MariaDB sans NGINX             | Alpine/Debian (avant-dernière version) | Volume pour persistance des données     |

## Volumes Docker
- Volume pour la base de données MariaDB, monté sur `/home/<login>/data/db`.
- Volume pour les fichiers du site WordPress, monté sur `/home/<login>/data/www`.

## Réseau Docker
- Un réseau Docker personnalisé est configuré pour permettre la communication sécurisée entre les conteneurs.
- Interdiction d'utiliser `network: host`, `--link` ou `links:`.

## Règles importantes
- Chaque container doit redémarrer automatiquement en cas de crash (`restart: always`).
- Pas d'utilisation de "hacky patch" comme `tail -f`, `bash`, `sleep infinity` pour maintenir un container actif.
- Chaque Dockerfile écrit à la main, avec optimisation des couches.
- Pas de tag `latest` pour les images.
- Les mots de passe et secrets ne doivent pas apparaître dans les Dockerfiles. Utilisation obligatoire de variables d'environnement et recommandations pour Docker Secrets.
- Le compte administrateur WordPress doit avoir un nom d'utilisateur ne contenant pas "admin" ou variantes.

## Bonus réalisés
- Mise en place d'un cache Redis pour WordPress.
- Serveur FTP pointant vers le volume des fichiers WordPress.
- Petit site statique (exclu PHP) déployé via un conteneur dédié.
- Administration via Adminer déployée dans un container.
- Un service de backup de bdd (dump mysql).

## Installation et utilisation

### Prérequis
- Machine virtuelle Linux avec Docker et Docker Compose installés.
- Accès à la machine pour exécuter les commandes et copier les fichiers.

### Commandes principales
- Pour builder et lancer tous les services ainsi que la creation des dossiers si inexistants pour la persistance (depuis la racine du projet) :

```
make
```

- Pour arrêter et nettoyer les conteneurs :

```
make clean
```

- Pour arrêter et nettoyer les conteneurs ainsi que les volumes persistants:

```
make fclean
```


## Variables d'environnement recommandées (fichier `.env` et dossier secrets/ voir les exemples dans le repo)
## Remarques

- Configurez le DNS local ou fichier hosts pour que `login.42.fr` pointe vers l'adresse IP locale de la machine virtuelle.
- Respectez la non-exposition des mots de passe dans les fichiers versionnés.
- NGINX est configuré comme unique point d'entrée sur le port 443 pour gérer HTTPS.
- Chaque container est optimisé selon les bonnes pratiques Docker et respecte la gestion du PID 1 pour éviter les processus zombies ou bloquants.

