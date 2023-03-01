# Set Hadoop-specific environment variables here.
# Forcing YARN-based mapreduce implementaion.
# Make sure to comment out if you want to go back to the default or
# if you want this to be tweakable on a per-user basis
# export HADOOP_MAPRED_HOME=/usr/lib/hadoop-mapreduce

# The maximum amount of heap to use, in MB. Default is 1000.
export HADOOP_HEAPSIZE=256

# Extra Java runtime options.  Empty by default.
export HADOOP_NAMENODE_OPTS="$HADOOP_NAMENODE_OPTS -Xmx512m"
export YARN_OPTS="$YARN_OPTS -Xmx256m"

# Necessary to prevent map reduce jobs triggered by hive queries from dying with OOM error
export HADOOP_CLIENT_OPTS="$HADOOP_CLIENT_OPTS -Xmx512m"
