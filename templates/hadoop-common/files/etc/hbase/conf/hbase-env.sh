#!/usr/bin/env bash

export JAVA_HOME=/opt/openjdk-17

# use the standalone ZooKeeper deployed on hadoop-master1
export HBASE_MANAGES_ZK=false

# HBase ships its own Hadoop client jars, avoid mixing them with the ones
# picked up from the `hadoop` command in PATH
export HBASE_DISABLE_HADOOP_CLASSPATH_LOOKUP=true

export HBASE_LOG_DIR=/var/log/hbase
export HBASE_PID_DIR=/var/run/hbase

export HBASE_MASTER_OPTS="$HBASE_MASTER_OPTS -Xms512m -Xmx1g"
export HBASE_REGIONSERVER_OPTS="$HBASE_REGIONSERVER_OPTS -Xms512m -Xmx1g"
