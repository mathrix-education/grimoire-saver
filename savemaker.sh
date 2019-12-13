#!/bin/ash

date=$(date '+%Y-%m-%d_%H-%M-%S')
mysqldump --user=bookstack --password=salome3004 --host=192.168.92.232 bookstack > ./grimoire-$date.sql
gzip grimoire-$date.sql
/google-cloud-sdk/bin/gsutil cp grimoire-$date.sql.gz gs://mathrix-backups/databases/scaleway_grimoire/grimoire-$date.sql.gz
exit 0
