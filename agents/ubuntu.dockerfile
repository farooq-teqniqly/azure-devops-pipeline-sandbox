FROM ubuntu:18.04

WORKDIR /root

SHELL [ "/bin/bash", "-c" ]

ARG PYTHON_VERSION='3.8.3'

RUN apt-get -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
        gcc \
        g++ \
        zlibc \
        zlib1g-dev \
        libssl-dev \
        libbz2-dev \
        libsqlite3-dev \
        libncurses5-dev \
        libgdbm-dev \
        libgdbm-compat-dev \
        liblzma-dev \
        libreadline-dev \
        uuid-dev \
        libffi-dev \
        tk-dev \
        wget \
        curl \
        git \
        make \
        sudo \
        bash-completion \
        tree \
        vim \
        software-properties-common && \
        mv /usr/bin/lsb_release /usr/bin/lsb_release.bak && \
        apt-get -y autoclean && \
        apt-get -y autoremove && \
        rm -rf /var/lib/apt-get/lists/*

COPY install_python.sh install_python.sh

RUN bash install_python.sh ${PYTHON_VERSION} 1 && \
    rm -r install_python.sh Python-${PYTHON_VERSION}

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

CMD [ "/bin/bash" ]