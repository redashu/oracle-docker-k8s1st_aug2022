# oracle-docker-k8s1st_aug2022

### training plan 

<img src="plan.png">


###  app testing / deployment related problems in History 

<img src="prob1.png">

### Introduction to HyperVisor 

<img src="hyp.png">

### from app point of view -- vm are heavy and having unwanted LIbs 

<img src="app1.png">

### app need few amount of resources and LIbs from OS 

<img src="os.png">

### Introduction to containers 

<img src="cont1.png">

### vm vs containers 

<img src="vmcon1.png">

### Creating and managing continers we need COntainer runtimes -- Docker is the One we R using 

<img src="docker.png">

### installing docker on Oracle linux 7.9 

### Checking os Details 

```
[root@docker-server ~]# cat /etc/os-release 
NAME="Oracle Linux Server"
VERSION="7.9"
ID="ol"
ID_LIKE="fedora"
VARIANT="Server"
VARIANT_ID="server"
VERSION_ID="7.9"
PRETTY_NAME="Oracle Linux Server 7.9"
```


### installing docker 

```
[root@docker-server ~]# yum  install docker  
Failed to set locale, defaulting to C
Loaded plugins: langpacks, ulninfo
ol7_MySQL80                                                                                    | 3.0 kB  00:00:00     
ol7_MySQL80_connectors_community                                                               | 2.9 kB  00:00:00     
ol7_MySQL80_tools_community                                                                    | 2.9 kB  00:00:00     
ol7_UEKR6                                                                                      | 3.0 kB  00:00:00     
ol7_addons                  
```

### start docker service 


```
[root@docker-server ~]# systemctl start docker
[root@docker-server ~]# systemctl enable  docker
Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
[root@docker-server ~]# systemctl status   docker
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2022-08-01 06:13:36 GMT; 14s ago
     Docs: https://docs.docker.com
 Main PID: 17412 (dockerd)
   CGroup: /system.slice/docker.service
           └─17412 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```

### accessing docker server as docker client 

```
[root@docker-server ~]# useradd  ashu
[root@docker-server ~]# 
[root@docker-server ~]# su - ashu 
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ docker version 
Client: Docker Engine - Community
 Version:           19.03.11-ol
 API version:       1.40
 Go version:        go1.16.2
 Git commit:        9bb540d
 Built:             Fri Jul 23 01:33:55 2021
 OS/Arch:           linux/amd64
 Experimental:      false
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.40/version": dial unix /var/run/docker.sock: connect: permission denied
[ashu@docker-server ~]$ logout
[root@docker-server ~]# 
[root@docker-server ~]# 
[root@docker-server ~]# 
[root@docker-server ~]# usermod -aG docker  ashu 
[root@docker-server ~]# su - ashu 
Last login: Mon Aug  1 06:15:24 GMT 2022 on pts/0
[ashu@docker-server ~]$ docker  version 
Client: Docker Engine - Community
 Version:           19.03.11-ol
 API version:       1.40
 Go version:        go1.16.2
 Git commit:        9bb540d
 Built:             Fri Jul 23 01:33:55 2021
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.11-ol
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.16.2
  Git commit:       9bb540d
  Built:            Fri Jul 23 01:32:08 2021
  OS/Arch:          linux/amd64
  Experimental:     false
  Default Registry: docker.io
 containerd:
  Version:          v1.4.8
  GitCommit:        7eba5930496d9bbe375fdf71603e610ad737d2b2
 runc:
  Version:          1.1.1
  GitCommit:        52de29d
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683

```

### connection from laptops 


```
fire@ashutoshhs-MacBook-Air ~ % ssh  ashu@129.146.176.49  
The authenticity of host '129.146.176.49 (129.146.176.49)' can't be established.
ECDSA key fingerprint is SHA256:JMuT6ywZUzrVDk8X5lB4+mOmgWCZuYLFV8IiQyHSr10.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '129.146.176.49' (ECDSA) to the list of known hosts.
ashu@129.146.176.49's password: 
Last login: Mon Aug  1 06:15:44 2022
-bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ docker  version 
Client: Docker Engine - Community
 Version:           19.03.11-ol
 API version:       1.40
 Go version:        go1.16.2
 Git commit:        9bb540d
 Built:             Fri Jul 23 01:33:55 2021
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.11-ol
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.16.2
  Git commit:       9bb540d
  Built:            Fri Jul 23 01:32:08 2021
  OS/Arch:          linux/amd64
  Experimental:     false
  Default Registry: docker.io
 containerd:
  Version:          v1.4.8
  GitCommit:        7eba5930496d9bbe375fdf71603e610ad737d2b2
 runc:
  Version:          1.1.1
  GitCommit:        52de29d
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683

```

### pulling image from Docker hub 

