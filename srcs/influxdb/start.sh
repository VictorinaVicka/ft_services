#!/bin/sh

kubectl create configmap influxdb-config.yaml --from-file=influxdb.conf
kubectl get configmaps influxdb-config.yaml  -o yaml > influxdb-config.yaml