FROM alpine:latest
RUN apk add --update curl python py-crcmod gettext
RUN curl -O  https://storage.googleapis.com/pub/gsutil.tar.gz && \
    tar xfz gsutil.tar.gz && \
    rm -f gsutil.tar.gz

COPY start.sh backup.sh restore.sh boto.template /

ENV DB_FILE  /data/db.sqlite3
ENV BACKUP_FILE /data/db-backup/backup.sqlite3
ENV CRON_TIME "0 5 * * *"
ENV TIMESTAMP false
ENV STORAGE_BUCKET bitwarden_ace_thought

RUN chmod 700 /start.sh /backup.sh

CMD envsubst < /boto.template > /root/.boto && /start.sh

