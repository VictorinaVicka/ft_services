# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tfarenga <tfarenga@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/24 14:04:41 by tfarenga          #+#    #+#              #
#    Updated: 2020/09/29 16:14:17 by tfarenga         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

minikube start --driver=virtualbox --cpus=2 --memory='3072' --disk-size='17000mb'

minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable metallb

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
eval $(minikube -p minikube docker-env)
export MINIKUBE_IP=$(minikube ip)

kubectl apply -f ./srcs/metallb/metallb-config.yaml

docker build -t nginx-image ./srcs/nginx > /dev/null
kubectl apply -f ./srcs/nginx/nginx-dep.yaml
kubectl apply -f ./srcs/nginx/nginx-serv.yaml

docker build -t ftps-image ./srcs/ftps > /dev/null
kubectl apply -f ./srcs/ftps/ftps-dep.yaml
kubectl apply -f ./srcs/ftps/ftps-serv.yaml

docker build -t mysql ./srcs/mysql > /dev/null
kubectl apply -f ./srcs/mysql/mysql-dep.yaml

docker build -t phpmyadmin-image ./srcs/phpMyAdmin > /dev/null
kubectl apply -f ./srcs/phpMyAdmin/phpmyadmin.yaml

docker build -t wordpress-image ./srcs/wordpress > /dev/null
kubectl apply -f ./srcs/wordpress/wordpress-serv.yaml
kubectl apply -f ./srcs/wordpress/wordpress-dep.yaml

docker build -t influxdb-image ./srcs/influxdb > /dev/null
kubectl apply -f ./srcs/influxdb/influxdb-serv.yaml
kubectl apply -f ./srcs/influxdb/influxdb-volume.yaml
kubectl apply -f ./srcs/influxdb/influxdb-config.yaml
kubectl apply -f ./srcs/influxdb/influxdb-secr.yaml
kubectl apply -f ./srcs/influxdb/influxdb-deploy.yaml

docker build -t telegraf-image --build-arg MINIKUBE_IP=${MINIKUBE_IP} ./srcs/telegraf > /dev/null
kubectl apply -f ./srcs/telegraf/telegraf-config.yaml
kubectl apply -f ./srcs/telegraf/telegraf-dep.yaml

docker build -t grafana-image ./srcs/grafana > /dev/null
kubectl apply -f ./srcs/grafana/grafana-config.yaml
kubectl apply -f ./srcs/grafana/grafana-secr.yaml
kubectl apply -f ./srcs/grafana/grafana-dep.yaml
