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

### BUild sample java code to docker image 

### code 

```

class myclass { 
    public static void main(String args[]) 
    { 
        // test expression 
        while (true) { 
            System.out.println("Hello World welcome to containers ! "); 
  
            // update expression 
        } 
    } 
} 
```

### Dockerfile 

```
FROM openjdk
LABEL name=ashutoshh
RUN mkdir /mycode 
COPY test.java /mycode/
WORKDIR /mycode
RUN javac test.java 
# to compile java code 
CMD [ "java","myclass" ]


```

### lets build it 

```
[ashu@docker-server docker-images]$ ls
javacode  nodecode  pythoncodes
[ashu@docker-server docker-images]$ cd  javacode/
[ashu@docker-server javacode]$ ls
Dockerfile  test.java
[ashu@docker-server javacode]$ docker  build -t  ashujavacode:v1 . 
Sending build context to Docker daemon  3.072kB
Step 1/7 : FROM openjdk
 ---> 04bf630c9556
Step 2/7 : LABEL name=ashutoshh
 ---> Running in c456d6d20c68
Removing intermediate container c456d6d20c68
 ---> a18246c07ce2
Step 3/7 : RUN mkdir /mycode
 ---> Running in 638d29fcbbc9
Removing intermediate container 638d29fcbbc9
 ---> 5264baea515e
Step 4/7 : COPY test.java /mycode/
 ---> 2c7cb82bbad3
Step 5/7 : WORKDIR /mycode
 ---> Running in 2099f89df1c0
Removing intermediate container 2099f89df1c0
 ---> b52face723e1
Step 6/7 : RUN javac test.java
 ---> Running in 66715fbe7d4c
Removing intermediate container 66715fbe7d4c
 ---> 3e1dc9946d35
Step 7/7 : CMD [ "java","myclass" ]
 ---> Running in ad0797d8fa3d
Removing intermediate container ad0797d8fa3d
 ---> 153e6c357172
Successfully built 153e6c357172
Successfully tagged ashujavacode:v1

```

### lets create container 

```
[root@docker-server ~]# docker images  |   grep -i ashu
ashujavacode        v1                  153e6c357172        About a minute ago   464MB
python              ashucodev4          9b40bc78f123        18 hours ago         438MB
python              ashucodev3          40300cfc3d1a        18 hours ago         438MB
python              ashucodev2          a794deeb7a21        18 hours ago         438MB
ashualp             pycodev1            95fa69ce0e87        19 hours ago         55.8MB
python              ashucodev1          99caa1a336e5        19 hours ago         920MB
[root@docker-server ~]# 
[root@docker-server ~]# docker run -itd --name ashut1  ashujavacode:v1  
805ce0b7001111de9635432db6e0a1974197200669afb2cc6687a78ea7b5f696
[root@docker-server ~]# docker  ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
805ce0b70011        ashujavacode:v1     "java myclass"      2 seconds ago       Up 2 seconds                            ashut1
61fd4822302e        suresh:myjava       "java Test"         2 minutes ago       Up 2 minutes                            SureshJava
[root@docker-server ~]# docker logs  ashut1 

```

### checking jdk version 

```
[root@docker-server ~]# docker  exec -it  ashut1  bash 
bash-4.4# 
bash-4.4# java -version 
openjdk version "18.0.2" 2022-07-19
OpenJDK Runtime Environment (build 18.0.2+9-61)
OpenJDK 64-Bit Server VM (build 18.0.2+9-61, mixed mode, sharing)
bash-4.4# exit
[root@docker-server ~]# 


```

### webapp in containers 

### webservers

<img src="web.png">

### clone sample app code 

```
ashu@docker-server docker-images]$ mkdir webapps
[ashu@docker-server docker-images]$ cd webapps/
[ashu@docker-server webapps]$ git clone https://github.com/microsoft/project-html-website.git
Cloning into 'project-html-website'...
remote: Enumerating objects: 19, done.
remote: Total 19 (delta 0), reused 0 (delta 0), pack-reused 19
Unpacking objects: 100% (19/19), done.
[ashu@docker-server webapps]$ ls
project-html-website
[ashu@docker-server webapps]$ 

```

### build 

## Dockerfile 

