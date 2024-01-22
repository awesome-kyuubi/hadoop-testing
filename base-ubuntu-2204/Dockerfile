# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:22.04

ARG JDK8_TAR_NAME
ARG JDK17_TAR_NAME
ARG JDK21_TAR_NAME

COPY ./files /

RUN set -xeu && \
    ln -snf /usr/bin/bash /usr/bin/sh && \
    install_packages busybox python3-pip supervisor xsltproc curl tree python-is-python3 && \
    mkdir /opt/busybox && \
    busybox --install /opt/busybox

ADD download/${JDK8_TAR_NAME}.tar.gz  /opt
ADD download/${JDK17_TAR_NAME}.tar.gz /opt
ADD download/${JDK21_TAR_NAME}.tar.gz /opt

RUN ln -snf /opt/${JDK8_TAR_NAME}  /opt/openjdk-8 && \
    ln -snf /opt/${JDK17_TAR_NAME} /opt/openjdk-17 && \
    ln -snf /opt/${JDK21_TAR_NAME} /opt/openjdk-21

ENV JAVA_HOME=/opt/openjdk-8
ENV PATH="$JAVA_HOME/bin:$PATH:/opt/busybox"

RUN groupadd hadoop --gid 6000 && \
    useradd  hadoop --gid 6000 --uid 6000 -m && \
    groupadd hdfs --gid 6001 && \
    useradd  hdfs --gid 6001 --uid 6001 --groups hadoop -m && \
    groupadd yarn --gid 6002 && \
    useradd  yarn --gid 6002 --uid 6002 --groups hadoop -m && \
    groupadd mapred --gid 6003 && \
    useradd  mapred --gid 6003 --uid 6003 --groups hadoop -m && \
    groupadd hive --gid 6004 && \
    useradd  hive --gid 6004 --uid 6004 -m && \
    groupadd hbase --gid 6005 && \
    useradd  hbase --gid 6005 --uid 6005 -m && \
    groupadd kafka --gid 6006 && \
    useradd  kafka --gid 6006 --uid 6006 -m && \
    groupadd zookeeper --gid 6007 && \
    useradd  zookeeper --gid 6007 --uid 6007 -m && \
    groupadd spark --gid 6008 && \
    useradd  spark --gid 6008 --uid 6008 -m && \
    groupadd kyuubi --gid 6009 && \
    useradd  kyuubi --gid 6009 --uid 6009 -m && \
    groupadd hue --gid 6010 && \
    useradd  hue --gid 6010 --uid 6010 -m && \
    groupadd ranger --gid 6011 && \
    useradd  ranger --gid 6011 --uid 6011 -m && \
    groupadd flink --gid 6012 && \
    useradd  flink --gid 6012 --uid 6012 -m && \
    groupadd trino --gid 6013 && \
    useradd trino --gid 6013 --uid 6013 -m
