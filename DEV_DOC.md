
# Developer documentation

## Setup and prerequisites:

The Inception project works over docker and docker compose. Please make sure that you have them installed using the following commands:

	docker --version && docker compose version

You also have a makefile to work with this, to check if you can use make, run the following command:

	make --version

Configuration files as well as docker compose secrets architecture are already described and implemented in the proyect. The services need some password and certificates to work correctly and you need to create them for Docker Secrets to recognise them and securely hand them to its respective containers.

## Environment variables:

A few environment variables are used by docker compose to hand user names and domain name for wordpress. The .env file is obviously not inside the project even though it doesn't hold any key or secret.

Make sure to create the .env from the .env_template file.

	cp /src/.env_template /src/.env

Then, in the .env file, fill the variables with your desired user names and domain name, keep in mind you might also want to change /etc/hosts to make it work directly in your browser.

Please, take into account you have absolutely no way of changing the administrator name in the .env file. If you really wish to change its name, which is "ruben" by default, you must change the init.sh file from wordpress configuration container.

## Passwords and certificates:

A folder named 'secrets' must be created at the root of this project for the secrets and certificates.

### Database passwords:

A text file named 'db_password.txt' and located inside secrets folder must contain the password the non-admin user (defined in .env) will have. 

A text file named 'db_root_password.txt' and located inside secrets folder must contain the password the root will have.

### Wordpress passwords:

A text file named 'wp_password.txt' and located inside secrets folder must contain the password for the non-admin user.

A text file named 'wp_admin_password.txt' must contain the password for the admin user (ruben, by default).

A reminder: please, take into account you have absolutely no way of changing the administrator name in the .env file. If you really wish to change its name, which is "ruben" by default, you must change the init.sh file from wordpress configuration container.

### Nginx certificates:

In order to use secure connections through TLS a certificate and key must be located and called nginx.crt and nginx.key

You can use the following command inside secrets folder to get a self-signed certificate.

    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout "nginx.key" \
        -out "nginx.crt" \
        -subj "/C=ES/ST=Madrid/L=Madrid/O=Inception/CN=localhost"

## Launching the project:

You can use Makefile to build the images.

	make 

or

	make Inception

To build AND run the project you can use:

	make run

You can also stop the running containers with:

	make down

You can clean the system:

	make clean

You can also stop the containers, clean the system and erase the persistent data:

	make fclean

## Persistent data storage:

Both mariadb and wordpress have defined volumes which are mounted on home/ralba-ji/data/, unless you use make fclean, which makes sure to clean that data, you can stop the project and re run it without creating the volumes and installing everything.

