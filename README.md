# oracle-docker-k8s1st_aug2022

### training plan 

<img src="plan.png">

### Some info about webservers 

<img src="web.png">

### cloning java webapp

```
git clone  https://github.com/redashu/javawebapp.git


```

### adding compose file in javawebapp folder

```

version: '3.8'
services:
  ashujavaapp1:
    image: ashujavaweb:v1 
    build: . 
    container_name: ashuc111
    restart: always 
    ports:
    - "1234:8080"

```

### lets run it 

```
[ashu@docker-server javawebapp]$ ls
docker-compose.yaml  Dockerfile  myapp  README.md
[ashu@docker-server javawebapp]$ docker-compose up -d 
[+] Running 0/1
 ⠧ ashujavaapp1 Pulling                                                                      0.7s
[+] Building 21.5s (10/10) FINISHED                                                               
 => [internal] load build definition from Dockerfile                                         0.0s
 => => transferring doc
```

