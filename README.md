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

- Grafana: http://localhost:3000
- Prometheus: http://localhost:9090
- Kyuubi UI: http://localhost:10099
- Spark History Server: http://localhost:18080
- Hadoop HDFS: http://localhost:9870
- Hadoop YARN: http://localhost:8088
- Hadoop MapReduce JobHistory: http://localhost:19888
