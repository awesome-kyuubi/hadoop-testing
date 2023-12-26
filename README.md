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

It recommends using [OrbStack](https://docs.orbstack.dev/) as the container runtimes on macOS.
Once the testing environment is fully operational, the following services will be accessible:

- Grafana: http://hadoop-master1.orb.local:3000
- Prometheus: http://hadoop-master1.orb.local:9090
- Kyuubi UI: http://hadoop-master1.orb.local:10099
- Spark History Server: http://hadoop-master1.orb.local:18080
- Hadoop HDFS: http://hadoop-master1.orb.local:9870
- Hadoop YARN: http://hadoop-master1.orb.local:8088
- Hadoop MapReduce JobHistory: http://hadoop-master1.orb.local:19888
- Ranger Admin: http://hadoop-master1.orb.local:6080

Note: the container domain name resolving depends on this [feature](https://docs.orbstack.dev/docker/domains) of OrbStack.

## Roadmap

1. Add more components, such as HBase, etc.
2. This project is in very early stage, and the current way is not flexiable enough to support various testing scenarios.
For example, there is no switch to turn on/off each components by configuration. To address such issues, we may want
to leverage the template engine like Ansible plus Jinja2 to generate the docker-compose.yml file and configuration files
for each component, so that user could easily customize the testing environment by modifying the configurations.
