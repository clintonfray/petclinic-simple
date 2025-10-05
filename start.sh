#!/bin/bash

echo "Creating Spring Boot demo application for Kubernetes on local environment"


if [[ -z $1 ]];
then
echo "Please specify one of the following:";
echo "nginx";
echo "app";
echo "db";
echo "ingress";
echo "load";
echo "all";
fi


if [[ $1 == "nginx" || $1 == "all" ]];
then
    ### Create configmap for nginx
    kubectl create configmap nginx-conf --from-file=deploy/web/nginx.conf
    kubectl create -f deploy/web/server-conf-configmap.yaml
    
    # nginx
    kubectl create -f deploy/web/deployment.yaml
    kubectl create -f deploy/web/service.yaml
fi;

### Create deployments and services

# if [[ $1 == "otel" || $1 == "all" ]];
# then
# # opentelemtry collector
# kubectl create -f deploy/otelcol/config_map.yaml
# kubectl create -f deploy/otelcol/deployment.yaml
# kubectl create -f deploy/otelcol/service_account.yaml
# kubectl create -f deploy/otelcol/service.yaml
# fi

if [[ $1 == "db" || $1 == "all" ]];
then
# db
kubectl create -f deploy/db/statefulset.yaml
kubectl create -f deploy/db/service.yaml
fi

if [[ $1 == "app" || $1 == "all" ]];
then
# app (For Local environment)
# kubectl create -f deploy/app/pv.yaml
# kubectl create -f deploy/app/pvc.yaml
kubectl create -f deploy/app/deployment.yaml
kubectl create -f deploy/app/service.yaml
fi


if [[ $1 == "ingress" || $1 == "all" ]];
then
# ingress
kubectl create -f deploy/lb/ingress.yaml
fi

if [[ $1 == "load" || $1 == "all" ]];
then
# load
kubectl create configmap locustfile --from-file=deploy/load/locustfile.py
kubectl create -f deploy/load/load.yaml
fi;

