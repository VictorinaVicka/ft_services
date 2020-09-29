FROM alpine:latest

#installing
RUN apk update && apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

#copying config files
COPY grafana-secr.yaml /usr/share/grafana/conf/provisioning/datasources/grafana-secr.yaml
RUN mkdir /usr/share/grafana/conf/provisioning/dashboards/mine
COPY dashboards/*.json /usr/share/grafana/conf/provisioning/dashboards/mine/
COPY grafana-config.yaml /usr/share/grafana/conf/provisioning/dashboards/grafana-config.yaml

#copying script for starting nginx and infinite loop to prevent exit
COPY start.sh /home/script/start.sh
#giving rights
RUN chmod 777 /home/script/start.sh
#container start
ENTRYPOINT [ "/home/script/start.sh" ]