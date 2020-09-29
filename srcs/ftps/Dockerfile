FROM alpine:latest

WORKDIR /srcs
RUN apk update && apk upgrade
RUN apk add --no-cache openssl vsftpd

COPY ./vsftpd.conf /etc/vcftpd/vsftpd.conf
COPY ./start.sh /tmp/

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ftps.key -out /etc/ssl/certs/ftps.crt -subj "/C=RU/ST=Moscow/O=21school/CN=tfarenga"

RUN echo "tfarenga\tfarenga" | chpasswd

EXPOSE 20 21 2020 2021
VOLUME [ "var/lib/ftp" ]
ENTRYPOINT [ "/tmp/start.sh" ]