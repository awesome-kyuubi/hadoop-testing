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

ARG ZOOKEEPER_VERSION
ARG HADOOP_VERSION
ARG HIVE_VERSION
ARG SPARK_VERSION
ARG SPARK_BINARY_VERSION
ARG SCALA_BINARY_VERSION
ARG KYUUBI_VERSION
ARG MYSQL_JDBC_VERSION
ARG LOKI_APPENDER_VERSION
ARG RANGER_VERSION
ARG HUDI_VERSION

ENV ZOOKEEPER_HOME=/opt/zookeeper
ENV ZOOCFGDIR=/etc/zookeeper/conf
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=/etc/hadoop/conf
ENV HIVE_HOME=/opt/hive
ENV HIVE_CONF_DIR=/etc/hive/conf
ENV SPARK_HOME=/opt/spark
ENV SPARK_CONF_DIR=/etc/spark/conf
ENV KYUUBI_HOME=/opt/kyuubi
ENV KYUUBI_CONF_DIR=/etc/kyuubi/conf
ENV RANGER_HOME=/opt/ranger
ENV RANGER_VERSION=${RANGER_VERSION}
ENV HUDI_HOME=/opt/hudi
ENV HUDI_VERSION=${HUDI_VERSION}
ENV MYSQL_JDBC_VERSION=${MYSQL_JDBC_VERSION}
ENV PATH=${KYUUBI_HOME}/bin:${SPARK_HOME}/bin:${HIVE_HOME}/bin:${HADOOP_HOME}/bin:${ZOOKEEPER_HOME}/bin:${PATH}

ADD download/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz /opt
ADD download/hadoop-${HADOOP_VERSION}.tar.gz /opt
ADD download/apache-hive-${HIVE_VERSION}-bin.tar.gz /opt
ADD download/spark-${SPARK_VERSION}-bin-hadoop3.tgz /opt
ADD download/apache-kyuubi-${KYUUBI_VERSION}-bin.tgz /opt
ADD download/ranger-${RANGER_VERSION}-admin.tar.gz /opt

# Copy configuration files
COPY ./files /

RUN ln -snf /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin ${ZOOKEEPER_HOME} && \
    ln -snf /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME} && \
    ln -snf /opt/apache-hive-${HIVE_VERSION}-bin ${HIVE_HOME} && \
    ln -snf /opt/spark-${SPARK_VERSION}-bin-hadoop3 ${SPARK_HOME} && \
    ln -snf /opt/apache-kyuubi-${KYUUBI_VERSION}-bin ${KYUUBI_HOME} && \
    ln -snf /opt/ranger-${RANGER_VERSION}-admin ${RANGER_HOME}

ADD download/mysql-connector-j-${MYSQL_JDBC_VERSION}.jar ${HIVE_HOME}/lib/
ADD download/mysql-connector-j-${MYSQL_JDBC_VERSION}.jar ${RANGER_HOME}/
ADD download/hudi-spark${SPARK_BINARY_VERSION}-bundle_${SCALA_BINARY_VERSION}-${HUDI_VERSION}.jar ${HUDI_HOME}/

RUN /opt/hadoop-init.d/init-hdfs.sh

ADD download/log4j2-appender-nodep-${LOKI_APPENDER_VERSION}.jar ${HIVE_HOME}/lib/
ADD download/log4j2-appender-nodep-${LOKI_APPENDER_VERSION}.jar ${SPARK_HOME}/jars/
ADD download/log4j2-appender-nodep-${LOKI_APPENDER_VERSION}.jar ${KYUUBI_HOME}/jars/
ADD download/kyuubi-spark-connector-tpch_${SCALA_BINARY_VERSION}-${KYUUBI_VERSION}.jar ${SPARK_HOME}/jars/
ADD download/kyuubi-spark-connector-tpcds_${SCALA_BINARY_VERSION}-${KYUUBI_VERSION}.jar ${SPARK_HOME}/jars/

RUN chown -R zookeeper:hadoop /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin && \
    chown -R hadoop:hadoop /opt/hadoop-${HADOOP_VERSION} && \
    chown -R hive:hadoop /opt/apache-hive-${HIVE_VERSION}-bin && \
    chown -R spark:hadoop /opt/spark-${SPARK_VERSION}-bin-hadoop3 && \
    chown -R kyuubi:hadoop /opt/apache-kyuubi-${KYUUBI_VERSION}-bin && \
    chown -R ranger:hadoop /opt/ranger-${RANGER_VERSION}-admin

# Zookeeper ports
EXPOSE 2181

# HDFS ports
EXPOSE 1004 1006 8020 9866 9867 9870 9864 50470

# YARN ports
EXPOSE 8030 8031 8032 8033 8040 8041 8042 8088 10020 19888

# HIVE ports
EXPOSE 9083 10000

# SPARK ports
EXPOSE 18080

# Ranger ports
EXPOSE 6080

CMD supervisord -c /etc/supervisord.conf
