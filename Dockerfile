## 使用jdk1.8的环境
FROM majiajue/jdk1.8:latest
RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN apt-get update 
RUN apt-get -y  install wget


WORKDIR /app
# RUN wget https://mirrors.tuna.tsinghua.edu.cn/apache/hbase/2.5.5/hbase-2.5.5-hadoop3-bin.tar.gz
# RUN wget https://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
COPY hadoop-3.3.6.tar.gz .
COPY hbase-2.5.5-hadoop3-bin.tar.gz .

RUN tar zxvf hadoop-3.3.6.tar.gz
RUN tar zxvf hbase-2.5.5-hadoop3-bin.tar.gz
RUN rm hadoop-3.3.6.tar.gz hbase-2.5.5-hadoop3-bin.tar.gz

RUN export PATH=/app/hadoop-3.3.6/bin:hadoop-3.3.6/sbin:/app/hbase-2.5.5-hadoop3/bin:PATH

## 配置 ssh
RUN apt-get -y  install ssh
RUN service ssh start
RUN ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ''
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

##配置Hadoop
RUN sed -i '2s/^/HDFS_DATANODE_USER=root \
    HDFS_DATANODE_SECURE_USER=hdfs \
    HDFS_NAMENODE_USER=root \
    HDFS_SECONDARYNAMENODE_USER=root/'  /app/hadoop-3.3.6/sbin/start-dfs.sh




######################################
# 运行命令
# 学习资料
# vscode连接Linux系统下的docker容器: https://bioinfo.online/pipline/202372153910.html
# Dockerfile基础: https://bioinfo.online/pipline/202312546249.html
# Hbase简介: https://bioinfo.online/articleList/20237207563.html
# Hadoop单机版环境搭建: https://bioinfo.online/articleList/202371938896.html
######################################
# docker build -t hbase .
# docker run --rm -it  hbase:latest 

