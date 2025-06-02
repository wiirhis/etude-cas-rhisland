#!/bin/bash
### Script de backup complet

set -e           # Stop le script si une commande échoue
set -u           # Stop si une variable non initialisée est utilisée
set -o pipefail  # Stop si une commande dans un pipeline échoue

dossier_a_sauvegarder="./rapports"
archive="archives/backup_$(date +%Y-%m-%d_%H-%M).tar.gz"
if [[ ! -d "$dossier_a_sauvegarder" ]]; then
   echo "Le dossier $dossier_a_sauvegarder n'existe pas." >> backup_transfer.log
   exit 1
fi
mkdir -p archives  
echo ">>>>>  Début d'archivage du $dossier_a_sauvegarder du $(date) <<<<<" >> backup_transfer.log
echo "-------------------------------------------------------------------" >> backup_transfer.log
tar -czvf "$archive" "$dossier_a_sauvegarder" >> backup_transfer.log 2>&1
# rsync -avz ./archives user@ip_srv:/tmp/backup-recu >> backup_transfer.log 2>&1
echo ">>>>>  Fin d'archivage du $dossier_a_sauvegarder du $(date) <<<<<" >> backup_transfer.log