免密ssh, A访问B免密，即把A的公钥给B
# 在客户端A生成公钥 (windows下亦可)
ssh-keygen
# 将id_rsa.pub公钥文件拷贝到服务器B的~/.ssh目录下
# 并在B的该目录下新建authorized_keys文件 touch .ssh/authorized_keys
# 并追加公钥字符串至该文件 cat .ssh/id_rsa.pub >> .ssh/authorized_keys
# 注意B的文件权限 chmod 600 .ssh/authorized_keys && chmod 700 .ssh
# 等价于
ssh-copy-id -i .ssh/id_rsa.pub lake@192.168.150.128
                               user@remotehost
