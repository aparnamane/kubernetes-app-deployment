#!/bin/bash

## This script is used to deploy application along with service in Kubernetes cluster

NAMESPACE_NAME="technical-test"

# Deploy and expose the application 

kubectl create -f app-version-info-deploy.yaml

# Deployment varification: deployment, service, pod

kubectl get deployments -n ${NAMESPACE_NAME}

kubectl get svc -n ${NAMESPACE_NAME}

kubectl get pod -n ${NAMESPACE_NAME}

# Test the application with API call using curl

sleep 15

POD_NAME=$(kubectl get pod -n ${NAMESPACE_NAME} | grep -i app | awk '{print $1}')

# Wait till pod is up and running


while [[ $(kubectl get pods -n ${NAMESPACE_NAME} -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]] 
do 
  echo "waiting for pod" && sleep 1
done

kubectl exec -n ${NAMESPACE_NAME} ${POD_NAME} curl -i http://0.0.0.0:5000/application-version-info/api/v1.0/version

