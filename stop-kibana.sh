#!/bin/bash
 
echo "Tearing down Kibana services..."

kubectl delete svc --namespace=default kibana
kubectl delete deployment --namespace=default kibana