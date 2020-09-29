FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add nginx openssl openssh supervisor
RUN apk add openrc

ARG			IP
VOLUME		[ "/sys/fs/cgroup" ]
RUN			mkdir -p /run/nginx
RUN			rm -f /etc/nginx/conf.d/*.conf
COPY		./nginx.conf /etc/nginx/conf.d/default.conf

RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes -out /etc/ssl/private/tfarenga.crt \
	-keyout /etc/ssl/private/tfarenga.key -subj "/C=RU/ST=Moscow/L=Moscow/O=21 School/OU=tfarenga/CN=tfarenga"

RUN			sed -i "s/aaaipaaa/${IP}/g" /etc/nginx/conf.d/default.conf
RUN			echo "daemon off;" >> /etc/nginx/nginx.conf

COPY		./supervisor.conf /etc/supervisord.conf
RUN			chmod +rw /etc/supervisord.conf
RUN			echo -e "tfarenga\ntfarenga" | adduser ssh_peer
COPY		./start.sh /tmp/start.sh
RUN			chmod u+x /tmp/start.sh

EXPOSE		443 80 22
ENTRYPOINT	["/tmp/start.sh"]