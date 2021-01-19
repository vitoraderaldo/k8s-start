docker build -t vitor96k/multi-client:latest -t vitor96k/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vitor96k/multi-server:latest -t vitor96k/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vitor96k/multi-worker:latest -t vitor96k/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vitor96k/multi-client:latest
docker push vitor96k/multi-server:latest
docker push vitor96k/multi-worker:latest

docker push vitor96k/multi-client:$SHA
docker push vitor96k/multi-server:$SHA
docker push vitor96k/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vitor96k/multi-server:$SHA
kubectl set image deployments/client-deployment client=vitor96k/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vitor96k/multi-worker:$SHA