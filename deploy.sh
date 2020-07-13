#!/bin/bash

docker build -t mohsin17/multi-client:latest -t mohsin17/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mohsin17/multi-server:latest -t mohsin17/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mohsin17/multi-worker:latest -t mohsin17/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mohsin17/multi-client:latest
docker push mohsin17/multi-server:latest
docker push mohsin17/multi-worker:latest

docker push mohsin17/multi-client:$SHA
docker push mohsin17/multi-server:$SHA
docker push mohsin17/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mohsin17/multi-server:$SHA
kubectl set image deployments/client-deployment client=mohsin17/multi-client:$SHA
kubectl set image deployments/worker-deployment work=mohsin17/multi-worker:$SHA
