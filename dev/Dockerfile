FROM ubuntu:20.04

RUN apt-get update && apt-get -y upgrade
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get install -q -y \
    'inetutils-*' \
    bpftrace \
    build-essential \
    clang \
    curl \
    emacs-nox \
    gdb \
    git \
    iproute2 \
    iproute2-doc \
    man \
    sudo \
    vim \
    zsh \
    && echo OK

RUN mkdir -p /mnt/cwd /mnt/root /mnt/home

RUN adduser --disabled-password --gecos '' user
RUN adduser user sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER user

WORKDIR /mnt/cwd
CMD /bin/bash
