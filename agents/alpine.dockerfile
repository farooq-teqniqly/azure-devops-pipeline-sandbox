FROM node:10-alpine

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

RUN apk add --no-cache --virtual .pipeline-deps readline linux-pam \
  && apk add bash sudo shadow \
  && apk add linux-headers git libffi-dev readline-dev openssl-dev bzip2-dev zlib-dev \ 
  && apk add sqlite-dev build-base 

ARG PYTHON_VERSION='3.7.7'
ARG PYENV_HOME=/root/.pyenv

RUN git clone --depth 1 https://github.com/pyenv/pyenv.git $PYENV_HOME && \
    rm -rfv $PYENV_HOME/.git

ENV PATH $PYENV_HOME/shims:$PYENV_HOME/bin:$PATH

RUN pyenv install $PYTHON_VERSION
RUN pyenv global $PYTHON_VERSION
RUN pip install --upgrade pip && pyenv rehash

RUN rm -rf ~/.cache/pip
RUN apk del .pipeline-deps

# Hack to get conda to work if it is ever installed
RUN echo "#include <unistd.h>" > /usr/include/sys/unistd.h

CMD [ "node" ]