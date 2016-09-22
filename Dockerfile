# Oracle instant client

FROM ubuntu:14.04

MAINTAINER Pavel Derendyaev <pderendyaev@gmail.com>

# Environment
ENV LANG=en_US.utf8
ENV ORACLE_HOME=/usr/lib/oracle/12.1/client64
ENV PATH=$PATH:$ORACLE_HOME/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib

ADD oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm /tmp/
ADD oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm /tmp/
ADD oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm /tmp/

# Setup locale, Oracle instant client and Python
RUN apt-get update \
    && apt-get -y install language-pack-en alien libaio1 python python-dev python-pip \
    && locale-gen en_US \
    && alien -i /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm \
    && alien -i /tmp/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm \
    && alien -i /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm \
    && ln -snf /usr/lib/oracle/12.1/client64 /opt/oracle \
    && mkdir -p /opt/oracle/network \
    && ln -snf /etc/oracle /opt/oracle/network/admin \
    && pip install cx_oracle \
    && apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD root /
