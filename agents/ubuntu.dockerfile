FROM ubuntu:18.04

WORKDIR /root

SHELL [ "/bin/bash", "-c" ]

RUN apt-get -qq -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qq -y install \
        make \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        curl \
        llvm \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libffi-dev \ 
        liblzma-dev \
        git

ARG PYTHON_VERSION='3.8.3'
ARG PYENV_HOME=/root/.pyenv

RUN git clone --depth 1 https://github.com/pyenv/pyenv.git $PYENV_HOME \
    && rm -rfv $PYENV_HOME/.git

ENV PATH $PYENV_HOME/shims:$PYENV_HOME/bin:$PATH
ENV LANG=C.UTF-8

RUN pyenv install $PYTHON_VERSION
RUN pyenv global $PYTHON_VERSION

CMD [ "python" ]

RUN pip install --upgrade pip && pyenv rehash
RUN pip install tox pytest
RUN rm -rf ~/.cache/pip
