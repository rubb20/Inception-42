#Create container from alpine penultimate stable version. Cant use latest
#that would make the container update itself (and have errors)
FROM alpine:3.23

#RUN: execute commands DURING the build phase of docker image.
#apk update: update everything
#apk add --no-cache: installs and doesnt store in cache
#mariadb: server. contains engine daemon (mariadbd). manages database.
#mariadb-client: contains command-line tools to talk to the server
#rm -rf /var/cache/apk/* guarantees temporary files to be wiped out.
RUN	apk update && \
	apk add --no-cache mariadb mariadb-client && \
	rm -rf /var/cache/apk/*

#my.cnf is a common name to specific configuration directories (.d)
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

#RUN: create directories required by mariadb to work
#and give ownership to mysql user and group
RUN echo "--- CREATING MYSQL DIRECTORIES ---"
RUN	mkdir -p /var/lib/mysql /run/mysqld/ && \ 
	chown -R mysql:mysql /var/lib/mysql /run/mysqld
	
#ENTRYPOINT: a database needs to be installed and cannot just start blank.
#It needs a boot sequence.
#Therefore, an entrypoint exists
#copy entrypoint script to the container
COPY ./tools/init.sh /usr/local/bin/init.sh
#RUN: give permissions to execute
RUN chmod +x /usr/local/bin/init.sh

#In reality this doesnt do anything. Documentation.
EXPOSE 3306/tcp

ENTRYPOINT ["init.sh"]
