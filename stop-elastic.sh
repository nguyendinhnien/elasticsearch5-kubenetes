#!/bin/bash
 
echo "Tearing down cluster services..."
kubectl delete svc elasticsearch
kubectl delete svc elasticsearch-discovery
kubectl delete svc elasticsearch-data

kubectl delete statefulsets es-data

kubectl delete deployment --namespace=es-cluster es-master
kubectl delete deployment --namespace=es-cluster es-client
kubectl delete namespace es-cluster
sleep 2
echo "Done"