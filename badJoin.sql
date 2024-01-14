-- look at how one brand is doing
with branded as (
    select pencil_id
    from pencil
    where brand = '{brand}')
    , crossr as (
    -- this will cause multiple matches per pencil. usually unwanted. 
    select branded.pencil_id, xref.xref_test_id
    from branded
    inner join xref
        on xref.xref_pencil_id = branded.pencil_id)
    , brandtest as (
    select crossr.pencil_id, test.test_id, test.condition
    from crossr
    inner join test
        -- this will make a mess
        on crossr.xref_test_id = crossr.xref_test_id)

    , checker as (
    select '0 pencils' as cten, count (*) as n from pencil union all
    select '1 branded' as cten, count (*) as n from branded union all
    select '2 matched to xref' as cten, count (*) as n from crossr union all
    select '3 matched to tests' as cten, count(*) as n from brandtest)
    , getter as (select * from brandtest)

select * from {final}
