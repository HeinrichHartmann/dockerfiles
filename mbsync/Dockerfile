FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y git build-essential apt-utils autotools-dev automake
RUN apt-get install -y libdb-dev
RUN cpan -i Date::Parse
RUN git clone --depth 1 https://github.com/gburd/isync.git
RUN cd isync; ./autogen.sh; ./configure; make install


