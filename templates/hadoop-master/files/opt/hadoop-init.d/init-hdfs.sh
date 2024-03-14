#!/bin/bash -x

mkdir /var/lib/zookeeper
chown -R zookeeper:zookeeper /var/lib/zookeeper

mkdir /var/lib/kyuubi
chown -R kyuubi:root /var/lib/kyuubi

mkdir /var/lib/kyuubi/work
chmod -R 777 /var/lib/kyuubi/work

mkdir /var/lib/hadoop-hdfs
chown -R hdfs:hdfs /var/lib/hadoop-hdfs

mkdir /var/lib/hadoop-mapreduce
chown -R mapred:mapred /var/lib/hadoop-mapreduce

mkdir /var/lib/hadoop-yarn
chown -R yarn:yarn /var/lib/hadoop-yarn

mkdir /opt/hadoop/logs /var/log/hadoop-hdfs /var/log/hadoop-yarn 
chown -R hadoop.hadoop /opt/hadoop/logs
chown -R hdfs.hadoop /var/log/hadoop-hdfs
chown -R yarn.hadoop /var/log/hadoop-yarn
chmod -R 770 /opt/hadoop/logs /var/log/hadoop-hdfs /var/log/hadoop-yarn

touch /var/log/hdfs-namenode.log
chown hdfs /var/log/hdfs-namenode.log

# Additional libs
# cp -av /opt/hadoop/lib/native/Linux-amd64-64/* /usr/lib64/
# mkdir -v /opt/hive/auxlib || test -d /opt/hive-client/auxlib
