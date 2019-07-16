# TPC-H测试Spark Sql 
	
	标签（空格分隔）： spark tpc-h
	
	---
	**1 TPC-H 介绍**
	参考网址：http://www.tpc.org/tpch/
	
	        商业智能计算测试TPC-H 是美国交易处理效能委员会(TPC,Transaction Processing Performance Council) 组织制定的用来模拟决策支持类应用的一个测试集.目前,在学术界和工业界普遍采用它来评价决策支持技术方面应用的性能. 这种商业测试可以全方位评测系统的整体商业计算综合能力，对厂商的要求更高，同时也具有普遍的商业实用意义，目前在银行信贷分析和信用卡分析、电信运营分析、税收分析、烟草行业决策分析中都有广泛的应用。
	        TPC-H 基准测试是由 TPC-D(由 TPC 组织于 1994 年指定的标准,用于决策支持系统方面的测试基准)发展而来的.TPC-H 用 3NF 实现了一个数据仓库,共包含8个基本关系/表，其中表REGION和表NATION的记录数是固定的（分别为5条记录和25条记录），其它6个表的记录数，则随所设定的参数SF而有所不同，其数据量可以设定从1GB～3TB不等，有8个级别供用户选择。
	        TPC-H 基准测试包括 22 个查询(Q1~Q22),其主要评价指标是各个查询的响应时间,即从提交查询到结果返回所需时间.2个更新（带有INSERT和DELETE的程序段）操作组成一个更新流；查询流和更新流并发执行，查询流数目随数据量增加而增加。
	        TPC-H 基准测试的度量单位是每小时执行的查询数( QphH@size)，其中 H 表示每小时系统执行复杂查询的平均次数，size 表示数据库规模的大小,它能够反映出系统在处理查询时的能力.TPC-H 是根据真实的生产运行环境来建模的,这使得它可以评估一些其他测试所不能评估的关键性能参数.总而言之,TPC 组织颁布的TPC-H 标准满足了数据仓库领域的测试需求,并且促使各个厂商以及研究机构将该项技术推向极限。
	
**2   TPC-H 工具编译**
    在linux编译
    
 - cd dbgen
 - cp makefile.suite makefile
 - 修改makefile
`CC =  GCC  
 使用GCC编辑
	#Current values for DATABASE are: INFORMIX, DB2, TDAT (Teradata)
	#SQLSERVER, SYBASE, ORACLE, VECTORWISE
	#Current values for MACHINE are: ATT, DOS, HP, IBM, ICL, MVS,SGI, SUN, U2200, VMS, LINUX, WIN32
	#Current values for WORKLOAD are: TPCH
	DATABASE=  SQLSERVER    #数据类型
	MACHINE = LINUX         #机器环境
	WORKLOAD =TPCH  `

 - make 编译
 然后就会在dbgen目录下生成两个工具dbgen 和qgen
DBGEN:用于产生测试库中的数据，生成的数据存储在文本文件中
qgen:用于生成测试数据的sql语句,现在有22条查询,2条更新

**3 dbgen工具**
            
TPC-H数据库的组成被定义为由八个单独的表（基本表）组成,分别时part、 partuspp、 customer 、supplier 、orders、 lineitem 、nation、 nation,除Nation 和Region 表外，其它表与测试的数据量有关，即比例因SF。
   **参数说明：**

dbgen [-{vf}][-T {pcsoPSOL}]
        [-s <scale>][-C <procs>][-S <step>]
dbgen [-v] [-O m] [-s <scale>] [-U <updates>]
-C n -- separate data set into <n> chunks (requires -S, default: 1)
-f     -- force. Overwrite existing files
-h     -- display this message
-q     -- enable QUIET mode
-s n   -- scale factor. TPC-H runs are only compliant when run against SF's of 1, 10, 100, 300, 1000, 3000, 10000, 30000, 100000
-S n -- build the <n>th step of the data/update set (used with -C or -U)
-U n -- generate <n> update sets
-v     -- enable VERBOSE mode
-T table  Generate the data for a particular table 
    ONLY. Arguments: p -- part/partuspp,c -- customer, s -- supplier, o -- orders/lineitem, n -- nation, r -- region,l -- code (same as n and r), O -- orders, L -- lineitem, P -- part, S -- partsupp
    
*举例说明*：dbgen 生成100中第一个10G的customer表

dbgen -S 1 -s 10 -T c -C 100 -v 

这里边的S 和C需要配合使用

  
**4 生成元数据**
        在实际测试环境中，生成30G数据，并将元数据分成10个分片。
        具体操作:`dbgen -S 1 -s 30  -C 10 -v` 
        创建脚本create_data.sh实现生成数据，并上传到集群/data目录

for i in $(seq 10)
do
./dbgen -S $i -s 30  -C 10 -v  
done
SERVICES="part partuspp customer supplier orders lineitem nation nation"
for word in $SERVICES 
do
        mkdir data/$word
        mv $word.tbl* data/$word
        hadoop fs -put data/$word /data
done

*备注* lineitem表非常大，需要设置更多的分片

**5.建表语句:sql/create_table.sql**

**6.导入元数据： sql/load_data.sql**

**7 使用qgen 生成sql语句: 在sql目录下是针对spark sql修改过的sql，可以直接使用**

