# free5gc-docker-compose
docker-compose of free5gc

## What's this?

[Free5GC](https://www.free5gc.org/)

The free5GC is an open-source project for 5th generation (5G) mobile core network. Currently, the major contributors are with National Chiao Tung University (NCTU). Although the ultimate goal of this project is to implement 3GPP Release 15 (R15) and Release 16 (R16) 5G core network (5GC), in current version we only implement three most important components in 5GC, namely Access and Mobility Management Function (AMF), Session Management Function (SMF) and User Plane Function (UPF). Thus, current version is mainly for the enhance Mobile Broadband (eMBB). Other features such as Ultra-Reliable Low Latency Connection (URLLC) and Massive Internet of Things (MIoT) are not supported yet.

The source code of free5GC can be downloaded from [here](https://bitbucket.org/nctu_5g/free5gc).

### Install free5GC manually
Reference: https://www.free5gc.org/installation

### free5GC-docker-compose
free5GC-docker-compose is an free5gc all-in-one implement in docker-compose. It's for easier test and develop the project.

## How to use it
### Install docker.

#### Ubuntu
Reference: https://docs.docker.com/install/linux/docker-ce/ubuntu/
```bash
$ sudo apt-get update
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
```

#### CentOS
Reference: https://docs.docker.com/install/linux/docker-ce/centos/
```bash
$ sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

$ sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

$ sudo yum install docker-ce docker-ce-cli containerd.io

$ sudo systemctl start docker
$ sudo systemctl enable docker
```

### Install docker-compose
Reference: https://docs.docker.com/v17.09/compose/install/
```bash
$ sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
```

### Run Up
Because we need to create tunnel interface, we need to use privileged container with root permission.
```bash
$ git clone https://github.com/calee0219/free5gc-docker-compose.git
$ cd free5gc-docker-compose
$ git init && git submodule update
$ docker-compose build
$ sudo docker-compose up # Recommand use with tmux to run in frontground
$ sudo docker-compose up -d # Run in backbround if need
```

After you run up your compose, attach into docker and start your test or develop
```bash
$ docker exec -it free5gc bash
# cd free5gc
# ./test/testngc -f install/etc/free5gc/test/free5gc.testngc.conf
```

## Project map
We use submodule to get source code and mount into container. For this instence, it's easy to develop the source code outside container and test it in container.

When running docker compose, we just build the project in the first time. After you change the source code, please rebuild the project before run testing.

## Troubleshooting
Sometimes, you need to drop data from DB(See #Troubleshooting from https://www.free5gc.org/installation).
```bash
$ docker exec -it mongodb bash
# mongo
> use free5gc
> db.subscribers.drop()
> exit
> exit
```
