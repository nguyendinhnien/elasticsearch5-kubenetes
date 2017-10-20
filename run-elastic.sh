#!/bin/bash
 
echo "Creating Elasticsearch services..."
kubectl create -f es-discovery-svc.yaml
kubectl create -f es-svc.yaml
kubectl create -f es-master.yaml
 
# Check to see if the deployments are running
sleep 15

kubectl create -f es-client.yaml
kubectl create -f es-data-svc.yaml
kubectl create -f es-data-stateful.yaml

# Scale the cluster to 3 master, 4 data, and 2 client nodes
kubectl scale deployment es-master --replicas 3
kubectl scale deployment es-client --replicas 2
kubectl scale deployment es-data --replicas 4
 
echo "Waiting for Elasticsearch public service IP..."
while true; do
    es_ip=`kubectl get svc elasticsearch | grep elasticsearch | awk '{print $3}'`
    if [ "$es_ip" != "<pending>" ]; then
    break
    fi
    sleep 2
done   
echo "Elasticsearch public IP:    "$es_ip"