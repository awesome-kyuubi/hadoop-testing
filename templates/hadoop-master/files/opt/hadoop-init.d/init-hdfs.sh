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
chown -R mapread:mapread /var/lib/hadoop-mapreduce

mkdir /var/lib/hadoop-yarn
chown -R yarn:yarn /var/lib/hadoop-yarn

mkdir /opt/hadoop/logs /var/log/hadoop-hdfs /var/log/hadoop-yarn 
chown -R hadoop.hadoop /opt/hadoop/logs
chown -R hdfs.hadoop /var/log/hadoop-hdfs
chown -R yarn.hadoop /var/log/hadoop-yarn
chmod -R 770 /opt/hadoop/logs /var/log/hadoop-hdfs /var/log/hadoop-yarn

# format namenode
su -c "echo 'N' | /opt/hadoop/bin/hdfs namenode -format" hdfs

# start hdfs
touch /var/log/hdfs-namenode.log
chown hdfs /var/log/hdfs-namenode.log
su -s /bin/bash hdfs -c "/opt/hadoop/bin/hdfs namenode 2>&1 > /var/log/hdfs-namenode.log" &

# wait for process starting
sleep 15

# init basic hdfs directories
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /tmp'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod -R 1777 /tmp'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /var'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /var/log'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod -R 1775 /var/log'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown yarn:mapred /var/log'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /tmp/hadoop-yarn'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod -R 1777 /tmp/hadoop-yarn'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir /tmp/hadoop-yarn/staging'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown mapred:mapred /tmp/hadoop-yarn/staging'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod -R 1777 /tmp/hadoop-yarn/staging'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir /tmp/hadoop-yarn/staging/history'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown mapred:mapred /tmp/hadoop-yarn/staging/history'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod -R 1777 /tmp/hadoop-yarn/staging/history'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod -R 1777 /tmp'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /var/log/hadoop-yarn/apps'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod -R 1777 /var/log/hadoop-yarn/apps'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown yarn:mapred /var/log/hadoop-yarn/apps'

su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /hbase'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown hbase /hbase'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /user'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /user/history'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown mapred /user/history'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir /user/yarn'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown yarn:yarn /user/yarn'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /user/hive'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod -R 777 /user/hive'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown hive /user/hive'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /user/root'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod -R 777 /user/root'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown root /user/root'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /user/hue'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod -R 777 /user/hue'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown hue /user/hue'

# MR1 JobTracker
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /var/lib/hadoop-hdfs/cache/mapred/mapred/staging'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred'

# Spark History Server
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir -p /spark-history'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod 1777 /spark-history'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown spark /spark-history'

# init hive directories
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -mkdir /warehouse'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chmod 1777 /warehouse'
su -s /bin/bash hdfs -c '/opt/hadoop/bin/hadoop fs -chown hive /warehouse'

# stop hdfs
killall java

apply-site-xml-override /etc/hadoop/conf/core-site.xml /etc/hadoop/conf/core-site-override.xml 

# Additional libs
# cp -av /opt/hadoop/lib/native/Linux-amd64-64/* /usr/lib64/
# mkdir -v /opt/hive/auxlib || test -d /opt/hive-client/auxlib
