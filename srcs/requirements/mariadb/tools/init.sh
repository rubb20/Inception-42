#!/bin/sh

if [ ! -d /var/lib/mysql/mysql ]; then
	echo "Initializing MariaDB."
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

	echo "Done."
	echo "Starting temporary MariaDB server for setup purposes."
	mariadbd --user=mysql --skip-networking &
	temporary_pid="$!"

	echo "Waiting for the server to be ready."
	until mariadb-admin ping > /dev/null 2>&1; do
		sleep 1
	done
	echo "MariaDB is ready."

	DB_PASSWORD="$(cat "$MARIADB_PASSWORD_FILE")"
	DB_ROOT_PASSWORD="$(cat "$MARIADB_ROOT_PASSWORD_FILE")"
	mariadb -u root << EOF_SQL
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE wordpress;
CREATE USER 'ruben'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO 'ruben'@'%';
FLUSH PRIVILEGES;
EOF_SQL

	echo "Setup is done. Shutting down temporary server..."
	mariadb-admin --password="$DB_ROOT_PASSWORD" shutdown
	wait "$temporary_pid" || true
else
	echo "MariaDB was already installed"
fi

echo "Starting MariaDB..."
exec mariadbd --user=mysql
