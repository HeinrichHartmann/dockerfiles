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
    strace

# install latest libcircllhist from sources
RUN git clone https://github.com/circonus-labs/libcircllhist/ /tmp/libcircllhist &&\
    cd /tmp/libcircllhist &&\
    autoconf &&\
    ./configure --libdir /usr/lib/x86_64-linux-gnu/ &&\
    make && make install

USER $NB_USER

#
# Python
#
# We want to run pip as $NBUSER
RUN pip install --upgrade pip
RUN pip install \
    circonusapi \
    circllhist \
    nbmerge

#
# Runtime Config
#
EXPOSE 9998
EXPOSE 9999
ADD cmd.sh ./
CMD ["/home/jovyan/cmd.sh"]

# Install bash kernel
# http://slhogle.github.io/2017/bash_jupyter_notebook/
RUN pip install bash_kernel &&\
    python -m bash_kernel.install

# Change to cwd
WORKDIR /home/jovyan/work

# More stuff
RUN sudo apt-get update
RUN sudo apt-get -y install \
    jq \
    default-jre

