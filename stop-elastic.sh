#!/bin/bash
 
echo "Tearing down cluster services..."
kubectl delete svc elasticsearch
kubectl delete svc elasticsearch-discovery
kubectl delete svc elasticsearch-data

sleep 2

kubectl delete statefulsets es-data

kubectl delete deployment es-master
kubectl delete deployment es-client
kubectl delete namespace es-cluster
sleep 2
echo "Done"