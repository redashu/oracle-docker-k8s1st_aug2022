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


