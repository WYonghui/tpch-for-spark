#!/bin/bash

#生成30GB数据
#生成lineitem表，20个分片
for i in $(seq 20)
do
  ./dbgen -T L -S $i -s 30 -C 20 -v
done

#生成其他个表，10个分片
TABLES="c n O P r s S"
for x in $TABLES
do
  for i in $(seq 10)
  do 
    ./dbgen -T $x -S $i -s 30 -C 10 -v
  done 
done

# SERVICES="part partuspp customer supplier orders lineitem nation region"
# HDFS-PATH="/data"
# for word in $SERVICES
# do
#  mkdir data
#  mkdir data/$word
#  mv $word.tbl* data/$word 
#  hdfs dfs -put data/$word/ HDFS-PATH
#done

#spark查询命令
#spark-sql --database $TPCDS_DBNAME --name ${file}_$times -f "$file" --silent > $sysout 2>&1
# ${file}_$times：查询名称，显示在UI中的应用名
# $file：查询语句所在的sql文件
# $sysout：查询结果输出文件