```
FROM nginx
LABEL email="ashutoshh@linux.com"
COPY project-html-website /usr/share/nginx/html/
# Note we if we are not using CMD / ENtrypoint then From image default cmd/entrypoint will 
# be considered 

```

###

```
[ashu@docker-server webapps]$ ls
Dockerfile  project-html-website
[ashu@docker-server webapps]$ docker build  -t  ashuwebapp:v1  . 
Sending build context to Docker daemon  1.405MB
Step 1/3 : FROM nginx
Trying to pull repository docker.io/library/nginx ... 
latest: Pulling from docker.io/library/nginx
461246efe0a7: Pull complete 
060bfa6be22e: Pull complete 
b34d5ba6fa9e: Pull complete 
8128ac56c745: Pull complete 
44d36245a8c9: Pull complete 
ebcc2cc821e6: Pull complete 
Digest: sha256:cf4eeae444277ad9f02df9c63afc60646fd9259784f729f4c3990cd957e5a6e5
Status: Downloaded newer image for nginx:latest
 ---> 670dcc86b69d
Step 2/3 : LABEL email="ashutoshh@linux.com"
 ---> Running in e0a26341fc5f
Removing intermediate container e0a26341fc5f
 ---> e9009d420917
Step 3/3 : COPY project-html-website /usr/share/nginx/html/
 ---> 07e1d52e636c
Successfully built 07e1d52e636c
Successfully tagged ashuwebapp:v1
```

### docker networking 

<img src="net.png">

##

```
[root@docker-server ~]# docker  network  ls
NETWORK ID          NAME                DRIVER              SCOPE
9fb9ad1fc1c7        bridge              bridge              local
f9f782054aa6        host                host                local
6fb3392045ca        none                null                local
[root@docker-server ~]# docker  network inspect bridge 
[
    {
        "Name": "bridge",
        "Id": "9fb9ad1fc1c788cec4a5e76fc9b3a5e1557819fae8fa9ea3f66a691aec1173ba",
        "Created": "2022-08-02T04:48:38.936631213Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]

```

### creating container with port forwarding option

```
[root@docker-server ~]# docker  images  |   grep ashu
ashuwebapp          v1                  07e1d52e636c        31 minutes ago      143MB
[root@docker-server ~]# docker  run -d  --name ashuwc1  -p  1234:80  ashuwebapp:v1 
7e9a78b74c2b15db624ab6973c3eabb8555fdfe5ff7dd5c6ef3947387eaa838b
[root@docker-server ~]# docker  ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                            NAMES
7e9a78b74c2b        ashuwebapp:v1       "/docker-entrypoint.…"   3 seconds ago       Up 3 seconds        0.0.0.0:1234->80/tcp             ashuwc1

```

### Image sharing using Docker hUb registry 

<img src="hub.png">

## pushing image to docker hub 

### tagging 

```
[root@docker-server ~]# docker  images  |   grep ashu
ashuwebapp          v1                  07e1d52e636c        About an hour ago   143MB
[root@docker-server ~]# 
[root@docker-server ~]# 
[root@docker-server ~]# docker  tag   ashuwebapp:v1  docker.io/dockerashu/ashuwebapp:v1  
[root@docker-server ~]# 
[root@docker-server ~]# docker  images  |   grep ashu
dockerashu/ashuwebapp   v1                  07e1d52e636c        About an hour ago   143MB
ashuwebapp              v1                  07e1d52e636c        About an hour ago   143MB
[root@docker-server ~]# 


```

### login for authorization 

```
[root@docker-server ~]# docker login  
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: dockerashu
Password: 
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

```
### pushing 

```
[root@docker-server ~]# docker  push  docker.io/dockerashu/ashuwebapp:v1
The push refers to repository [docker.io/dockerashu/ashuwebapp]
2a027000aabd: Pushed 
abc66ad258e9: Layer already exists 
243243243ee2: Layer already exists 
f931b78377da: Layer already exists 

```

### logout 

```
[root@docker-server ~]# docker logout 
Removing login credentials for https://index.docker.io/v1/
[root@docker-server ~]# 

```

### solution 4 

