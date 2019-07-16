select
	ps_partkey,
	sum(ps_supplycost * ps_availqty) as value 
from
	partsupp,
	supplier,
	nation,
	(
		select 
			sum(ps_supplycost * ps_availqty) * 0.0001000000 s 
		from 
			partsupp,
			supplier,
			nation
		where
			ps_suppkey = s_suppkey 
			and s_nationkey = n_nationkey 
			and n_name = 'GERMANY' 
	) v 
where 
	ps_suppkey = s_suppkey 
	and s_nationkey = n_nationkey 
	and n_name = 'GERMANY' 
group by 
	ps_partkey, v.s having 
		sum(ps_supplycost * ps_availqty) > v.s 
order by 
	value desc;

