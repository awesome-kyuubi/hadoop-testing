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

ARG PROJECT_VERSION
FROM hadoop-testing/base-ubuntu-2204:$PROJECT_VERSION

ARG HADOOP_VERSION
ARG SPARK_VERSION
ARG TRINO_VERSION

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=/etc/hadoop/conf
ENV HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/client/*
ENV TRINO_HOME=/opt/trino
ENV PATH=${HADOOP_HOME}/bin:${PATH}

ADD download/hadoop-${HADOOP_VERSION}.tar.gz /opt
ADD download/spark-${SPARK_VERSION}-bin-hadoop3/yarn /opt/spark-${SPARK_VERSION}-bin-hadoop3/yarn
ADD download/trino-server-${TRINO_VERSION}.tar.gz /opt

# Copy configuration files
COPY ./files /

RUN ln -snf /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME} && \
    ln -snf spark-${SPARK_VERSION}-bin-hadoop3 /opt/spark && \
    ln -snf /opt/trino-server-${TRINO_VERSION} ${TRINO_HOME}

RUN /opt/hadoop-init.d/init-hdfs.sh
RUN /opt/trino-init.d/init-workdir.sh

# HDFS ports
EXPOSE 1004 1006 8020 9866 9867 9870 9864 50470

# YARN ports
EXPOSE 8030 8031 8032 8033 8040 8041 8042 8088 10020 19888

CMD supervisord -c /etc/supervisord.conf
