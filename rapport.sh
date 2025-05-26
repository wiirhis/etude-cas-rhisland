#!/bin/bash

set -e           # Stop le script si une commande échoue
set -u           # Stop si une variable non initialisée est utilisée
set -o pipefail  # Stop si une commande dans un pipeline échoue

dossier="./rapports"

echo "Voulez-vous créer un rapport ? (O/N)"
read reponse
while [ $reponse == O ]; do
 echo "Veuillez saisir votre prénom :"
 read prenom_user 

 if [[ -z "$prenom_user" ]] then
 echo "Vouz devez saisir votre prénom"
 exit 1
 fi

 echo "Quel est votre nom ? :"
 read nom_user

 if [[ -z "$nom_user" ]] then
 echo "Vouz devez saisir votre nom"
 exit 1
 fi

 echo "Quel est le titre du rapport ? :"
 read titre_rapport

 if [[ -z "$titre_rapport" ]] then
 echo "Vouz devez saisir le titre du rapport"
 exit 1
 fi

 mkdir . -p rapports
 touch ./rapports/"$prenom_user"_"$nom_user"_"$titre_rapport"_$(date +%Y-%m-%d-%H-%M).txt
 echo "$(date) : ./rapports/"$prenom_user"_"$nom_user"_"$titre_rapport"_$(date +%Y-%m-%d-%H-%M).txt" >> actions.log
 git add .
 git commit -m "Création du rapport "$prenom_user"_"$nom_user"_"$titre_rapport"_$(date +%Y-%m-%d-%H-%M).txt"

 for fichier in "$dossier"; do
   echo "### Listes des rapports ###"
   ls -l "$dossier" | awk '{print $9}'
 done
 echo "### Liste des rapports créés ###" >> resume.log
 ls -l "$dossier" | awk '{print $9}' >> resume.log
 echo "### Nombre total de fichiers .txt" >> resume.log
 ls -l "$dossier"/*.txt 2>/dev/null | wc -l >> resume.log
 echo "### La date du dernier commit Git ###" >> resume.log
 git log -1 >> resume.log
 echo "### Utilisateur actuel et heure système ###" >> resume.log
 whoami && date >> resume.log
 echo "###### FIN DU SCRIPT #########"
 exit 1
done
