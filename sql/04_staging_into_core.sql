insert into core.flows
select datetime_utc::timestamp 
	,datetime_utc::date as date
	,datetime_utc::time as time
	,resolution_code
	,out_area_code
	,out_area_display_name
	,out_area_type_code
	,out_area_map_code
	,in_area_code
	,in_area_display_name
	,in_area_type_code
	,in_area_map_code
	,flow_mw::numeric(12,2)
	,update_time_utc::timestamp
 from staging.flows;


insert into core.generation 
select datetime_utc::timestamp 
	,datetime_utc::date as date
	,datetime_utc::time as time
	,resolution_code
	,area_code
	,area_display_name
	,area_type_code
	,area_map_code
	,production_type
	,coalesce(nullif(generation_mw, ''), '0')::numeric(12,2)
	,coalesce(nullif(consumption_mw, ''), '0')::numeric(12,2)
	,update_time_utc::timestamp
from staging.generation;


insert into core."load"
select datetime_utc::timestamp 
	,datetime_utc::date as date
	,datetime_utc::time as time
	,resolution_code
	,area_code
	,area_display_name
	,area_type_code
	,area_map_code
	,total_load_mw::numeric(12,2)
	,update_time_utc::timestamp
from staging."load";


insert into core.prices
select datetime_utc::timestamp 
	,datetime_utc::date as date
	,datetime_utc::time as time
	,nullif(price_eur_mwh, '')::numeric(12,2)
	,bidding_zone
	,area_code
from staging.prices;


insert into core.reservoirs
select (to_date("year" || '-' || week, 'IYYY-IW') + interval '6 days')::date as date
	,"year"::numeric(12,2)
	,"month"::numeric(12,2)
	,week::numeric(12,2)
	,timezone
	,resolution_code
	,area_code
	,area_display_name
	,area_type_code
	,area_map_code
	,stored_energy_mwh::numeric(12,2)
	,update_time_utc::timestamp
from staging.reservoirs;

