#!/bin/bash
docker build -t skyuppercut/multi-client:latest -t skyuppercut/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skyuppercut/multi-server:latest -t skyuppercut/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skyuppercut/multi-worker:latest -t skyuppercut/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push skyuppercut/multi-client:latest
docker push skyuppercut/multi-server:latest
docker push skyuppercut/multi-worker:latest
docker push skyuppercut/multi-client:$SHA
docker push skyuppercut/multi-server:$SHA
docker push skyuppercut/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=skyuppercut/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=skyuppercut/multi-worker:$SHA
kubectl set image deployments/client-deployment client=skyuppercut/multi-client:$SHA