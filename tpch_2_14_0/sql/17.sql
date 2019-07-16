select
         sum(l_extendedprice) / 7.0 as avg_yearly
from
         lineitem,
         part,
         (
                   select
                            l_partkey m_l_partkey,
                            0.2 * avg(l_quantity) m_avg
                   from
                            lineitem
                   group by
                            l_partkey
         ) v
where
         p_partkey = l_partkey
         and p_brand = 'Brand#23'
         and p_container = 'MED BOX'
         and p_partkey = v.m_l_partkey
         and l_quantity < v.m_avg;
