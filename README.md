# hadoop-testing


## How to use

Download all required artifacts, which will be used for building Docker images
```
./download.sh
```

Build docker images
```
./build.sh
```

Run the testing plagground
```
docker compose up
```

## Access services

- Grafana: http://hadoop-master1.orb.local:3000
- Prometheus: http://hadoop-master1.orb.local:9090
- Kyuubi UI: http://hadoop-master1.orb.local:10099
- Spark History Server: http://hadoop-master1.orb.local:18080
- Hadoop HDFS: http://hadoop-master1.orb.local:9870
- Hadoop YARN: http://hadoop-master1.orb.local:8088
- Hadoop MapReduce JobHistory: http://hadoop-master1.orb.local:19888
