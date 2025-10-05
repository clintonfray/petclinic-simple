#!/bin/bash

echo "Deleting Spring Boot demo application for Kubernetes on local environment"


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
    kubectl delete configmap nginx-conf
    kubectl delete configmap server-conf
    
    # nginx
    kubectl delete -f deploy/web/deployment.yaml
    kubectl delete -f deploy/web/service.yaml
fi;

### Create deployments and services

# if [[ $1 == "otel" || $1 == "all" ]];
# then
# # opentelemtry collector
# kubectl delete -f deploy/otelcol/config_map.yaml
# kubectl delete -f deploy/otelcol/deployment.yaml
# kubectl delete -f deploy/otelcol/service_account.yaml
# kubectl delete -f deploy/otelcol/service.yaml
# fi

if [[ $1 == "db" || $1 == "all" ]];
then
# db
kubectl delete -f deploy/db/statefulset.yaml
kubectl delete -f deploy/db/service.yaml
fi

if [[ $1 == "app" || $1 == "all" ]];
then
# app (For Local environment)
# kubectl delete -f deploy/app/pv.yaml
# kubectl delete -f deploy/app/pvc.yaml
kubectl delete -f deploy/app/deployment.yaml
kubectl delete -f deploy/app/service.yaml
fi


if [[ $1 == "ingress" || $1 == "all" ]];
then
# ingress
kubectl delete -f deploy/lb/ingress.yaml
fi

if [[ $1 == "load" || $1 == "all" ]];
then
# load
kubectl delete configmap locustfile
kubectl delete -f deploy/load/load.yaml
fi;
