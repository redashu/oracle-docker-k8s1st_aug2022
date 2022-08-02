# oracle-docker-k8s1st_aug2022

### training plan 

<img src="plan.png" />

### restart container policy 

<img src="policy.png" />

### list of restart policies 

<img src="re.png" />

### checking restart policy of containers 

```
[ashu@docker-server ~]$ docker  inspect  test5 --format='{{.Id}}'
3c1f681aa0579df7f2d7e4f3a4b72da3c45be70d5b8c9915f7c163be1cd3be1a
[ashu@docker-server ~]$ docker  inspect  test5 --format='{{.State.Status}}'
exited
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ docker  inspect  test5 --format='{{.HostConfig.RestartPolicy.Name}}'
no
[ashu@docker-server ~]$ docker  inspect  test4  --format='{{.HostConfig.RestartPolicy.Name}}'
no
[ashu@docker-server ~]$ docker  ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
bb7ce5371354        alpine:sureshk      "/bin/sh -c 'python3…"   44 minutes ago      Up 44 minutes                           alpinex
[ashu@docker-server ~]$ docker  inspect  alpinex   --format='{{.HostConfig.RestartPolicy.Name}}'
no

```

### setting the restart policy during container creation time 

```
[ashu@docker-server ~]$ docker run -d  --name ashuc1 --restart always  alpine  ping fb.com 
bb6740b54fb36deac3f088a1b68d9eb4176b2c5bc400b2bf69f1295bdc4e2389
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ docker  ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
bb6740b54fb3        alpine              "ping fb.com"            5 seconds ago       Up 4 seconds                            ashuc1
bb7ce5371354        alpine:sureshk      "/bin/sh -c 'python3…"   45 minutes ago      Up 45 minutes                           alpinex
[ashu@docker-server ~]$ docker  inspect  ashuc1   --format='{{.HostConfig.RestartPolicy.Name}}'
always

```





