FROM alpine:3.15.0
RUN apk add --update curl ca-certificates
COPY watchactuator.sh .
RUN chmod +x watchactuator.sh
CMD ["/bin/sh", "watchactuator.sh"]
