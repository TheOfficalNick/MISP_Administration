#!/bin/bash

# Define variables
DB_CONTAINER_NAME="EnterNameHere"
MISP_CONTAINER_NAME="EnterNameHere"
BACKUP_DIR="/path/to/your/backup/directory"  # Replace with your desired backup directory
TIMESTAMP=$(date +"%F")

# Create a database backup
echo "Backing up MISP database..."
docker exec $DB_CONTAINER_NAME mysqldump -u root -p'your_password_here' misp > $BACKUP_DIR/misp_db_backup_$TIMESTAMP.sql

# Create a file system backup
echo "Backing up MISP files..."
docker run --rm --volumes-from $MISP_CONTAINER_NAME -v $BACKUP_DIR:/backup ubuntu tar czvf /backup/misp_files_backup_$TIMESTAMP.tar.gz /var/www/MISP

echo "Backup completed successfully."
