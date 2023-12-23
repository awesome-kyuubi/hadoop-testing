#!/usr/bin/env bash

SELF_DIR="$(cd "$(dirname "$0")"; pwd)"

source "${SELF_DIR}/.env"

function download_if_not_exists() {
  local url=$1
  local filename=${url##*/}
  if [ ! -f "${SELF_DIR}/download/$filename" ]; then
    echo "downloading $filename ..."
    wget -O "${SELF_DIR}/download/$filename" $url
  else
    echo "skip downloading existed $filename"
  fi
}

mkdir -p "${SELF_DIR}/download"

if [ $(uname -m) = "arm64" ] || [ $(uname -m) = "aarch64" ]; then JDK8_TAR_NAME=zulu${ZULU8_VERSION}-ca-jdk${JDK8_VERSION}-linux_aarch64; else JDK8_TAR_NAME=zulu${ZULU8_VERSION}-ca-jdk${JDK8_VERSION}-linux_x64; fi
download_if_not_exists https://cdn.azul.com/zulu/bin/${JDK8_TAR_NAME}.tar.gz

if [ $(uname -m) = "arm64" ] || [ $(uname -m) = "aarch64" ]; then JDK17_TAR_NAME=zulu${ZULU17_VERSION}-ca-jdk${JDK17_VERSION}-linux_aarch64; else JDK17_TAR_NAME=zulu${ZULU17_VERSION}-ca-jdk${JDK17_VERSION}-linux_x64; fi
download_if_not_exists https://cdn.azul.com/zulu/bin/${JDK17_TAR_NAME}.tar.gz

download_if_not_exists ${APACHE_MIRROR}/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz
if [ $(uname -m) = "arm64" ] || [ $(uname -m) = "aarch64" ]; then HADOOP_TAR_NAME=hadoop-${HADOOP_VERSION}-aarch64; else HADOOP_TAR_NAME=hadoop-${HADOOP_VERSION}; fi
download_if_not_exists ${APACHE_MIRROR}/hadoop/core/hadoop-${HADOOP_VERSION}/${HADOOP_TAR_NAME}.tar.gz
download_if_not_exists ${APACHE_MIRROR}/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz
download_if_not_exists ${APACHE_MIRROR}/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz
download_if_not_exists ${APACHE_MIRROR}/kyuubi/kyuubi-${KYUUBI_VERSION}/apache-kyuubi-${KYUUBI_VERSION}-bin.tgz

MYSQL_JDBC_JAR_NAME=mysql-connector-j
download_if_not_exists ${MAVEN_MIRROR}/com/mysql/${MYSQL_JDBC_JAR_NAME}/${MYSQL_JDBC_VERSION}/${MYSQL_JDBC_JAR_NAME}-${MYSQL_JDBC_VERSION}.jar

HADOOP_AWS_JAR_NAME=hadoop-aws
download_if_not_exists ${MAVEN_MIRROR}/org/apache/hadoop/${HADOOP_AWS_JAR_NAME}/${SPARK_HADOOP_VERSION}/${HADOOP_AWS_JAR_NAME}-${SPARK_HADOOP_VERSION}.jar
AWS_JAVA_SDK_BUNDLE_JAR_NAME=aws-java-sdk-bundle
download_if_not_exists ${MAVEN_MIRROR}/com/amazonaws/${AWS_JAVA_SDK_BUNDLE_JAR_NAME}/${AWS_JAVA_SDK_VERSION}/${AWS_JAVA_SDK_BUNDLE_JAR_NAME}-${AWS_JAVA_SDK_VERSION}.jar
SPARK_HADOOP_CLOUD_JAR_NAME=spark-hadoop-cloud_${SCALA_BINARY_VERSION}
download_if_not_exists ${MAVEN_MIRROR}/org/apache/spark/${SPARK_HADOOP_CLOUD_JAR_NAME}/${SPARK_VERSION}/${SPARK_HADOOP_CLOUD_JAR_NAME}-${SPARK_VERSION}.jar
HADOOP_CLOUD_STORAGE_JAR_NAME=hadoop-cloud-storage
download_if_not_exists ${MAVEN_MIRROR}/org/apache/hadoop/${HADOOP_CLOUD_STORAGE_JAR_NAME}/${SPARK_HADOOP_VERSION}/${HADOOP_CLOUD_STORAGE_JAR_NAME}-${SPARK_HADOOP_VERSION}.jar

TPCDS_CONNECTOR_JAR_NAME=kyuubi-spark-connector-tpcds_${SCALA_BINARY_VERSION}
download_if_not_exists ${MAVEN_MIRROR}/org/apache/kyuubi/${TPCDS_CONNECTOR_JAR_NAME}/${KYUUBI_VERSION}/${TPCDS_CONNECTOR_JAR_NAME}-${KYUUBI_VERSION}.jar
TPCH_CONNECTOR_JAR_NAME=kyuubi-spark-connector-tpch_${SCALA_BINARY_VERSION}
download_if_not_exists ${MAVEN_MIRROR}/org/apache/kyuubi/${TPCH_CONNECTOR_JAR_NAME}/${KYUUBI_VERSION}/${TPCH_CONNECTOR_JAR_NAME}-${KYUUBI_VERSION}.jar

ICEBERG_SPARK_JAR_NAME=iceberg-spark-runtime-${SPARK_BINARY_VERSION}_${SCALA_BINARY_VERSION}
download_if_not_exists ${MAVEN_MIRROR}/org/apache/iceberg/${ICEBERG_SPARK_JAR_NAME}/${ICEBERG_VERSION}/${ICEBERG_SPARK_JAR_NAME}-${ICEBERG_VERSION}.jar

LOKI_APPENDER_JAR_NAME=log4j2-appender-nodep
download_if_not_exists ${MAVEN_MIRROR}/pl/tkowalcz/tjahzi/${LOKI_APPENDER_JAR_NAME}/${LOKI_APPENDER_VERSION}/${LOKI_APPENDER_JAR_NAME}-${LOKI_APPENDER_VERSION}.jar
