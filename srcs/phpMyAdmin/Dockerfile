FROM alpine:latest

RUN apk add vim openrc openssl supervisor nginx  \
php7 php7-fpm php7-iconv php7-json php7-mbstring php7-mysqli php7-phar php7-session && rc-update add php-fpm7 default

COPY /src/nginx.conf /src/supervisord.conf /src/config.inc.php /

RUN wget -c https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.xz && mkdir -p /var/www/phpmyadmin /var/www/phpmyadmin/tmp \
&& chmod 777 /var/www/phpmyadmin/tmp && tar -xvf phpMyAdmin-latest-english.tar.xz --strip-components 1 -C /var/www/phpmyadmin



RUN rm -f /etc/nginx/conf.d/default.conf && mv /nginx.conf /etc/nginx/conf.d/ &&  \
mv /config.inc.php /var/www/phpmyadmin/ && mv /supervisord.conf /etc/supervisord.conf && mkdir /run/nginx /var/run/php

EXPOSE 5000

CMD	["usr/bin/supervisord", "-c", "/etc/supervisord.conf"]