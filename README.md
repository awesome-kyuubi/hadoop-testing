Hadoop Testing
==============
This serves as a testing sandbox for Hadoop, equipped with fundamental components
of the Hadoop ecosystem to facilitate the rapid establishment of test environments.

We try to deploy a big data ecosystem in multiple Docker containers to simulate the production environment. Generally speaking, it contains two types of deployment modes(standalone and mixed deployed). Standalone mode is just like a SaaS service provided by cloud vendors, while the mixed deployed mode is just like the semi-managed EMR service of cloud vendors. The whole deployment architecture is shown below:

![deployment_architecture](./docs/imgs/deployment_architecture.png)

> Draw by [excalidraw](https://excalidraw.com/)

## Features

* Realistic simulation of production environment;
* Kerberos ready, and optional;
* Lightweight, highly scalable and tailored Hadoop ecosystem;
* Multi-purpose, multi-scenario, suitable for:
   - Component developer: unit and integration testing;
   - DevOps engineer: parameter adjustment verification, compatibility testing of component upgrades;
   - Solution architect: Sandbox simulation of migration work, work shop demonstration;
   - Data ETL engineer: a test environment that is easy to build and destroy;

## Components

The supported components are listed below:

| Name                 | Version | Kerberos Ready  | Optional | Default Enabled | Frequently Used Variables              |
|----------------------| ------- |-----------------| -------- |-----------------|----------------------------------------|
| JDK 8                | 8.0.432 | Not Applicable  | No       | Yes             |                                        |
| JDK 11               | 11.0.25 | Not Applicable  | No       | Yes             |                                        |
| JDK 17               | 17.0.13 | Not Applicable  | No       | Yes             |                                        |
| JDK 21               | 21.0.5  | Not Applicable  | Yes      | No              | jdk21_enabled                          |
| JDK 25               | 25.0.0  | Not Applicable  | Yes      | No              | jdk25_enabled                          |
| KDC                  | latest  | Yes             | Yes      | No              | kerberos_enabled                       |
| MySQL                | 8.0     | No              | No       | Yes             |                                        |
| ZooKeeper            | 3.8.4   | Not Yet         | No       | Yes             |                                        |
| Hadoop HDFS          | 3.4.2   | Yes             | No       | Yes             |                                        |
| Hadoop YARN          | 3.4.2   | Yes             | No       | Yes             |                                        |
| Hive Metastore       | 2.3.9   | Yes             | No       | Yes             |                                        |
| HiveServer2          | 2.3.9   | Yes             | Yes      | Yes             | hive_server2_enabled                   |
| Kyuubi               | 1.10.2  | Yes             | No       | Yes             |                                        |
| Spark                | 4.0.1   | Yes             | Yes      | Yes             | spark_enabled, spark_custom_name       |
| Spark Connect Server | 4.0.1   | Not Applicable  | Yes      | No              | spark_connect_server_enabled           |
| Spark Thrift Server  | 4.0.1   | Yes             | Yes      | No              | spark_thrift_server_enabled            |
| Flink                | 1.20.1  | Yes             | Yes      | No              | flink_enabled                          |
| Trino                | 477     | Not Yet         | Yes      | No              | trino_enabled                          |
| Ranger               | 2.4.0   | Not Yet         | Yes      | No              | ranger_enabled                         |
| Zeppelin             | 0.12.0  | Not Yet         | Yes      | Yes             | zeppelin_enabled, zeppelin_custom_name |
| Kafka                | 3.6.2   | Not Yet         | Yes      | No              | kafka_enabled                          |
| Kafka UI             | 1.2.0   | Not Applicable  | Yes      | No              | kafka_ui_enabled                       |
| Grafana              | 11.5.2  | Not Applicable  | Yes      | No              | grafana_enabled                        |
| Prometheus           | 2.53.3  | Not Applicable  | Yes      | No              | promeheus_enabled                      |
| Loki                 | 3.4.2   | Not Applicable  | Yes      | No              | loki_enabled                           |
| Iceberg              | 1.10.0  | Yes             | Yes      | Yes             | iceberg_enabled                        |
| Hudi                 | 0.14.1  | Yes             | Yes      | No              | hudi_enabled                           |
| Parquet              | 1.16.0  | Not Applicable  | Yes      | Yes             | parquet_enabled                        |

**Note** :

- Most components respect `JAVA_HOME`, which is configured as JDK 8
- Hadoop HDFS and YARN are configured to use JDK 17
- Spark is configured to use JDK 17
- Trino is configured to use JDK 25
- Zeppelin is configured to use JDK 11

## Prepare

This project uses [Ansible](https://www.ansible.com/) to render the Dockerfile, shell scripts, and configuration files from the templates. Please make sure you have installed it before building.

<details>

<summary> (Optional, Recommended) Use pyenv to manage Python environments </summary>

Considering, ansible strongly depends on the Python environment. To make the Python environment independent and easy to manage, it is recommended to use [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) to manage Python environment.

### Install pyenv

Here we provide guides for macOS and CentOS users.

#### macOS

Install from Homebrew

```bash
brew install pyenv pyenv-virtualenv
```

Append to `~/.zshrc`, and perform `source ~/.zshrc` or open a new terminal to take effect.

```bash
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

#### CentOS

Before installing, we need to install some required packages.

```bash
yum install gcc make patch zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel
```

Then, install pyenv:

```bash
curl https://pyenv.run | bash
```

If you use `bash`, add it into `~/.bash_profile` or `~/.bashrc`:

```bash
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

Add it into `~/.bashrc`:

```bash
eval "$(pyenv virtualenv-init -)"
```

After all, source `~/.bash_profile` and `~/.bashrc`.

### Use pyenv

Create virtualenv

```bash
pyenv install 3.11
pyenv virtualenv 3.11 hadoop-testing
```

Localize virtualenv

```bash
pyenv local hadoop-testing
```

Install packages to the isolated virtualenv

```bash
pip install -r requirements.txt
```
</details>

<details>

<summary>(Optional) Configure SSH containers from host</summary>

This step allows you to ssh all the `hadoop-*` containers from your host, then can use ansible to control all the `hadoop-*` containers.

### Install nc

Here we provide guides for macOS and CentOS users.

#### macOS

The macOS should have pre-installed `nc`.

#### CentOS

Install `nc` using YUM:

```bash
yum install epel-release && yum install -y nc
```

### Configure SSH

Then configure the `~/.ssh/config` file in your host:

```bash
Host hadoop-*
    Hostname %h.orb.local
    User root
    Port 22
    ForwardAgent yes
    IdentityFile ~/.ssh/id_rsa_hadoop_testing
    StrictHostKeyChecking no
    ProxyCommand nc -x 127.0.0.1:18070 %h %p
```

**Note** : DO NOT forget to reduce access permission by invoking this command:

```bash
chmod 600 ~/.ssh/id_rsa_hadoop_testing
```

After all the containers have been launched, test the controllability via this command:

```bash
ansible-playbook test-ssh.yaml
```

It should print all nodes' OS information (include host and hadoop related containers).

If not, use `-vvv` config option to debug it.
</details>

## How to use

Firstly, use ansible to render some templates files, including `download.sh`, `.env`, `compose.yaml`, `Dockerfile`, configuration files, etc.

```bash
ansible-playbook build.yaml
```
Ensure you specify the inventory file when running the playbook if it is not located in the default path or correctly recognized by Ansible. For instance, use `ansible-playbook -i hosts playbook.yaml` to explicitly define the inventory.

By default, all services disable authN, you can enable Kerberos by passing the `kerberos_enabled` variable:

```bash
ansible-playbook build.yaml -e "{kerberos_enabled: true}"
```

And some components are disabled by default, you can enable them by passing the `<component>_enabled` variable:

```bash
ansible-playbook build.yaml -e "{jdk21_enabled: true, trino_enabled: true}"
```

Note: the whole variable list are defined in `host_vars/local.yaml`.

If something goes wrong, consider adding `-vvv` arg to debug the playbook:

```bash
ansible-playbook build.yaml -vvv
```

Download all required artifacts, which will be used for building Docker images.

This script will download a large amount of artifacts, depending on your network bandwidth,
it may take a few minutes or even hours to complete. You can also download them manually and
put them into the `download` directory, the scripts won't download them again if they already
exist.

```bash
./download.sh
```

Build docker images

```bash
./build-image.sh
```

Run the testing playground

```bash
docker compose up
```

Note: depending on the performance of your hardware, some components may take dozens of seconds
after container launching to complete the initial work, generally, the slowest one is creating
folders on HDFS, the progress can be observed by monitoring container logs.

## Access services

### Networks

#### Option 1: OrbStack (macOS only)

For macOS users, it's recommended to use [OrbStack](https://docs.orbstack.dev/) as the container runtime. OrbStack provides an out-of-box [container domain name resolving feature](https://docs.orbstack.dev/docker/domains) to allow accessing each container via `<container-name>.orb.local`.

#### Option 2: Socks5 Proxy

For other platforms, or you start the containers on a remote server, we provide a socks5 proxy server in a container named `socks5`, which listens 18070 port and is exposed to the dockerd host by default, you can forward traffic to this socks server to access services run in other containers.

For example, to access service in Browser, use [SwitchyOmega](https://github.com/FelisCatus/SwitchyOmega) to forward traffic of `*.orb.local` to `<dockerd-hostname>:18070`.

![img](docs/imgs/switchy-omega-1.png "step 1")
![img](docs/imgs/switchy-omega-2.png "step 2")
![img](docs/imgs/switchy-omega-3.png "step 3")

### Service endponits

Once the testing environment is fully operational, the following services will be accessible:

- Supervisor: http://hadoop-master1.orb.local:9001
- Supervisor: http://hadoop-worker1.orb.local:9001
- Supervisor: http://hadoop-worker2.orb.local:9001
- Supervisor: http://hadoop-worker3.orb.local:9001
- Grafana: http://grafana.orb.local:3000
- Prometheus: http://prometheus.orb.local:9090
- Kafka UI: http://kafka-ui.orb.local:19092
- Kyuubi UI: http://hadoop-master1.orb.local:10099
- Spark History Server: http://hadoop-master1.orb.local:18080
- Flink History Server: http://hadoop-master1.orb.local:8082
- Hadoop HDFS: http://hadoop-master1.orb.local:9870
- Hadoop YARN: http://hadoop-master1.orb.local:8088
- Hadoop MapReduce JobHistory: http://hadoop-master1.orb.local:19888
- Ranger Admin: http://hadoop-master1.orb.local:6080 (admin/Ranger@admin123)
- Trino Web UI: http://hadoop-master1.orb.local:18081 (admin/)
- Zeppelin: http://hadoop-master1.orb.local:8081

![img](docs/imgs/namenode-ui.png)

## Roadmap

1. Add more components, such as LDAP, HBase, Superset etc.
2. Fully templatized. Leverage Ansible and Jinja2 to templatize the Dockerfiles, shell scripts, and configuration files, so that users can easily customize the testing environment by modifying the configurations, e.g. only enabling a subset of components, and changing the version of the components.
3. Provide user-friendly docs, with some basic tutorials and examples, e.g. how to create a customized testing environment, how to run some basic examples, how to add a new component, etc.
