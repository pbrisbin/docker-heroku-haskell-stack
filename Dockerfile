FROM heroku/cedar:14
MAINTAINER Pat Brisbin <pbrisbin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV PATH /app/user/bin:/root/.local/bin:$PATH
ENV STACK_VERSION 1.0.2-0~trusty

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442 \
  && echo 'deb http://download.fpcomplete.com/ubuntu trusty main' > /etc/apt/sources.list.d/fpco.list \
  && apt-get update \
  && apt-get install -y stack=$STACK_VERSION \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/user/bin
WORKDIR /app/user

COPY files /

ONBUILD COPY stack.yaml /app/user/
ONBUILD RUN stack setup

ONBUILD COPY LICENSE *.cabal /app/user/
ONBUILD RUN stack build --dependencies-only
