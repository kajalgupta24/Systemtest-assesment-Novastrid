#!/bin/bash

SOURCE_DIR="/var/www/app"
BACKUP_DIR="/backup/"
timestamp=$(date +%Y-%m-%d)
BACKUP_FILE="$BACKUP_DIR/app-backup-$TIMESTAMP.tar.gz"
RETENTION_DAYS=7

check_dependencies() {
   DEPENDENCIES=("tar" "gzip" "cron")
   for cmd in "${DEPENDENCIES[@]}"; do
      if ! command -v $cmd &> /dev/null; then
          echo "Error: $cmd is not installed."
          exit 1
      fi
   done
}

create_backup() {
   mkdir -p "$BACKUP_DIR"
   tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .
   echo "Backup created: $BACKUP_FILE"
}

clean_old_backups() {
    find "$BACKUP_DIR" -type d -name "*.tar.gz" -mtime + $RETENTION_DAYS -exec rm -f {} \;
    echo "Old backup cleaned."
}

main() {
  echo "Starting backup process.."
  check_dependencies
  create_backup
  clean_old_backups
  echo "Backup process completed."
}

main  








