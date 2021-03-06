#!/bin/bash
 
echo "Creating Elasticsearch services..."

kubectl create namespace es-cluster

kubectl create -f es-discovery.yaml
kubectl create -f es-svc.yaml
kubectl create -f es-master.yaml
 
# Check to see if the deployments are running
while true; do
    active=`kubectl get deployments --all-namespaces | grep es-master | awk '{print $6}'`
    if [ "$active" == "2" ]; then
    break
    fi
    sleep 2
done

kubectl create -f es-client.yaml
kubectl create -f es-data-svc.yaml
kubectl create -f es-data-stateful.yaml

while true; do
    active=`kubectl get deployments --all-namespaces | grep es-client | awk '{print $6}'`
    if [ "$active" == "1" ]; then
    break
    fi
    sleep 2
done
 
# Scale the cluster to 3 master, 4 data, and 2 client nodes
kubectl scale deployment es-master --replicas 3
kubectl scale deployment es-client --replicas 2
kubectl scale statefulsets es-data --replicas 4
 
echo "Waiting for Elasticsearch public service IP..."
while true; do
    es_ip=`kubectl get svc elasticsearch | grep elasticsearch | awk '{print $3}'`
    if [ "$es_ip" != "<pending>" ]; then
    break
    fi
    sleep 2
done   
echo "Elasticsearch public IP:    "$es_ip"