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
	subversion \
	texinfo \
	tmux \
	unzip \
	wget

RUN curl -s http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.20.0.tar.bz2 | tar -jx -C /usr/src
WORKDIR /usr/src/crosstool-ng-1.20.0
RUN ./configure --prefix=/opt/cross && \
    make && \
    make install

RUN mkdir /root/ct-ng-conf
WORKDIR /root/ct-ng-conf
ADD ct-ng-config /root/ct-ng-conf/.config
ADD ct-ng-env /usr/local/bin/ct-ng-env
RUN chmod 755 /usr/local/bin/ct-ng-env && \
    ct-ng-env ct-ng build && \
    rm -rf /root/ct-ng-conf/.build && \
    rm -f /root/ct-ng-conf/build.log
WORKDIR /
