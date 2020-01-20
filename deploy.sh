docker build -t zagorh/multi-client:latest -t zagorh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zagorh/multi-server:latest -t zagorh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zagorh/multi-worker:latest -t zagorh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push zagorh/multi-client:latest
docker push zagorh/multi-server:latest
docker push zagorh/multi-worker:latest

docker push zagorh/multi-client:$SHA
docker push zagorh/multi-server:$SHA
docker push zagorh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zagorh/multi-server:$SHA
kubectl set image deployments/client-deployment client=zagorh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zagorh/multi-worker:$SHA