select
    s_name,
    s_address
from
    supplier,
    nation,
    (
        select
            ps_suppkey m_ps_suppkey
        from
            partsupp,
            (
                select
                    l_partkey m_l_partkey,
                    l_suppkey m_l_suppkey,
                    0.5 * sum(l_quantity) m_sum
                from
                    lineitem
                where
                    l_shipdate >= date '1994-01-01'
                    and l_shipdate < date '1995-01-01'
                group by
                    l_partkey, l_suppkey
            ) v1,
            (
                select
                    p_partkey m_p_partkey
                from
                    part
                where
                    p_name like 'forest%'
            ) v2
        where
            ps_partkey = v2.m_p_partkey
            and ps_availqty > v1.m_sum
            and v1.m_l_partkey = ps_partkey
            and v1.m_l_suppkey = ps_suppkey
    ) v3
where
    s_suppkey = v3.m_ps_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'CANADA'
order by
    s_name;

