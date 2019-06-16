From golang:latest

RUN apt-get update
RUN apt-get -y install autoconf libtool gcc pkg-config git flex bison libsctp-dev libgnutls28-dev libgcrypt-dev libssl-dev libidn11-dev libmongoc-dev libbson-dev libyaml-dev

RUN go get -u -v "github.com/gorilla/mux"
RUN go get -u -v "golang.org/x/net/http2"
RUN go get -u -v "golang.org/x/sys/unix"

RUN git clone https://bitbucket.org/nctu_5g/free5gc.git
RUN cd free5gc && autoreconf -iv && ./configure --prefix=`pwd`/install && make -j `nproc` && make install

COPY uptun_setup.sh /root

