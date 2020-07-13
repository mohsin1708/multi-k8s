#!/bin/bash

docker build -t mohsin17/multi-client:$SHA ./client/Dockerfile ./client
docker build -t mohsin17/multi-server:$SHA ./server/Dockerfile ./server
docker build -t mohsin17/multi-worker:$SHA ./worker/Dockerfile ./worker


docker push mohsin17/multi-client:$SHA
docker push mohsin17/multi-server:$SHA
docker push mohsin17/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mohsin17/multi-server:$SHA
kubectl set image deployments/client-deployment client=mohsin17/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mohsin17/multi-worker:$SHA
