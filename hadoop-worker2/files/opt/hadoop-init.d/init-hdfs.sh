#!/bin/bash -x

mkdir /var/lib/hadoop-hdfs
chown -R hdfs:hdfs /var/lib/hadoop-hdfs

mkdir /var/lib/hadoop-mapreduce
chown -R mapread:mapread /var/lib/hadoop-mapreduce

mkdir /var/lib/hadoop-yarn
chown -R yarn:yarn /var/lib/hadoop-yarn

mkdir /opt/hadoop/logs /var/log/hadoop-hdfs /var/log/hadoop-yarn 
chown -R hadoop.hadoop /opt/hadoop/logs
chown -R hdfs.hadoop /var/log/hadoop-hdfs
chown -R yarn.hadoop /var/log/hadoop-yarn
chmod -R 770 /opt/hadoop/logs /var/log/hadoop-hdfs /var/log/hadoop-yarn

# workaround for 'could not open session' bug as suggested here:
# https://github.com/docker/docker/issues/7056#issuecomment-49371610
rm -f /etc/security/limits.d/hdfs.conf
