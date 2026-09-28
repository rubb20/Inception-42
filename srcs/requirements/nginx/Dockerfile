
FROM alpine:3.23

RUN	apk update && \
	apk add --no-cache nginx && \
	rm -rf /var/cache/apk/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"]
