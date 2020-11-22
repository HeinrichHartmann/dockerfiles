FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y git build-essential apt-utils autotools-dev automake
RUN apt-get install -y libdb-dev
RUN cpan -i Date::Parse
RUN git clone --depth 1 --branch v1.3.3 https://git.code.sf.net/p/isync/isync
ENV DEBIAN_FRONTEND="noninteractive" TZ="Europe/Berlin"
RUN apt-get install -y libssl-dev libgsasl7-dev zlib1g-dev
RUN cd isync; ./autogen.sh; ./configure --disable-silent-rules --disable-dependency-tracking
RUN cd isync; make install
# Install mu
RUN apt-get install -y maildir-utils