```
[root@docker-server ~]# docker run -it --name ashucimg oraclelinux:8.4  
[root@82f85446aee5 /]# 
[root@82f85446aee5 /]# yum install vim httpd -y &>/dev/null 
[root@82f85446aee5 /]# 
[root@82f85446aee5 /]# yum install vim httpd -y             
Last metadata expiration check: 0:00:27 ago on Tue Aug  2 07:29:12 2022.
Package vim-enhanced-2:8.0.1763-19.0.1.el8_6.2.x86_64 is already installed.
Package httpd-2.4.37-47.0.1.module+el8.6.0+20683+407db9f5.2.x86_64 is already installed.
Dependencies resolved.
Nothing to do.
Complete!
[root@82f85446aee5 /]# exit
exit
[root@docker-server ~]# docker commit ashucimg  ashucming:v007 
sha256:40be31740f57be08b3526b3da42ef3b4e8be670f1163437d102e5d7c6109d266
[root@docker-server ~]# docker  images  |  grep ashu
ashucming                    v007                40be31740f57        17 seconds ago       497MB
ashuwebapp                   v1                  07e1d52e636c        2 hours ago          143MB
dockerashu/ashuwebapp        v1                  07e1d52e636c        2 hours ago          143MB
dockerashu/udaywebapp1       v1                  07e1d52e636c        2 hours ago          143MB
dockermeena/ashuwebapp       v1                  07e1d52e636c        2 hours ago          143MB
[root@docker-server ~]# docker run -itd --name ashuxt1  ashucming:v007  
765d2d8f84f5c3d959cc7a2f87869e84f478c3ab1a11a1d91050f5736949a469
[root@docker-server ~]# docker  update  --restart always  ashuxt1 
ashuxt1
[root@docker-server ~]# docker  inspect ashuxt1 
[

===
[root@docker-server ~]# docker  tag  ashucming:v007  docker.io/dockerashu/ashucming:v007
[root@docker-server ~]# 
[root@docker-server ~]# docker login -u dockerashu
Password: 
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
[root@docker-server ~]# docker push  docker.io/dockerashu/ashucming:v007
The push refers to repository [docker.io/dockerashu/ashucming]
bd70798e28fa: Pushed 
2d3586eacb61: Mounted from dockerhubpj/priyankacimg 
v007: digest: sha256:2a60dff0d05751e797b38876dc0be326e256a58224e18e38b3e4aa2cbb4b0d59 size: 742
[root@docker-server ~]# docker logout 
Removing login credentials for https://index.docker.io/v1/
[root@docker-server ~]# 


```

### Docker compose -- the scripting and ISOlation for projects 

<img src="compose.png">

### install docker-compose 

```
[root@docker-server ~]# curl -SL https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64 -o /usr/bin/docker-compose 
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 24.5M  100 24.5M    0     0  12.2M      0  0:00:02  0:00:02 --:--:-- 19.5M
[root@docker-server ~]# 
[root@docker-server ~]# 
[root@docker-server ~]# chmod +x /usr/bin/docker-compose 
[root@docker-server ~]# 
[root@docker-server ~]# docker-compose version 
Docker Compose version v2.7.0
[root@docker-server ~]# 

```

### more info about docker compose 

<img src="compose1.png">

### Example 1 

```
version: '3.8' # compose file version 
services: # your application stack 
  ashuapp1: 
    image: alpine
    container_name: ashuc1
    command: ping fb.com 
    restart: always 

```

### lets run 

```
[ashu@docker-server docker-images]$ cd  ashu-compose/
[ashu@docker-server ashu-compose]$ ls
docker-compose.yaml
[ashu@docker-server ashu-compose]$ docker-compose up -d 
[+] Running 2/2
 ⠿ ashuapp1 Pulled                                                                               1.7s
   ⠿ 530afca65e2e Pull complete                                                                  0.6s
[+] Running 2/2
 ⠿ Network ashu-compose_default  Created                                                         0.2s
 ⠿ Container ashuc1              Started                                                         0.8s
[ashu@docker-server ashu-compose]$ docker-compose ps
NAME                COMMAND             SERVICE             STATUS              PORTS
ashuc1              "ping fb.com"       ashuapp1            running             
[ashu@docker-server ashu-compose]$ 

```

### more compose commands 

