
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout "$KEY" \
        -out "$CERT" \
        -subj "/C=ES/ST=Madrid/L=Madrid/O=Inception/CN=localhost"

