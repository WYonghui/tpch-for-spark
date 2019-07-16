#!/bin/bash
echo "-----------开始查询-----------"
echo "-----------数据库为tpch------------"

#exec sql
#for (( i=1;i<23;++i ))
for (( i=9;i<10;++i ))
do

    file="/opt/spark-tpcds/tpch-for-spark/tpch/tpch_2_17_0/sql/${i}.sql"
    if [ ! -f $file ]; then
        echo "$file is not exist!"
        exit 1
    fi

    echo $file 查询中
    result="/opt/spark-tpcds/tpch-for-spark/tpch/tpch_2_17_0/result/query.result"
    echo -n "$i.sql," >> $result
    for(( times=1;times<=1;times++))
    do
#	echo ${file}_$times 查询中
	sysout="/opt/spark-tpcds/tpch-for-spark/tpch/tpch_2_17_0/result/query${i}.out"    
	spark-sql --database tpch --name ${file} -f "$file" --silent > $sysout 2>&1
    time=`cat $sysout | grep "Time taken:" | grep "Driver" | awk -F 'Time taken:' '{print $2}' | awk -F ' ' '{print $1}'`

    if [ "$time" = "" ];then
	   echo -n "0," >> $result
	else
 	   echo -n "$time," >> $result
	fi 

    done 
    echo "" >> $result
done

exit 0
