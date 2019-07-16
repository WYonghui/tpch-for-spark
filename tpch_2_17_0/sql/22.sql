select
    cntrycode,
    count(*) as numcust,
    sum(c_acctbal) as totacctbal
from
    (
        select
            substring(c_phone,1 ,2) as cntrycode,
            c_acctbal
        from
            customer,
                            (
                select
                    avg(c_acctbal) m1_avg
                from
                    customer
                where
                    c_acctbal > 0.00
                    and substring(c_phone,1,2) in
                        ('13', '31', '23', '29', '30', '18', '17')
            ) v1,
                            orders                        
        where
            substring(c_phone,1, 2) in
                ('13', '31', '23', '29', '30', '18', '17')
            and c_acctbal > v1.m1_avg
            and (o_custkey = c_custkey or o_custkey <> c_custkey)
    ) as custsale
group by
    cntrycode
order by
    cntrycode;