```
[ashu@docker-server ashu-compose]$ ls
docker-compose.yaml
[ashu@docker-server ashu-compose]$ docker-compose  ps
NAME                COMMAND             SERVICE             STATUS              PORTS
ashuc1              "ping fb.com"       ashuapp1            running             
[ashu@docker-server ashu-compose]$ docker-compose  stop 
[+] Running 1/1
 ⠿ Container ashuc1  Stopped                                                                                        10.5s
[ashu@docker-server ashu-compose]$ docker-compose  ps
NAME                COMMAND             SERVICE             STATUS              PORTS
ashuc1              "ping fb.com"       ashuapp1            exited (137)        
[ashu@docker-server ashu-compose]$ docker-compose  start
[+] Running 1/1
 ⠿ Container ashuc1  Started                                                                                         0.6s
[ashu@docker-server ashu-compose]$ docker-compose  ps
NAME                COMMAND             SERVICE             STATUS              PORTS
ashuc1              "ping fb.com"       ashuapp1            running             
[ashu@docker-server ashu-compose]$ 
```

### accessing service container 

```
[ashu@docker-server ashu-compose]$ docker-compose  ps
NAME                COMMAND             SERVICE             STATUS              PORTS
ashuc1              "ping fb.com"       ashuapp1            running             
[ashu@docker-server ashu-compose]$ docker-compose  exec -it  ashuapp1  sh 
/ # 
/ # 
/ # ls
bin    dev    etc    home   lib    media  mnt    opt    proc   root   run    sbin   srv    sys    tmp    usr    var
/ # exit
[ashu@docker-server ashu-compose]$ 
```

### deleting all things related to compsoe creation 

```
[ashu@docker-server ashu-compose]$ docker-compose  down 
[+] Running 2/2
 ⠿ Container ashuc1              Removed                                                                            10.4s
 ⠿ Network ashu-compose_default  Removed    
```

### Demo 2 

```
version: '3.8'
services:
  ashuappx1:
    image: alpine
    container_name: ashuxc1
    command: ping fb.com 
    restart: always 
  ashuappx2:
    image: nginx
    container_name: ashuxc2 
    ports:
    - "1234:80"
    restart: always 
```

### lets run it 

```
[ashu@docker-server ashu-compose]$ docker-compose down 
[ashu@docker-server ashu-compose]$ docker-compose  -f multic.yaml  up  -d 
[+] Running 3/3
 ⠿ Network ashu-compose_default  Created                                                     0.1s
 ⠿ Container ashuxc2             Started                                                     1.1s
 ⠿ Container ashuxc1             Started                                                     0.9s
[ashu@docker-server ashu-compose]$ docker-compose  -f multic.yaml  ps
NAME                COMMAND                  SERVICE             STATUS              PORTS
ashuxc1             "ping fb.com"            ashuappx1           running             
ashuxc2             "/docker-entrypoint.…"   ashuappx2           running             0.0.0.0:1234->80/tcp
[ashu@docker-server ashu-compose]$ 



```

### more commands 

```
 195  docker-compose  -f multic.yaml  up  -d 
  196  docker-compose  -f multic.yaml  ps
  197  docker-compose  -f multic.yaml  stop 
  198  docker-compose  -f multic.yaml  ps
  199  docker-compose  -f multic.yaml  start
  200  docker-compose  -f multic.yaml  down
  201  docker-compose  -f multic.yaml  up -d
  202  docker-compose  -f multic.yaml  ps
  203  docker-compose  -f multic.yaml  stop  ashuappx1
  204  docker-compose  -f multic.yaml  ps
  205  docker-compose  -f multic.yaml  start  ashuappx1
  206  docker-compose  -f multic.yaml  ps
```

### compose containers 

```
version: '3.8'
services:
  ashudb: # db container 
    image: mysql
    container_name: ashudbc1 
    environment:
      MYSQL_ROOT_PASSWORD: "Docker@123#"
    restart: always 
  ashuwebapp: # webapp container 
    image: adminer 
    container_name: ashuwc1
    ports:
    - "1234:8080"
    restart: always 
    depends_on: # wait for ashudb service to come up then start this container 
    - ashudb 
```

### ====>RUN it 

