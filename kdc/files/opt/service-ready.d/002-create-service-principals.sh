#!/usr/bin/env bash

set -exuo pipefail

rm -rf /share/keytabs/*

mkdir -p /share/keytabs/hadoop-master1
# HDFS NameNode
create_principal -p nn/hadoop-master1.orb.local -k /share/keytabs/hadoop-master1/nn.service.keytab
create_principal -p host/hadoop-master1.orb.local -k /share/keytabs/hadoop-master1/nn.service.keytab
create_principal -p HTTP/hadoop-master1.orb.local -k /share/keytabs/hadoop-master1/nn.service.keytab

# YARN ResourceManager
create_principal -p rm/hadoop-master1.orb.local -k /share/keytabs/hadoop-master1/rm.service.keytab
create_principal -p host/hadoop-master1.orb.local -k /share/keytabs/hadoop-master1/rm.service.keytab

# MapReduce JobHistory Server
create_principal -p jhs/hadoop-master1.orb.local -k /share/keytabs/hadoop-master1/jhs.service.keytab

# Hive MetaStore & Hive Server2
create_principal -p hive/hadoop-master1.orb.local -k /share/keytabs/hadoop-master1/hive.service.keytab

# Spark History Server
create_principal -p spark/hadoop-master1.orb.local -k /share/keytabs/hadoop-master1/spark.service.keytab

# Kyuubi Server
create_principal -p kyuubi/hadoop-master1.orb.local -k /share/keytabs/hadoop-master1/kyuubi.service.keytab

for i in {1..3}; do
  mkdir -p /share/keytabs/hadoop-worker$i
  # HDFS DataNode
  create_principal -p dn/hadoop-worker$i.orb.local -k /share/keytabs/hadoop-worker$i/dn.service.keytab
  create_principal -p host/hadoop-worker$i.orb.local -k /share/keytabs/hadoop-worker$i/dn.service.keytab
  # YARN NodeManger
  create_principal -p nm/hadoop-worker$i.orb.local -k /share/keytabs/hadoop-worker$i/nm.service.keytab
  create_principal -p host/hadoop-worker$i.orb.local -k /share/keytabs/hadoop-worker$i/nm.service.keytab
done

chmod -R a+r /share/keytabs