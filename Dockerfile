FROM ubuntu:16.04
RUN apt-get update && apt-get install -y libtool autoconf make git

WORKDIR /root
RUN git clone https://github.com/twitter/twemproxy.git

WORKDIR /root/twemproxy
RUN autoreconf -fvi && ./configure && make && make install && strip /usr/local/sbin/nutcracker

RUN mkdir /usr/local/etc/twemproxy
VOLUME /usr/local/etc/twemproxy

RUN mkdir /run/twemproxy
VOLUME /run/twemproxy

WORKDIR /
RUN rm -rf /root/twemproxy
RUN apt-get purge -y make autoconf git libtool && \
    apt-get autoremove --purge -y && \
    apt-get autoclean -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/usr/local/sbin/nutcracker"]