```
[ashu@docker-server ~]$ docker  images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ docker  pull   mysql 
Using default tag: latest
Trying to pull repository docker.io/library/mysql ... 
latest: Pulling from docker.io/library/mysql
e54b73e95ef3: Pull complete 
327840d38cb2: Pull complete 
642077275f5f: Pull complete 
e077469d560d: Pull complete 
cbf214d981a6: Pull complete 
f4fda5f8b9a8: Pull complete 
a41c2763043b: Pull complete 
f86b3df6abb1: Pull complete 
95b1c2ed2ecf: Pull complete 
b0edcd52771b: Pull complete 
a3d312b5c835: Pull complete 
Digest: sha256:657d78ee56e09101902673adcdd7d2bf03012e759c1aa525eeca28cb0fe1aa7d
Status: Downloaded newer image for mysql:latest
mysql:latest
[ashu@docker-server ~]$ docker  images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
mysql               latest              38643ad93215        5 days ago          446MB
[ashu@docker-server ~]$ 

```

### pulling images from different container registries

```
    6  docker  pull   mysql 
    7  docker  images
    8  history 
    9  docker pull quay.io/jitesoft/nginx
   10  docker images
   11  docker pull container-registry.oracle.com/java/openjdk:latest
   12  history 
[ashu@docker-server ~]$ docker  images
REPOSITORY                                   TAG                 IMAGE ID            CREATED             SIZE
mysql                                        latest              38643ad93215        5 days ago          446MB
quay.io/jitesoft/nginx                       latest              fe095d988a2a        11 days ago         50.8MB
container-registry.oracle.com/java/openjdk   latest              a0a677f4434e        12 days ago         569MB
[ashu@docker-server ~]$ 


```

### importance of process in container 

<img src="proc.png">

### creating containers 

<img src="cont1.png">

### creating first container 

```
[ashu@docker-server ~]$ docker  run  alpine:latest   cal 
    August 2022
Su Mo Tu We Th Fr Sa
    1  2  3  4  5  6
 7  8  9 10 11 12 13
14 15 16 17 18 19 20
21 22 23 24 25 26 27
28 29 30 31
                     
[ashu@docker-server ~]$ docker  ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                  PORTS               NAMES
12ba14a8ab75        alpine:latest       "cal"               1 second ago        Up Less than a second                       nice_carson
[ashu@docker-server ~]$ docker  ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[ashu@docker-server ~]$ 



```

### best practise to give some name to containers 

```
[ashu@docker-server ~]$ docker  run --name ashuc1   alpine:latest   cal 
    August 2022
Su Mo Tu We Th Fr Sa
    1  2  3  4  5  6
 7  8  9 10 11 12 13
14 15 16 17 18 19 20
21 22 23 24 25 26 27
28 29 30 31
                     
[ashu@docker-server ~]$ docker  ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
631357712a71        alpine:latest       "cal"               5 seconds ago       Exited (0) 4 seconds ago                        ashuc1
3fb37fa063a5        alpine              "env"               6 seconds ago       Exited (0) 5 seconds ago                        skotha1
4700b2a043f5        alpine:latest       "cal"               19 seconds ago      Exited (0) 18 seconds ago                       uday
571338ca2b06        alpine:latest       "cal"               21 seconds ago      Exited (0) 20 seconds ago                       mvu
[ashu@docker-server ~]$ 


```

### best way to create contianer 

```
ashu@docker-server ~]$ docker  run --name ashuc1 -d    alpine:latest   ping www.google.com 
63d292bcf988cb59c11d9b4b01ad3532146161102163dad1b45bc86fae2a53bf
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ 
[ashu@docker-server ~]$ docker  ps
CONTAINER ID        IMAGE               COMMAND                 CREATED             STATUS              PORTS               NAMES
3375480fabf2        alpine:latest       "ping www.google.com"   3 seconds ago       Up 2 seconds                            priyamva
63d292bcf988        alpine:latest       "ping www.google.com"   12 seconds ago      Up 11 seconds                           ashuc1
[ashu@docker-server ~]$ 

```

### stop a running container 

```
[ashu@docker-server ~]$ docker  stop  ashuc1
ashuc1

```

### starting container 

```
[ashu@docker-server ~]$ docker  start  ashuc1
ashuc1
```

### we can get the shell of a running container 

```
[ashu@docker-server ~]$ docker exec -it  ashuc1  sh  
/ # 
/ # 
/ # whoami
root
/ # ls 
bin    dev    etc    home   lib    media  mnt    opt    proc   root   run    sbin   srv    sys    tmp    usr    var
/ # exit


```

### how to remove container 

```
[ashu@docker-server ~]$ docker  stop  ashuc1
ashuc1
[ashu@docker-server ~]$ docker  rm  ashuc1 
ashuc1
```


