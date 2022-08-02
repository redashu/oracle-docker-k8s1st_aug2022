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




