FROM	alpine:3.7

RUN		apk update && apk add openssl vsftpd openrc

RUN 	openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes -out /etc/vsftpd/vsftpd.pem \
	-keyout /etc/vsftpd/vsftpd.pem -subj "/C=RU/ST=Msc/L=Msc/O=21 School/OU=tfarenga/CN=tfarenga" && echo 'root:root' | chpasswd \
&& mkdir -p /var/log/ftp && touch /var/log/ftp/xferlog && rc default

VOLUME	["sys/fs/cgroup"]
EXPOSE 	21
COPY	src/vsftpd.conf		/etc/vsftpd/vsftpd.conf
ENTRYPOINT	vsftpd /etc/vsftpd/vsftpd.conf