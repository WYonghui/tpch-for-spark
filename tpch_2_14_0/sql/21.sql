
select
         s_name,
         count(*) as numwait
from
         supplier,
         lineitem l1,
         orders,
         nation,
         (
                   select
                            l_orderkey m2_l_orderkey,
                            l_suppkey m2_l_suppkey
                   from
                            lineitem l2
         ) v2,
         (
                   select
                            l_orderkey m3_l_orderkey,
                            l_suppkey m3_l_suppkey
                   from
                            lineitem l3
                   where
                            l3.l_receiptdate > l3.l_commitdate
         ) V3
where
         s_suppkey = l1.l_suppkey
         and o_orderkey = l1.l_orderkey
         and o_orderstatus = 'F'
         and l1.l_receiptdate > l1.l_commitdate
         and v2.m2_l_orderkey = l1.l_orderkey
         and v2.m2_l_suppkey <> l1.l_suppkey
         and (v3.m3_l_orderkey <> l1.l_orderkey or v3.m3_l_suppkey = l1.l_suppkey)
         and s_nationkey = n_nationkey
         and n_name = 'SAUDI ARABIA'
group by
         s_name
order by
         numwait desc,
         s_name;
