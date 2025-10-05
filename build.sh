#!/bin/bash

echo "------------------- Building Application -------------------"
docker build ./app_src -f ./app_src/Dockerfile -t clfray/spring-petclinic-app:24.08.15 --platform=linux/amd64

echo "------------------- Building Database -------------------"
docker build ./deploy/db -f ./deploy/db/Dockerfile -t clfray/spring-petclinic-db:24.08.15 --platform=linux/amd64

echo "------------------- Building Nginx -------------------"
docker build . -f ./deploy/web/Dockerfile -t clfray/spring-petclinic-nginx:24.08.15 --platform=linux/amd64

echo "------------------- Building Load -------------------"
docker build ./deploy/load -f ./deploy/load/Dockerfile -t clfray/spring-petclinic-load:24.08.15 --platform=linux/amd64

echo "------------------- Pushing Images -------------------"
d clfray/spring-petclinic-app:24.08.15
docker push clfray/spring-petclinic-db:24.08.15
docker push clfray/spring-petclinic-load:24.08.15
docker push clfray/spring-petclinic-nginx:24.08.15


