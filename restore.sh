#!/bin/sh
BACKUP_DIR=$(dirname $BACKUP_FILE)

if [ -f "$DB_FILE" && "$1" != "-f" ]; then
  echo "Database $DB_FILE already exits!"
  echo "Use -f option to override"
  exit 1
fi

gsutil/gsutil rsync  -r gs://$STORAGE_BUCKET/$BACKUP_DIR $BACKUP_DIR

if [ $? -eq 0 ] 
then 
  cp $BACKUP_DIR/backup.sqlite3 $DB_FILE
  echo "$(date "+%F %T") - restore successfull"
else
  echo "$(date "+%F %T") - restore unsuccessfull"
fi
