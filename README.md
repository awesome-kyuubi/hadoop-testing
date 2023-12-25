# hadoop-testing

This serves as a testing sandbox for Hadoop, equipped with fundamental components
of the Hadoop ecosystem to facilitate the rapid establishment of test environments.

## How to use

Download all required artifacts, which will be used for building Docker images
```
./download.sh
```

Build binaries tarball
```
./build.sh
```

Build docker images
```
./build-image.sh
```

Run the testing plagground
```
docker compose up
```

## Access services

hadoop-testing recommends using (orbstack)[https://docs.orbstack.dev/] as the container runtimes on macOS.
Once the testing environment is fully operational, the following services will be accessible:

- Grafana: http://hadoop-master1.orb.local:3000
- Prometheus: http://hadoop-master1.orb.local:9090
- Kyuubi UI: http://hadoop-master1.orb.local:10099
- Spark History Server: http://hadoop-master1.orb.local:18080
- Hadoop HDFS: http://hadoop-master1.orb.local:9870
- Hadoop YARN: http://hadoop-master1.orb.local:8088
- Hadoop MapReduce JobHistory: http://hadoop-master1.orb.local:19888
- Ranger Admin: http://hadoop-master1.orb.local:6080
