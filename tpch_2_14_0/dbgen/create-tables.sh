#!/bin/bash

#生成lineitem表，20个分片
for i in $(seq 20)
do
  ./dbgen -T L -S $i -s 30 -C 20 -v
done

#生成其他表，10个分片
TABLES="c n O P r s S"
for x in $TABLES
do
  for i in $(seq 10)
  do 
    ./dbgen -T $x -S $i -s 30 -C 10 -v
  done 
done

:<<!
SERVICES="part partuspp customer supplier orders lineitem nation nation"
for word in $SERVICES
do
  mkdir data/$word
  mv $word.tbl* data/$word 
  hdfs dfs -put data/$word /data
done
!
