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
    echo "❌ Namespace '$NAMESPACE' does not exist. Please create the namespace and try again."
    echo "----------EXAMPLE COMMAND: kubectl create namespace $NAMESPACE"
    exit 0
  fi
done

echo "Creating Spring Boot demo application for Kubernetes on local environment"

if [[ -z $1 ]];
then
# echo "Please specify one of the following:";

echo "nginx";
echo "app";
echo "db";
echo "ingress";
echo "load";
echo "all";
read -rp "Please specify one of the following: " DEPLOYMENT;
fi

echo "🔧 Performing operations for '$DEPLOYMENT' service(s) in namespace '$NAMESPACE'..."

if [[ $DEPLOYMENT == "nginx" || $DEPLOYMENT == "all" ]];
then
    ### Create configmap for nginx
    kubectl create -f deploy/web/nginx-conf-configmap.yaml -n "$NAMESPACE"
    kubectl create -f deploy/web/server-conf-configmap.yaml -n "$NAMESPACE"
    
    # nginx
    kubectl create -f deploy/web/deployment.yaml -n "$NAMESPACE"
    kubectl create -f deploy/web/service.yaml -n "$NAMESPACE"
fi;

### Create deployments and services


if [[ $DEPLOYMENT == "db" || $DEPLOYMENT == "all" ]];
then
# db
kubectl create -f deploy/db/statefulset.yaml -n "$NAMESPACE"
kubectl create -f deploy/db/service.yaml -n "$NAMESPACE"
fi

if [[ $DEPLOYMENT == "app" || $DEPLOYMENT == "all" ]];
then
# app (For Local environment)
kubectl create -f deploy/app/deployment.yaml -n "$NAMESPACE"
kubectl create -f deploy/app/service.yaml -n "$NAMESPACE"
fi


if [[ $DEPLOYMENT == "ingress" || $DEPLOYMENT == "all" ]];
then
# ingress
kubectl create -f deploy/lb/ingress.yaml -n "$NAMESPACE"
fi

if [[ $DEPLOYMENT == "load" || $DEPLOYMENT == "all" ]];
then
# load
kubectl create configmap locustfile --from-file=deploy/load/locustfile.py -n "$NAMESPACE"
kubectl create -f deploy/load/load.yaml -n "$NAMESPACE"
fi;

