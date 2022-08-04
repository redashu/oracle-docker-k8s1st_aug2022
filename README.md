# oracle-docker-k8s1st_aug2022

### training plan 

<img src="plan.png">


### installing kubernetes in various platforms / Env 

<img src="install.png">

### install minikube in any platform for k8s setup on local machine 

[install_link](https://minikube.sigs.k8s.io/docs/start/)

### setup 

```
[ashu@docker-server ~]$ minikube version 
minikube version: v1.26.1
commit: 62e108c3dfdec8029a890ad6d8ef96b6461426dc
[ashu@docker-server ~]$ minikube  start 
😄  minikube v1.26.1 on Oracle 7.9 (amd64)
✨  Automatically selected the docker driver
💨  For improved Docker performance, Upgrade Docker to a newer version (Minimum recommended version is 20.10.0, minimum supported version is 18.09.0, current version is 19.03.11-ol)
📌  Using Docker driver with root privileges
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
💾  Downloading Kubernetes v1.24.3 preload ...
    > preloaded-images-k8s-v18-v1...:  405.75 MiB / 405.75 MiB  100.00% 103.47 
    > gcr.io/k8s-minikube/kicbase:  386.60 MiB / 386.61 MiB  100.00% 38.45 MiB 
    > gcr.io/k8s-minikube/kicbase:  0 B [_______________________] ?% ? p/s 7.7s
🔥  Creating docker container (CPUs=2, Memory=3900MB) ...
🐳  Preparing Kubernetes v1.24.3 on Docker 20.10.17 ...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
[ashu@docker-server ~]$ 

```


### setup k8s multinode cluster using kubeadm -- 

[Vidoe_link](https://www.youtube.com/watch?v=TTzbQdu30YA&t=24s)

### auto generating YAML / JSON files for k8s resources 

### pod 

```
[ashu@docker-server ~]$ kubectl  run  ashupod1  --image=nginx --port 80 --dry-run=client -o yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ashupod1
  name: ashupod1
spec:
  containers:
  - image: nginx
    name: ashupod1
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

```

### saving yaml in a file and deploy it 

```
 kubectl  run  ashupod1  --image=nginx --port 80 --dry-run=client -o yaml  >autopod.yaml
[ashu@docker-server k8s-app-deploy]$ kubectl apply -f autopod.yaml 
pod/ashupod1 created
[ashu@docker-server k8s-app-deploy]$ kubectl get  po 
NAME       READY   STATUS              RESTARTS   AGE
ashupod1   1/1     Running             0          15s
udaypod1   0/1     ContainerCreating   0          1s
[ashu@docker-server k8s-app-deploy]$ 
```


