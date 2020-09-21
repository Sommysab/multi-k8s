docker build -t sommysab/multi-client:latest -t sommysab/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sommysab/multi-server:latest -t sommysab/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sommysab/multi-worker:latest -t sommysab/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push sommysab/multi-client:latest
docker push sommysab/multi-server:latest
docker push sommysab/multi-worker:latest
docker push sommysab/multi-client:$SHA
docker push sommysab/multi-server:$SHA
docker push sommysab/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sommysab/multi-server:$SHA 
kubectl set image deployments/client-deployment client=sommysab/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=sommysab/multi-worker:$SHA