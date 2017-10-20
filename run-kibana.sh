#!/bin/bash

echo "Creating Kibana services..."
kubectl create -f kibana.yaml
kubectl create -f kibana-svc.yaml