FROM ubuntu:18.04

WORKDIR /root

SHELL [ "/bin/bash", "-c" ]

RUN apt-get -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
        build-essential \
        zlib1g-dev \
        libncurses5-dev \
        libgdbm-dev \
        libnss3-dev \
        libssl-dev \
        libsqlite3-dev \
        libreadline-dev \
        libffi-dev \
        libbz2-dev \
        make \
        wget

ENV LANG=C.UTF-8

ARG PYTHON_VERSION='3.8.3'
ARG PYTHON_SHORT_VERSION='3.8'

RUN wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
RUN tar -xf Python-$PYTHON_VERSION.tgz

WORKDIR /root/Python-$PYTHON_VERSION

RUN ./configure --enable-optimizations
RUN make
RUN make altinstall
RUN ln -s /usr/local/bin/python$PYTHON_SHORT_VERSION /usr/local/bin/python

WORKDIR /root

CMD [ "python" ]

RUN python -m pip install --upgrade pip
RUN pip install tox pytest

