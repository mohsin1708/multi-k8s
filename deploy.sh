docker build -t mohsin17/multi-client:latest -t mohsin17/multi-client:$SHA ./client/Dockerfile ./client1
docker build -t mohsin17/multi-server:latest -t mohsin17/multi-server:$SHA ./server/Dockerfile ./server
docker build -t mohsin17/multi-worker:latest -t mohsin17/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push mohsin17/multi-client:latest
docker push mohsin17/multi-server:latest
docker push mohsin17/multi-worker:latest

docker push mohsin17/multi-client:$SHA
docker push mohsin17/multi-server:$SHA
docker push mohsin17/multi-worker:$SHA

kubectl apply -f k8s
kubect set image deployments/server-deployment server=mohsin17/multi-server:$SHA
kubect set image deployments/client-deployment server=mohsin17/multi-client:$SHA
kubect set image deployments/worker-deployment server=mohsin17/multi-worker:$SHA
