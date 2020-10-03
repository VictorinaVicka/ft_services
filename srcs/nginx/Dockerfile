FROM 	alpine:latest

COPY 	./src/nginx.conf ./src/index.html ./src/supervisord.conf ./
RUN apk add openrc openssl openssh nginx vim bash sudo supervisor

RUN 	openssl req -newkey rsa:2048 -x509 -sha256 -days 30 -nodes -out /etc/ssl/private/tfarenga.crt \
	-keyout /etc/ssl/private/tfarenga.key -subj "/C=RU/ST=Msc/L=Msc/O=21 School/OU=tfarenga/CN=tfarenga"

RUN 	adduser -D tfarenga && echo 'tfarenga:123' | chpasswd && addgroup tfarenga wheel && echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel \
&& /usr/bin/ssh-keygen -A

RUN 	rm /etc/nginx/conf.d/default.conf && mv /nginx.conf /etc/nginx/conf.d/ \
&& mv /index.html /var/www/ \
&& mkdir /run/nginx /var/run/sshd && mv /supervisord.conf /etc/supervisord.conf

EXPOSE 	22 80 443
CMD		["usr/bin/supervisord", "-c", "/etc/supervisord.conf"]