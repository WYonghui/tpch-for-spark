CREATE DATABASE IF NOT EXISTS tpch;
use tpch;

create table SUPPLIER(
S_SUPPKEY int,
S_NAME string,
S_ADDRESS string,
S_NATIONKEY int,
S_PHONE string,
S_ACCTBAL decimal,
S_COMMENT string
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n'
location 'hdfs://node91:9000/wyh/dataset/tpch/supplier'
tblproperties ('serialization.null.format'='')
;

create table PARTSUPP (
PS_PARTKEY   int,
PS_SUPPKEY   int,
PS_AVAILQTY  int,
PS_SUPPLYCOST  decimal,
PS_COMMENT  string
)ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
location 'hdfs://node91:9000/wyh/dataset/tpch/partsupp'
tblproperties ('serialization.null.format'='')
;

create table CUSTOMER(                                                          
C_CUSTKEY   int,
C_NAME      string,
C_ADDRESS   string,
C_NATIONKEY int,
C_PHONE     string,
C_ACCTBAL   decimal,
C_MKTSEGMENT string,
C_COMMENT   string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
location 'hdfs://node91:9000/wyh/dataset/tpch/customer'
tblproperties ('serialization.null.format'='')
;

create table ORDERS(                                                          
O_ORDERKEY int,
O_CUSTKEY  int,
O_ORDERSTATUS string,
O_TOTALPRICE decimal,
O_ORDERDATE  date,
O_ORDERPRIORITY string,
O_CLERK         string,
O_SHIPPRIORITY  int,
O_COMMENT       string                                                                 
)ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
location 'hdfs://node91:9000/wyh/dataset/tpch/orders'
tblproperties ('serialization.null.format'='')
;

create table LINEITEM(                                                          
L_ORDERKEY int,
L_PARTKEY  int,
L_SUPPKEY  int,
L_LINENUMBER int,
L_QUANTITY decimal,
L_EXTENDEDPRICE decimal,
L_DISCOUNT decimal,
L_TAX      decimal,
L_RETURNFLAG string,
L_LINESTATUS string,
L_SHIPDATE   date,
L_COMMITDATE date,
L_RECEIPTDATE date,
L_SHIPINSTRUCT string,
L_SHIPMODE string,
L_COMMENT  string                                        
)ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
location 'hdfs://node91:9000/wyh/dataset/tpch/lineitem'
tblproperties ('serialization.null.format'='')
;

create table NATION (                                                          
N_NATIONKEY int,
N_NAME string,
N_REGIONKEY int,
N_COMMENT  string                                                             
)ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
location 'hdfs://node91:9000/wyh/dataset/tpch/nation'
tblproperties ('serialization.null.format'='')
;

create table PART(
P_PARTKEY     int,
P_NAME        string,
P_MFGR        string,
P_BRAND       string,
P_TYPE        string,
P_SIZE        int,
P_CONTAINER   string,
P_RETAILPRICE decimal,
P_COMMENT     string
)ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
location 'hdfs://node91:9000/wyh/dataset/tpch/part'
tblproperties ('serialization.null.format'='')
;

create table REGION(
R_REGIONKEY int,
R_NAME string,
R_COMMENT string
)ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n'
location 'hdfs://node91:9000/wyh/dataset/tpch/region'
tblproperties ('serialization.null.format'='')
;
