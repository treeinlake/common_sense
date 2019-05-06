### hive with mysql 安装

- [下载hive-2.3](https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-2.3.4/): `wget https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-2.3.4/apache-hive-2.3.4-bin.tar.gz`

- 解压: `tar -xvf apache-hive-2.3.4-bin.tar.gz`

- 创建: `sudo mkdir -p /usr/local/hive/`

- 移动: `sudo mv apache-hive-2.3.4-bin /usr/local/hive/hive-2.3.4`

- 转移: `cd /usr/local/hive/hive-2.3.4/conf`

- 复制: `cp hive-default.xml.template hive-site.xml`

- 复制: `cp hive-env.sh.template hive-env.sh`

- 创建: 在mysql中创建专属于hive的用户并创建相应数据库

    ```bash
    $ sudo mysql -u root -p
    $ mysql> CREATE USER 'hadoop'@'%' IDENTIFIED BY '123123';
    $ mysql> GRANT ALL PRIVILEGES ON *.* TO 'hadoop'@'%' WITH GRANT OPTION;
    $ mysql> flush privileges;
    $ mysql> create database hive;
    ```

- 更改: `conf/hive-site.xml`:  (即配置数据库连接信息，对应上面的mysql创建)

    ```xml
    <property>
      <name>javax.jdo.option.ConnectionURL</name>
      <value>jdbc:mysql://localhost:3306/hive?useSSL=false<</value>
    </property>
    <property>
      <name>javax.jdo.option.ConnectionDriverName</name>
      <value>com.mysql.jdbc.Driver</value>
    </property>
    <property>
      <name>javax.jdo.option.ConnectionUserName</name>
      <value>hadoop</value>
    </property>
    <property>
      <name>javax.jdo.option.ConnectionPassword</name>
      <value>123123</value>
    </property>
    ```


- 更改: `conf/hive-site.xml`中
    `${system:java.io.tmpdir}`全部替换为 `${java.io.tmpdir}` 或 自定义的有读写权限的tmp文件夹路径
    `${system:user.name}`全部替换为`${user.name}`

- 添加: `~/.bashrc`:

    ```bash
    export HIVE_HOME=/usr/local/hive/hive-2.3.4
    export HIVE_AUX_JARS_PATH=$HIVE_HOME/lib
    export HIVE_CONF_DIR=$HIVE_HOME/conf
    export PATH=$PATH:$HIVE_HOME/bin
    export CLASSPATH=$CLASSPATH:$HIVE_HOME/lib
    ```

- 下载mysql-connector-java: `wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.tar.gz`

- 解压: `tar xvf mysql-connector-java-5.1.47.tar.gz`

- 移动: `mv mysql-connector-java-5.1.47/mysql-connector-java-5.1.47-bin.jar /usr/local/hive/hive-2.3.4/lib/`  (即 将数据库连接库复制到hive的lib下)

- 删除: `mv /usr/local/hive/hive-2.3.4/lib/log4j-slf4j-impl-2.6.2.jar ~/` （由于hadoop和hive的log4j.jar包重复导致冲突，需要删除其中一个）

- 初始化hive: `schematool -dbType mysql -initSchema`

- 启动: `hive`

#### hive test

- 建库: `create database myowndb comment "This is just a test database";`

- 查看: `show databases;`

- 使用: `use myowndb;`

- 创表: `create table courses(course_id int,course_name string,students_enrolled int);`

- 查看: `describe courses;`

- 插入: `INSERT INTO TABLE courses VALUES (1,'Hadoop',5500);`

- 插入: `INSERT INTO TABLE courses VALUES (2,'spark',3500);`

- 查询: `select * from courses;`