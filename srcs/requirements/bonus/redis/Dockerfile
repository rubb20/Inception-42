

FROM alpine:3.23

RUN	apk update && \
	apk add --no-cache redis && \
	rm -rf /var/cache/apk/*

EXPOSE 6379/tcp

CMD ["redis-server", "--protected-mode", "no"]