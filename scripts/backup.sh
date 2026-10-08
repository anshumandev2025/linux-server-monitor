#!/bin/bash

SOURCE_DIR="/home/ubuntu/important-data"
S3_BUCKET="s3://my-linux-server-backups-12345"

DATE=$(date +%Y-%m-%d_%H-%M-%S)

BACKUP_FILE="backup-$DATE.tar.gz"

tar -czf "/tmp/$BACKUP_FILE" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
    echo "Backup archive created: $BACKUP_FILE"

    aws s3 cp "/tmp/$BACKUP_FILE" "$S3_BUCKET/"

    if [ $? -eq 0 ]; then
        echo "Backup uploaded successfully"
        rm "/tmp/$BACKUP_FILE"
    else
        echo "ERROR: S3 upload failed"
        exit 1
    fi
else
    echo "ERROR: Backup creation failed"
    exit 1
fi
