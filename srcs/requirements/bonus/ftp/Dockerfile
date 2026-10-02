

FROM alpine:3.23

RUN	apk update && \
	apk add --no-cache vsftpd && \
	rm -rf /var/cache/apk/*

COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY ./tools/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

ENTRYPOINT ["init.sh"]
