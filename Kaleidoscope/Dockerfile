FROM registry.hub.docker.com/ubuntu
CMD /bin/bash

RUN apt-get update
RUN apt-get --yes install aptitude sudo
RUN aptitude -y install clang-3.5
RUN aptitude -y install cabal-install
RUN aptitude -y install libncurses-dev
RUN aptitude -y install libzip-dev
RUN aptitude -y install libedit-dev
RUN aptitude -y install g++
RUN cabal update
