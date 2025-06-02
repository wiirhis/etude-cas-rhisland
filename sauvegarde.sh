#!/bin/bash

set -e           # Stop le script si une commande échoue
set -u           # Stop si une variable non initialisée est utilisée
set -o pipefail  # Stop si une commande dans un pipeline échoue

DOSSIER="./rapports/"

for fichier in "$DOSSIER"/*; do
   if [[ "$fichier" == *.bak ]]; then
     echo "$fichier - Est un fichier de sauvegarde, arrêt du scan"
     break
         elif [[ "$fichier" == *.txt ]]; then
           mkdir -p ./sauvegardes
           timestamp=$(date +%Y-%m-%d-%H-%M)
           cp -p "$fichier" ./sauvegardes/"$(basename $fichier)_sauve_${timestamp}.txt"
          echo "sauvegardes/$(basename $fichier)_sauve_${timestamp}.txt" >> sauvegarde.log
         else
          echo "$fichier :" "Non pris en compte par le script"
   fi
done