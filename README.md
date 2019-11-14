# Application Deployment in Kubernetes Cluster
  This repository contains deployment manifest to deploy `app-version-info` application in Kubernetes cluster

## Table of Contents
  - [Introduction](#introduction)
  - [Deployment Manifest](#deployment-manifest)
  - [Application Image](#application-image)
  - [Application Deploy and Test Script](#application-deploy-and-test-script)
  - [Deploy Application in Kubernetes Cluster](#deploy-application-in-Kubernetes-cluster)
  - [Deployment Testing Results](#deployment-testing-results)
  - [Enhancement Production Readiness](#enhancement-production-Readiness)


## Introduction

This repository used to deploy and expose application in Kubernetes cluster.

## Deployment Manifest

This [here](app-version-info-deploy.yaml) file is used to create `Namespace`,`Deployment`, `Service`

- Namespace: Creates `technical-test` namespace
- Deployment: Creates `app-version-info` deployment in namespace `technical-test`
- Service: Expose the application on port 5000 on the host (`NodePort`)


## Application Image

This application uses latest image from dockerhub repository `aparnamane/app-version-info:7d7db9e` build using application code from this [repo](https://github.com/aparnamane/application-version-info)


## Application Deploy and Test Script

The deploy and test script is available [here](deploy.sh). Its a `bash` script used to automate application deployment, service creation and application testing.

### Deploy Application in Kubernetes Cluster

## Deploy from local machine

- Install Kubernete command line tool `kubectl` as instructed [here](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

- Create kubeconfig file under `~/.kube` directory as below with specifying respective values as config-file-name, cluster-name etc., sample kubeconfig file is [here](kubeconfig-example)

`kubectl config --kubeconfig=<config-file-name>  set-context <context-name> —cluster=<cluster-name> --namespace=<namespace-name> --user=<user-name>`

- Clone the repository to local machine

`git clone git@github.com:aparnamane/kubernetes-app-deployment.git`

- Make the script `deploy.sh` executable

`chmod u+x deploy.sh`

- Run the script

`./deploy.sh`

  
## Deploy from the cluster master node

- Login to the master node

- Clone the repo or copy the `app-version-info-deploy.yaml` and `deploy.sh` files

- Make the script `deploy.sh` executable

`chmod u+x deploy.sh`

- Run the script

`./deploy.sh`


### Deployment Testing Results

- This application deployment has been tested in the two node cluster running     kube version `1.13`

- Results can be seen as below:

```
cloud_user@ip-10-0-1-101:~$ ./deploy.sh
namespace/technical-test created
deployment.apps/app-version-info created
service/app-version-info-service created
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
app-version-info   0/1     1            0           0s
NAME                       TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
app-version-info-service   NodePort   10.101.185.114   <none>        5000:32765/TCP   0s
NAME                                READY   STATUS              RESTARTS   AGE
app-version-info-5bf75cbbb8-mc7b8   0/1     ContainerCreating   0          0s
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   153  100   153    0     0  30600      0 --:--:-- --:--:-- --:--:-- 76500
{
  "myapplication": [
    {
      "description": "pre-interview technical test",
      "lastcommitsha": "7d7db9e",
      "version": "1.0"
    }
  ]
}
```


### Enhancement Production Readiness

- Multi node cluster for high avability.
- Cluster access policies need to apply using RBAC.
- Auto scaling can be considered to scale up/down the application pods.
- Cluster upgrade strategy 


