#!/bin/sh
BACKUP_DIR=$(dirname "$BACKUP_FILE")
if [ ! -d  "$BACKUP_DIR" ]
then
  echo "Database $BACK_FILE not found!"
  echo "Please check if bitwarden backup container is running!"
  exit 1;
fi


gsutil/gsutil rsync  -r "$BACKUP_DIR" gs://$STORAGE_BUCKET/$BACKUP_DIR

if [ $? -eq 0 ] 
then 
  echo "$(date "+%F %T") - Backup successfull"
else
  echo "$(date "+%F %T") - Backup unsuccessfull"
fi
