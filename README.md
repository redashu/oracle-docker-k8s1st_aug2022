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

## Storage 

<img src="st.png">

### docker volumes

<img src="vol.png">

### creating volume 

```
[root@docker-server Nodejs]# docker  volume  ls
DRIVER              VOLUME NAME
[root@docker-server Nodejs]# docker  volume  create  ashuvol1
ashuvol1
[root@docker-server Nodejs]# docker  volume  ls
DRIVER              VOLUME NAME
local               ashuvol1
[root@docker-server Nodejs]# docker  volume  inspect ashuvol1 
[
    {
        "CreatedAt": "2022-08-03T05:26:35Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/ashuvol1/_data",
        "Name": "ashuvol1",
        "Options": {},
        "Scope": "local"
    }
]

```

### creating mysql container 

```
[root@docker-server Nodejs]# docker run -d  --name  ashudbc1  -e  MYSQL_ROOT_PASSWORD="Oracle@123"  -v  ashuvol1:/var/lib/mysql/ mysql 
Unable to find image 'mysql:latest' locally
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
15cfe7e9c510803627acb025d802654536fa5e95d566fa752d21d36bfcb53ffb
[root@docker-server Nodejs]# docker  ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                 NAMES
15cfe7e9c510        mysql               "docker-entrypoint.s…"   14 seconds ago      Up 6 seconds        3306/tcp, 33060/tcp   ashudbc1
[root@docker-server Nodejs]# 

```

### login into container and creating database 

```
[root@docker-server Nodejs]# docker  exec -it  ashudbc1   bash 
bash-4.4# 

bash-4.4# 
bash-4.4# mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.30 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)

mysql> create database info ;
Query OK, 1 row affected (0.01 sec)

mysql> create database codestatus ;
Query OK, 1 row affected (0.00 sec)


mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| codestatus         |
| info               |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
6 rows in set (0.00 sec)

mysql> ^DBye
bash-4.4# exit

```

### compose file for MYSQL and Postgres 

```
version:  '3.8'
volumes: # creating volume 
  ashudbvol111: # name of volume 
  ashudbvol222: # creating another volume 
services:
  ashudbmysql1: # mysql db 
    image: mysql
    container_name: ashudbc2
    restart: always 
    volumes:
    - "ashudbvol222:/var/lib/mysql/"
    environment: 
      MYSQL_ROOT_PASSWORD: "Oracle@123"
  ashudbapp1: # postgres DB 
    image: postgres
    container_name: ashudbc1
    volumes:
    - "ashudbvol111:/var/lib/postgresql/data/"
    restart: always 
    environment:
      POSTGRES_PASSWORD: "Oracle@123"
```


### lets run it 

```
[ashu@docker-server ashu-compose]$ docker-compose -f postgres.yaml up -d
[+] Running 5/5
 ⠿ Network ashu-compose_default        Created                                               0.1s
 ⠿ Volume "ashu-compose_ashudbvol222"  Created                                               0.0s
 ⠿ Volume "ashu-compose_ashudbvol111"  Created                                               0.0s
 ⠿ Container ashudbc1                  Started                                               0.9s
 ⠿ Container ashudbc2                  Started                                               0.7s
[ashu@docker-server ashu-compose]$ docker-compose -f postgres.yaml ps
NAME                COMMAND                  SERVICE             STATUS              PORTS
ashudbc1            "docker-entrypoint.s…"   ashudbapp1          running             5432/tcp
ashudbc2            "docker-entrypoint.s…"   ashudbmysql1        running             3306/tcp, 33060/tcp
```

### more docker volume cases 

```
[root@docker-server ~]# docker volume  create ashuvol1 
ashuvol1
[root@docker-server ~]# docker volume  create ashuvol2
ashuvol2
[root@docker-server ~]# 
[root@docker-server ~]# docker  run -dit  --name c1  -v ashuvol1:/mnt/d1:rw   alpine 
69f61107553148e119572acd01b6244cf9d430028f9ee128b7e6878a332fae3b
[root@docker-server ~]# 
[root@docker-server ~]# 
[root@docker-server ~]# docker  ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
69f611075531        alpine              "/bin/sh"           4 seconds ago       Up 3 seconds                            c1
[root@docker-server ~]# 
[root@docker-server ~]# 
[root@docker-server ~]# 
[root@docker-server ~]# docker  run -dit  --name c2  -v ashuvol1:/mnt/d1:rw  -v ashuvol2:/mnt/d2:ro    alpine 
17660a32b226df39250dc8190069581dc5c9954cb707ce8e394fa7a493629057
[root@docker-server ~]# docker  ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
17660a32b226        alpine              "/bin/sh"           3 seconds ago       Up 2 seconds                            c2
69f611075531        alpine              "/bin/sh"           37 seconds ago      Up 35 seconds                           c1


[root@docker-server ~]# docker  exec -it c2  sh 
/ # cd /mnt/
/mnt # ls
d1  d2
/mnt # mkdir d1/helllo
/mnt # mkdir d2/helllo
mkdir: can't create directory 'd2/helllo': Read-only file system
/mnt # exit

```

