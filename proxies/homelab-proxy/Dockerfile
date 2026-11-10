FROM alpine:latest
RUN apk add --no-cache wireguard-tools iproute2 iputils-ping
COPY src/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]