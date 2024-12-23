export ZK_SERVER_HEAP=384

# ZOOKEEPER-1177 (3.6.0)
# https://xie.infoq.cn/article/f346a8284f59e16bb7f89188e
export SERVER_JVMFLAGS="-Dzookeeper.watchManagerName=org.apache.zookeeper.server.watch.WatchManagerOptimized"
