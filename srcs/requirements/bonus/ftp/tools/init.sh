#!/bin/sh

FTP_PASSWORD="$(cat $FTP_PASSWORD_FILE)"

id "$FTP_USER" >/dev/null 2>&1
user_exists=$?

if [ "$user_exists" -ne 0 ]; then

	echo "Setting up FTP user"

	adduser -D -h /var/www/html "$FTP_USER"

    echo "$FTP_USER":"$FTP_PASSWORD" | chpasswd
    
    chown -R "$FTP_USER":"$FTP_USER" /var/www/html
fi

echo "FTP running"
exec vsftpd /etc/vsftpd/vsftpd.conf