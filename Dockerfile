From golang:latest

MAINTAINER Chia-An Lee <sz110010@gmail.com>

RUN apt-get update
RUN apt-get -y install autoconf libtool gcc pkg-config git flex bison libsctp-dev libgnutls28-dev libgcrypt-dev libssl-dev libidn11-dev libmongoc-dev libbson-dev libyaml-dev
RUN apt-get -y install iptables

RUN go get -u -v "github.com/gorilla/mux"
RUN go get -u -v "golang.org/x/net/http2"
RUN go get -u -v "golang.org/x/sys/unix"

RUN apt-get clean

COPY uptun_setup.sh /root

