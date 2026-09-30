
# User documentation:

## What services are provided by this project?

When everything is already set up, this project can give three services, a mariadb database, a wordpress management system and a nginx server. Those three services are connected to give a website access to a wordpress management project that has a database connected, all of that with persistent data.

## Start and stop the project:


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

## Access the website and the administration panel:

Once the project is running you can access the website in the following link:

https://ralba-ji.42.fr

To access the administration panel you can go to:

https://ralba-ji.42.fr/wp_admin/

Which lead us to the following point:

## Locate passwords:

In order to enter the administration panel you will have to look for the .env file to see the users of the wordpress.

Where is the password? If the project is already set, the passwords are located in various files inside secrets/ folder, you can change the content of each file and rerun the project in order to change it for the whole project.

## Check if the services are running:

If you wish to know if the project is running you can run the following command:

	docker ps

If the output shows three services running, then the project is running correctly. If not, you may rerun the project or check the logs

	docker logs [service_name]

Where service_name is mariadb, wordpress or nginx.
