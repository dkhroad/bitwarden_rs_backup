#!/bin/sh

BACKUP_FILE=$BACKUP_FILE
CRON_TIME=$CRON_TIME

BACKUP_CMD=/backup.sh 
CRONFILE=/etc/crontabs/root
LOGFILE=/var/log/backup_to_gcs.log

if [ ! -e "$BACKUP_FILE" ]
then 
  echo "Database $BACK_FILE not found!\nPlease check if you mounted the bitwarden_rs volume with '--volumes-from=bitwarden'"!
fi

if [ $(grep -c "$BACKUP_CMD" "$CRONFILE") -eq 0 ]
then
  echo "$CRON_TIME $BACKUP_CMD >> $LOGFILE" >> "$CRONFILE"
fi

pgrep crond > /dev/null 2>&1
if [ $? -ne 0 ]
then
  /usr/sbin/crond -L /var/log/cron.log
fi

echo "$(date "+%F %T") - Container started" > "$LOGFILE"
tail -F "$LOGFILE"
