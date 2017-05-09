FROM ubuntu:xenial
MAINTAINER Daniel Floris <daniel.floris@gmail.com>

RUN apt-get update
RUN apt-get install -y \
	autoconf \
	automake \
	binutils \
	bison \
	build-essential \
	curl \
	flex \
	gawk \
	gperf \
	libncurses5-dev \
	libtool \
        libtool-bin \
        help2man \
	subversion \
	texinfo \
	tmux \
	unzip \
	wget 

ENV CROSSTOOL_NG_VERSION 1.23.0
RUN echo $CROSSTOOl_NG_VERSION
RUN curl -s http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-${CROSSTOOL_NG_VERSION}.tar.bz2 | tar -jx -C /usr/src
WORKDIR /usr/src/crosstool-ng-${CROSSTOOL_NG_VERSION}
#RUN git clone https://github.com/crosstool-ng/crosstool-ng.git
RUN ls -la
#WORKDIR /crosstool-ng
RUN ls -la
#RUN ./bootstrap
RUN ./configure --prefix=/opt/cross && \
    make && \
    make install

#RUN mkdir /root/ct-ng-conf
#WORKDIR /root/ct-ng-conf
#ADD ct-ng-config /root/ct-ng-conf/.config
#ADD ct-ng-env /usr/local/bin/ct-ng-env
#RUN chmod 755 /usr/local/bin/ct-ng-env 
#RUN    ct-ng-env ct-ng build
#RUN    rm -rf /root/ct-ng-conf/.build
#RUN    rm -f /root/ct-ng-conf/build.log
RUN apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /
