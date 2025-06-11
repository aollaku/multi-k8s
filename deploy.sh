docker build -t aollaku/multi-client:latest -t aollaku/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aollaku/multi-server:latest -t aollaku/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aollaku/multi-worker:latest -t aollaku/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aollaku/multi-client
docker push aollaku/multi-server
docker push aollaku/multi-worker

docker push aollaku/multi-client:$SHA
docker push aollaku/multi-server:$SHA
docker push aollaku/multi-worker:$SHA


kubectl apply -f k8s

kubectl set image deployments/server-deployment server=aollaku/multi-server:$SHA
kubectl set image deployments/client-deployment client=aollaku/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aollaku/multi-worker:$SHA