```
[ashu@docker-server ashu-compose]$ ls
ashudbapp.yaml  docker-compose.yaml  multic.yaml  test.yaml
[ashu@docker-server ashu-compose]$ docker-compose -f ashudbapp.yaml up -d
[+] Running 3/3
 ⠿ Network ashu-compose_default  Created                                                     0.1s
 ⠿ Container ashudbc1            Started                                                     0.7s
 ⠿ Container ashuwc1             Started                                                     1.4s
[ashu@docker-server ashu-compose]$ docker-compose -f ashudbapp.yaml ps
NAME                COMMAND                  SERVICE             STATUS              PORTS
ashudbc1            "docker-entrypoint.s…"   ashudb              running             3306/tcp, 33060/tcp
ashuwc1             "entrypoint.sh docke…"   ashuwebapp          running             0.0.0.0:1234->8080/tcp

```

### docker container apps with customer story 

<img src="customer1.png">

### clone 3 sample webapps 

```
227  git clone https://github.com/microsoft/project-html-website.git
  228  git clone https://github.com/schoolofdevops/html-sample-app.git
  229  git clone https://github.com/yenchiah/project-website-template.git
```

### Dockerfile 

```
FROM oraclelinux:8.4
LABEL name="ashutoshh"
LABEL email="ashutoshh@linux.com"
ENV app_deploy=1000
# defining env which we can use in your process 
RUN yum install httpd -y && mkdir /apps  /apps/app1 /apps/app2 /apps/app3 
COPY html-sample-app /apps/app1/
COPY project-html-website /apps/app2/
ADD project-website-template /apps/app3/
COPY deploy.sh /apps/
WORKDIR /apps
RUN chmod +x deploy.sh 
ENTRYPOINT ["./deploy.sh"]


```

### dockerignore 

```
html-sample-app/.git
html-sample-app/*.txt
project-html-website/.git
project-html-website/LICENSE
project-html-website/README.md
project-website-template/.git
project-website-template/.gitignore
project-website-template/LICENSE
project-website-template/README.md 


```

### shell script 

```
#!/bin/bash

if  [  "$app_deploy" == "app1"  ]
then
    cp -rf /apps/app1/*  /var/www/html/
    httpd -DFOREGROUND # to start httpd server 
elif [  "$app_deploy" == "app2"  ]
then
    cp -rf /apps/app2/*  /var/www/html/
    httpd -DFOREGROUND
elif [  "$app_deploy" == "app3"  ]
then
    cp -rf /apps/app3/*  /var/www/html/
    httpd -DFOREGROUND
else 
    echo "Wrong variable or value" >/var/www/html/index.html
    httpd -DFOREGROUND
fi

```



### compose file 

```
version: '3.8'
services:
  ashucustomapp:
    image:  ashucustomerapp:v1  # this image we want to build
    build: . # calling dockerfile in current location 
    container_name: ashuwc11
    ports:
    - "1234:80"
    restart: always 
    environment:
      app_deploy: app1 # want to deploy app 3 
```


### lets run it 

```
[ashu@docker-server ashu-compose]$ docker-compose -f customer1app.yaml up -d 
[+] Running 0/1
 ⠦ ashucustomapp Pulling                                                                     0.7s
[+] Building 11.6s (5/12)                                                                         
 => [internal] load build definition from Dockerfile                                         0.0s
 => => transferring dockerfile: 520B                                                         0.0s
 => [internal] load .dockerignore                                                            0.0s
 => => transferring context: 366B                                                            0.0s
 => [internal] load metadata for docker.io/library/oraclelinux:8.4                           0.0s
 => [internal] load build context                                                            0.1s
 => => transferring context: 4.03MB                                                          0.1s
 => [1/8] FROM docker.io/library/oraclelinux:8.4                                             0.0s
 => => resolve docker.io/library/oraclelinux:8.4                                             0.0s
 => [2/8] RUN yum install httpd -y && mkdir /apps  /apps/app1 /apps/app2 /apps/app3         11.5s
 => => # Oracle Linux 8 BaseOS Latest (x86_64)           195 MB/s |  48 MB     00:00             
 => => # Oracle Linux 8 Application Stream (x86_64)      184 MB/s |  37 MB     00:00             

```

###

```
[ashu@docker-server ashu-compose]$ docker-compose -f customer1app.yaml ps
NAME                COMMAND             SERVICE             STATUS              PORTS
ashuwc11            "./deploy.sh"       ashucustomapp       running             0.0.0.0:1234->80/tcp
```



