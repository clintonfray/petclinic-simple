#!/bin/bash

# Function to check if namespace exists
function namespace_exists() {
  kubectl get namespace "$1" &> /dev/null
  return $?
}

# Prompt user until a valid namespace is given
while true; do
  read -rp "Enter Kubernetes namespace: " NAMESPACE
  if namespace_exists "$NAMESPACE"; then
    echo "✅ Namespace '$NAMESPACE' exists. Proceeding..."
    break
  else
    echo "❌ Namespace '$NAMESPACE' does not exist. Please try again."
  fi
done

echo "Deleting Spring Boot demo application for Kubernetes on local environment"


if [[ -z $1 ]];
then
echo "nginx";
echo "app";
echo "db";
echo "ingress";
echo "load";
echo "all";
read -rp "Please specify one of the following: " DEPLOYMENT;
fi


if [[ $DEPLOYMENT == "nginx" || $DEPLOYMENT == "all" ]];
then
    ### Create configmap for nginx
    kubectl delete configmap nginx-conf -n "$NAMESPACE"
    kubectl delete configmap server-conf -n "$NAMESPACE"
    
    # nginx
    kubectl delete -f deploy/web/deployment.yaml -n "$NAMESPACE"
    kubectl delete -f deploy/web/service.yaml -n "$NAMESPACE"
fi;

### Create deployments and services

if [[ $DEPLOYMENT == "db" || $DEPLOYMENT == "all" ]];
then
# db
kubectl delete -f deploy/db/statefulset.yaml -n "$NAMESPACE"
kubectl delete -f deploy/db/service.yaml -n "$NAMESPACE"
fi

if [[ $DEPLOYMENT == "app" || $DEPLOYMENT == "all" ]];
then
# app (For Local environment)
kubectl delete -f deploy/app/deployment.yaml -n "$NAMESPACE"
kubectl delete -f deploy/app/service.yaml -n "$NAMESPACE"
fi


if [[ $DEPLOYMENT == "ingress" || $DEPLOYMENT == "all" ]];
then
# ingress
kubectl delete -f deploy/lb/ingress.yaml -n "$NAMESPACE"
fi

if [[ $DEPLOYMENT == "load" || $DEPLOYMENT == "all" ]];
then
# load
kubectl delete configmap locustfile -n "$NAMESPACE"
kubectl delete -f deploy/load/load.yaml -n "$NAMESPACE"
fi;
