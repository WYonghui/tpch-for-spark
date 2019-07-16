select
	o_orderpriority,
	count(*) as order_count
from
	orders
	left semi join
	(select l_orderkey  from lineitem where l_commitdate < l_receiptdate) l
	on l_orderkey = o_orderkey
where
	o_orderdate >= date '1993-07-01'
	and o_orderdate < date '1993-10-01'

group by
	o_orderpriority
order by
	o_orderpriority;
