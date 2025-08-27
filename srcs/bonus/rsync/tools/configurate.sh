# # Sauvegarde tous les jours à 2h du matin
# 0 2 * * * /backup.sh
#
# # Sauvegarde chaque lundi à 8h
# 0 8 * * 1 /backup.sh
#
# # Sauvegarde toutes les heures
# 0 * * * * /backup.sh
#
# # Sauvegarde toutes les 10 minutes
# */10 * * * * /backup.sh
#
# # Sauvegarde toutes les 2 minutes
# */02 * * * * /backup.sh
#
# # Sauvegarde tous les dimanches à minuit
# 0 0 * * 0 /backup.sh
#
# # Sauvegarde tous les premiers jours du mois à 3h du matin
# 0 3 1 * * /backup.sh

# Ligne de cron exécutant le script /backup.sh toutes les 10 minutes

# Syntaxe de la planification : */10 * * * *
# */10      -> Exécution toutes les 10 minutes (0, 10, 20, 30, 40, 50)
# *         -> Toutes les heures
# *         -> Tous les jours du mois
# *         -> Tous les mois
# *         -> Tous les jours de la semaine

# Déclare une variable cron_job qui contient la planification et la commande à exécuter.
cron_job="*/02 * * * * /backup.sh"
# Utilise echo pour envoyer le contenu de la variable cron_job.
# Le pipe | envoie cette sortie à la commande crontab -.
# La commande crontab - remplace la crontab courante de l'utilisateur par la nouvelle entrée reçue sur son entrée standard.
echo "$cron_job" | crontab -
