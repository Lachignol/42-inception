#!/bin/bash

# Modifie la ligne bind dans le fichier de configuration Redis pour permettre les connexions depuis toutes les interfaces réseau
sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf

# Écrase le fichier de configuration Redis avec les paramètres suivants :
echo <<EOF > /etc/redis/redis.conf
# Limite la mémoire utilisée par Redis à 256 mégaoctets pour éviter l'utilisation excessive des ressources mémoire
maxmemory 256mb
# Politique d'éviction : supprime les clés les moins fréquemment utilisées (LFU) parmi toutes les clés quand la mémoire max est atteinte
maxmemory-policy allkeys-lfu
EOF

# La politique d'éviction LFU (Least Frequently Used) dans Redis signifie que lorsque la mémoire maximale allouée est atteinte, Redis va commencer à supprimer les clés qui sont les moins fréquemment utilisées.
#
# Plus précisément :
#
#     Chaque clé stockée dans Redis a un compteur qui suit approximativement combien de fois cette clé est utilisée ou accédée.
#
#     Les clés qui ont un faible nombre d'accès sont considérées comme moins importantes, car elles sont peu demandées.
#
#     Quand Redis a besoin de libérer de la mémoire, il supprime les clés avec le compteur le plus bas, c'est-à-dire celles qui sont le moins fréquemment utilisées.
#
#     Cette politique permet de privilégier la conservation des données les plus utilisées et de supprimer celles qui ont peu ou pas d'intérêt, optimisant ainsi l'utilisation de la mémoire.
#
# LFU est efficace pour les cas où certaines données sont consultées beaucoup plus souvent que d'autres, et où l'on veut garder en cache ce qui est le plus utile. Redis utilise une estimation approximative pour limiter la charge de suivi, ce qui rend cette méthode performante et légère.
#
# En résumé, la politique LFU évince du cache les données les moins fréquemment sollicitées afin de préserver la mémoire pour les données plus populaires.
