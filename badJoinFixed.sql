-- look at how one brand is doing
with branded as (
    select pencil_id
    from pencil
    where brand = '{brand}')
    , cross as (
    -- here we will get just the last test
    select branded.pencil_id, max(xref.xref_test_id) as recent_test_id
    from branded
    inner join xref
        on xref.xref_pencil_id = branded.pencil_id
    group by 1)
    , brandtest as (
    select cross.pencil_id, test.test_id, test.condition
    from cross
    inner join test
        -- with proper on 
        on cross.recent_test_id = test.test_id)

    , checker as (
    select '0 pencils' as cten, count (*) as n from pencil union all
    select '1 branded' as cten, count (*) as n from branded union all
    select '2 matched to xref' as cten, count (*) as n from cross union all
    select '3 matched to tests' as cten, count(*) as n from brandtest)
    , getter as (select * from brandtest)

select * from {final}
