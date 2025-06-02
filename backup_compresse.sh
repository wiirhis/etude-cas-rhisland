#!/bin/bash
### Script de backup complet

set -e           # Stop le script si une commande échoue
set -u           # Stop si une variable non initialisée est utilisée
set -o pipefail  # Stop si une commande dans un pipeline échoue

dossier_a_sauvegarder="./rapports"
mkdir -p archives  
echo ">>>>>  Début d'archivage du $dossier_a_sauvegarder du $(date) <<<<<" >> backup_transfer.log
tar -czvf backup_$(date +%Y-%m-%d_%H-%M).tar.gz $dossier_a_sauvegarder >> backup_transfer.log
mv $dossier_a_sauvegarder ./archives >> backup_transfer.log 
rsync -avz ./archives rhisland@192.168.1.57:/tmp/backup-recu >> backup_transfer.log
echo ">>>>>  Fin d'archivage du $dossier_a_sauvegarder du $(date) <<<<<" >> backup_transfer.log