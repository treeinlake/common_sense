### mysql安装使用

- [how-to-install-mysql-on-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-18-04) （在Ubuntu18上安装）

  ```bash
  # 安装以及安全设置
  sudo apt update
  sudo apt install mysql-server
  sudo mysql_secure_installation
  sudo mysql
  # 创建新用户
  mysql> CREATE USER 'sammy'@'localhost' IDENTIFIED BY 'password';
  mysql> GRANT ALL PRIVILEGES ON *.* TO 'sammy'@'localhost' WITH GRANT OPTION;
  mysql> exit
  ```

- [a-basic-mysql-tutorial](https://www.digitalocean.com/community/tutorials/a-basic-mysql-tutorial) （简易教程）

  ```mysql
  SHOW DATABASES;
  CREATE DATABASE t1;
  USE t1;
  CREATE TABLE potluck (
      id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
      name VARCHAR(20),
      food VARCHAR(30),
      confirmed CHAR(1), 
      signup_date DATE
  );

  -- 插入
  INSERT INTO `potluck` (`id`,`name`,`food`,`confirmed`,`signup_date`) VALUES (NULL, "Sandy", "Key Lime Tarts","N", '2012-04-14');
  INSERT INTO `potluck` (`id`,`name`,`food`,`confirmed`,`signup_date`) VALUES (NULL, "Tom", "BBQ","Y", '2012-04-18');
  INSERT INTO `potluck` (`id`,`name`,`food`,`confirmed`,`signup_date`) VALUES (NULL, "Tina", "Salad","Y", '2012-04-10'); 

  -- 更新
  UPDATE `potluck` 
  SET 
  `confirmed` = 'Y' 
  WHERE `potluck`.`name` ='Sandy';

  -- 新增/删除列
  ALTER TABLE potluck ADD email VARCHAR(40);
  ALTER TABLE potluck DROP email;
  ALTER TABLE potluck ADD email VARCHAR(40) AFTER name; 

  -- 删除列
  DELETE from potluck  where name='Sandy';

  SELECT * FROM potluck;
  ```

- [mysql-connector-java-5.1 download](https://dev.mysql.com/downloads/connector/j/5.1.html) （Java连接库）
