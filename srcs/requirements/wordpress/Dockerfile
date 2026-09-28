
FROM alpine:3.23

RUN	apk update && \
	apk add --no-cache wget php83 php83-fpm php83-mysqli php83-phar php83-iconv && \
	rm -rf /var/cache/apk/*

RUN	echo "memory_limit=512M" > /etc/php83/conf.d/99-memory.ini

RUN	mkdir -p /var/www/html

RUN	ln -s /usr/bin/php83 /usr/bin/php

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY	conf/www.conf /etc/php83/php-fpm.d/

COPY	./tools/init.sh /usr/local/bin/init.sh
RUN	chmod +x /usr/local/bin/init.sh

EXPOSE 9000/tcp

ENTRYPOINT ["init.sh"]
