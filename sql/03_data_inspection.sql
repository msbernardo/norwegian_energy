-- Row counts
select count(*) from staging.load;  -- 752.429
select count(*) from staging.flows;  -- 6.155.624
select count(*) from staging.generation;  -- 4.495.647
select count(*) from staging.reservoirs;  -- 3.522
select count(*) from staging.prices;  -- 517.720



-- Check what areas came through
select distinct area_map_code 
from staging.load
order by 1;

select distinct out_area_map_code  
from staging.flows
order by 1;

select distinct in_area_map_code  
from staging.flows
order by 1;

select distinct area_map_code   
from staging.generation
order by 1;

select distinct area_map_code   
from staging.reservoirs
order by 1;

select distinct area_code    
from staging.prices
order by 1;



-- Check timestamp format
select datetime_utc  -- 2016-04-01 00:00:00
from staging.load
limit 5;

select datetime_utc  -- 2015-02-01 00:00:00
from staging.flows
limit 5;

select datetime_utc  -- 2015-02-01 00:00:00
from staging.generation
limit 5;

select datetime_utc  -- 2014-12-12 00:00:00+01:00
from staging.prices
limit 5;

