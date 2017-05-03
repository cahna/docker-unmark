
FROM ubuntu:16.04
MAINTAINER Conor Heine <conor@conorheine.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_TYPE en_US.UTF-8
ENV TZ America/Los_Angeles
ENV UNMARK_VERSION 1.7.1.2

# Dependencies
RUN apt-get update && apt-get install -y software-properties-common && apt-add-repository ppa:ansible/ansible && apt-get update \
    && apt-get -y install \
        locales \
        wget \
        ansible \
        nginx-full \
        php7.0-cli \
        php7.0-mysql \
        php7.0-gd \
        php7.0-dev \
        php-pear \
        php7.0-gettext \
        php7.0-curl \
        php7.0-fpm \
        php7.0-mcrypt \
        php7.0-json \
        php-net-ipv4 \
    && apt-get -y autoremove --purge && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN locale-gen en_US.UTF-8
RUN easy_install supervisor && mkdir /etc/supervisor
RUN phpenmod mcrypt
RUN phpenmod gettext

# Install unmark
RUN wget -O /tmp/unmark.tgz https://github.com/cdevroe/unmark/archive/v${UNMARK_VERSION}.tar.gz \
    && cd /tmp \
    && ls -l \
    && tar zxvf unmark.tgz \
    && mv unmark-${UNMARK_VERSION} /unmark \
    && rm -r /tmp/*

# Cleanup nginx
RUN rm /etc/nginx/sites-enabled/default

ADD entrypoint.* /
CMD /entrypoint.sh
VOLUME /run/php
WORKDIR /unmark

