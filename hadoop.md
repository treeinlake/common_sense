### Hadoop with yarn 安装

### [Hadoop: Setting up a Single Node Cluster](http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html#Pseudo-Distributed_Operation)

- 安装必备库: 

  ```bash
  sudo apt-get install openssh-server
  sudo /etc/init.d/ssh start
  sudo apt-get install ssh
  sudo apt-get install rsync
  ```

- 查找可用jdk并下载:

  ```bash
  sudo apt-cache search jdk | grep jdk
  sudo apt install openjdk-8-jdk
  ```

- 本地免密ssh: （便于之后启动hadoop）

  ```bash
  cd ~
  ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
  chmod 0600 ~/.ssh/authorized_keys
  ssh localhost
  ```

- 下载Hadoop: `wget http://mirror.bit.edu.cn/apache/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz`

- 解压: `sudo tar xzf hadoop-2.9.2.tar.gz`

- 复制: `sudo mv hadoop-2.9.2 /usr/local/hadoop`

- 权限: `sudo chmod 774 /usr/local/hadoop`

- 配置: `~/.bashrc`:

  ```bash
  #HADOOP VARIABLES START
  export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
  export HADOOP_INSTALL=/usr/local/hadoop
  export PATH=$PATH:$HADOOP_INSTALL/bin
  export PATH=$PATH:$HADOOP_INSTALL/sbin
  export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
  export HADOOP_COMMON_HOME=$HADOOP_INSTALL
  export HADOOP_HDFS_HOME=$HADOOP_INSTALL
  export YARN_HOME=$HADOOP_INSTALL
  export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
  export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
  #HADOOP VARIABLES END
  ```

- 修改: `/usr/local/hadoop/etc/hadoop/hadoop-env.sh`:   

  ```bash
  export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
  ```


- 修改: `/usr/local/hadoop/etc/hadoop/core-site.xml`: （hadoop）

  ```xml
  <configuration>
      <property>
          <name>fs.defaultFS</name>
          <value>hdfs://localhost:9000</value>
      </property>
  </configuration>
  ```

  修改: `/usr/local/hadoop/etc/hadoop/hdfs-site.xml`:（hadoop）

  ```xml
  <configuration>
      <property>
          <name>dfs.replication</name>
          <value>1</value>
      </property>
  </configuration>
  ```

  修改: `/usr/local/hadoop/etc/hadoop/mapred-site.xml`:（yarn）

  ```xml
  <configuration>
      <property>
          <name>mapreduce.framework.name</name>
          <value>yarn</value>
      </property>
  </configuration>
  ```

  修改: `etc/hadoop/yarn-site.xml`:（yarn）

  ```xml
  <configuration>
      <property>
          <name>yarn.nodemanager.aux-services</name>
          <value>mapreduce_shuffle</value>
      </property>
  </configuration>
  ```

- 格式化文件系统: `/usr/local/hadoop/bin/hdfs namenode -format`

- 启动: `sbin/start-dfs.sh`  `sbin/start-yarn.sh`

- 停止: `sbin/stop-dfs.sh` `sbin/stop-yarn.sh`

#### 便捷启动停止

- 新增: `vi ~/start.sh`:

  ```bash
  source ~/.bashrc
  service ssh start
  $HADOOP_HOME/sbin/start-dfs.sh
  $HADOOP_HOME/sbin/start-yarn.sh
  $HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver
  jps
  ```

- 更改: `chmod +x ~/start.sh`

- 新增: `vi ~/stop.sh`

  ```bash
  source ~/.bashrc
  $HADOOP_HOME/sbin/stop-dfs.sh
  $HADOOP_HOME/sbin/stop-yarn.sh
  $HADOOP_HOME/sbin/mr-jobhistory-daemon.sh stop historyserver
  ```

- 更改: `chmod +x ~/stop.sh`

#### 测试

```bash
hadoop fs -mkdir /user
hadoop fs -mkdir /user/<username>
hadoop fs -put etc/hadoop input
hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.9.2.jar grep input output 'dfs[a-z.]+'
hadoop fs -get output output
cat output/*
hadoop fs -cat output/*
```



#### [Hadoop HDFS Installation on single node cluster with Ubuntu docker image](http://hadooptutorials.info/2017/09/14/hadoop-installation-on-signle-node-cluster/)