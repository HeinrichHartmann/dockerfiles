FROM jupyter/scipy-notebook

MAINTAINER Heinrich Hartmann <heinrich@heinrichhartmann.com>

#
# System
#
USER root
# Give $NB_USER passwordless sudo
RUN printf "$NB_USER\tALL=(ALL)\tNOPASSWD: ALL" > /etc/sudoers.d/$NB_USER

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
    emacs \
    tmux \
    curl \
    less \
    man \
    autoconf \
    jq

# install latest libcircllhist from sources
RUN git clone --depth 1 https://github.com/circonus-labs/libcircllhist/ /tmp/libcircllhist &&\
    cd /tmp/libcircllhist &&\
    autoconf &&\
    ./configure --libdir /usr/lib/x86_64-linux-gnu/ &&\
    make && make install

USER $NB_USER

#
# Python
#
# We want to run pip as $NBUSER
#
# bash kernel: http://slhogle.github.io/2017/bash_jupyter_notebook/
#
RUN pip install --upgrade pip
RUN pip install \
    circonusapi \
    circllhist \
    nbmerge \
    bash_kernel
RUN python -m bash_kernel.install

RUN mkdir -p /work/run
WORKDIR /work

#
# Runtime Config
#
EXPOSE 9998
EXPOSE 9999
ADD cmd.sh /work/run
ADD local.sh /work/run

CMD ["/work/run/cmd.sh"]



