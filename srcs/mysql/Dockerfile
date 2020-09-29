FROM	alpine:latest

RUN		apk update
RUN		apk add mysql mysql-client
RUN 	apk add --no-cache --upgrade bash && rm -rf /var/cache/apk/*
RUN 	apk add openrc
RUN 	mkdir -p /run/mysqld
COPY	start.sh /tmp/
RUN		chmod +x /tmp/start.sh
COPY	init.txt /tmp/
COPY 	./wordpress.sql /tmp/wordpress.sql
COPY 	./conf.cnf /etc/mysql/

EXPOSE	3306
VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["/tmp/start.sh"]