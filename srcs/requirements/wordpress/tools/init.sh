#!/bin/sh

MARIADB_DB_PASSWORD="$(cat "$WORDPRESS_DB_PASSWORD_FILE")"
WORDPRESS_ADMIN_PASSWORD="$(cat "$WORDPRESS_ADMIN_PASSWORD_FILE")"
WORDPRESS_USER_PASSWORD="$(cat "$WORDPRESS_USER_PASSWORD_FILE")"
cd	/var/www/html

if [ ! -f  "wp-config.php" ]; then

	echo "Initializing Wordpress."

	wp core download --allow-root

	wp config create \
		--dbname="${WORDPRESS_DATABASE}" \
		--dbuser="${WORDPRESS_DB_USER}" \
		--dbpass="${MARIADB_DB_PASSWORD}" \
		--dbhost="mariadb:3306" \
		--allow-root

	wp core install \
		--url="https://${DOMAIN_NAME}" \
		--title="My Wordpress Site" \
		--admin_user="ruben" \
		--admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
		--admin_email="ruben@example.com" \
		--allow-root

	wp user create "${WORDPRESS_USER}" "${WORDPRESS_USER}@example.com" \
		--user_pass="${WORDPRESS_USER_PASSWORD}" \
		--role=author

	wp option update home "https://${DOMAIN_NAME}" --allow-root
	wp option update siteurl "https://${DOMAIN_NAME}" --allow-root

	ping redis -c 1
	if [ $? -eq 0 ]; then

		wp plugin install redis-cache --activate --path=/var/www/html

		wp config set WP_REDIS_HOST 'redis' 
		wp redis enable --allow-root
		echo "Redis is set up"
	fi

	echo "Wordpress is already initialized!"
fi

echo "Starting PHP-FPM..."
exec php-fpm83 -F
