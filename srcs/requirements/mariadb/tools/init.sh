#!/bin/sh

if [ ! -d /var/lib/mysql/mysql ]; then
	echo "Initializing MariaDB."
	mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

	echo "Done."
	echo "Starting temporary MariaDB server for setup purposes."
	mariadbd --user=mysql &
	temporary_pid="$!"

	echo "Waiting for the server to be ready."
	until mariadb-admin ping > /dev/null 2>&1; do
		sleep 1
	done
	echo "MariaDB is ready."
	
	mariadb -u root << 'EOF_SQL'
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
CREATE DATABASE wordpress;
CREATE USER 'ruben'@'%' IDENTIFIED BY 'ruben';
GRANT ALL PRIVILEGES ON wordpress.* TO 'ruben'@'%';
FLUSH PRIVILEGES;
EOF_SQL

	echo "Setup is done. Shutting down temporary server..."
	mariadb-admin --password=root shutdown
	wait "$temporary_pid" || true
else
	echo "MariaDB was already installed"
fi

echo "Starting MariaDB..."
exec mariadbd --user=mysql

