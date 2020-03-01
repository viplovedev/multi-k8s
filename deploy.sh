docker build -t viplovedev/multi-client:latest -t viplovedev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t viplovedev/multi-server:latest -t viplovedev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t viplovedev/multi-worker:latest -t viplovedev/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push viplovedev/multi-client:latest
docker push viplovedev/multi-server:latest
docker push viplovedev/multi-worker:latest

docker push viplovedev/multi-client:$SHA
docker push viplovedev/multi-server:$SHA
docker push viplovedev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=viplovedev/multi-server:$SHA
kubectl set image deployments/client-deployment client=viplovedev/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=viplovedev/multi-worker:$SHA