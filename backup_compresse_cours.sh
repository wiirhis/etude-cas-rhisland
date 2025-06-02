#!/bin/bash

set -euo pipefail

DATE=$(date +%Y-%m-%d_%H-%M)
SRC="./rapports"
DEST="./archives"
LOG="backup_transfer.log"

mkdir -p "$DEST"
ARCHIVE="$DEST/backup_${DATE}.tar.gz"

tar -czvf "$ARCHIVE" "$SRC" >> "$LOG" 2>&1
echo "$(date) - Sauvegarde compressée créée : $ARCHIVE" >> "$LOG"

# (Optionnel) Transfert avec rsync
rsync -avz "$ARCHIVE" rhisland@192.168.1.57:/tmp/backup-recu >> "$LOG" 2>&1