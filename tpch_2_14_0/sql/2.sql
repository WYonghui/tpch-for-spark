select
	s_acctbal,
	s_name,
	n_name,
	p_partkey,
	p_mfgr,
	s_address,
	s_phone,
	s_comment
from
	part,
	supplier,
	partsupp,
	nation,
	region,
	(select
                            min(ps_supplycost) v_ps_supplycost,
                            ps_partkey v_ps_partkey
                   from
                            partsupp t1,
                            supplier t2,
                            nation t3,
                            region t4
                   where
                            t2.s_suppkey = t1.ps_suppkey
                            and t2.s_nationkey = t3.n_nationkey
                            and t3.n_regionkey = t4.r_regionkey
                            and t4.r_name = 'EUROPE'
                   group by
                            ps_partkey) v
where
	p_partkey = ps_partkey
	and s_suppkey = ps_suppkey
	and p_size = 15
	and p_type like '%BRASS'
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'EUROPE'
	and ps_supplycost = v.v_ps_supplycost
	 and p_partkey = v.v_ps_partkey 
order by
	s_acctbal desc,
	n_name,
	s_name,
	p_partkey;

