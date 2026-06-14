create table core.load (
	datetime_utc		timestamp
	,date				date
	,time				time
	,resolution_code	text
	,area_code			text
	,area_display_name	text
	,area_type_code		text
	,area_map_code		text
	,total_load_mw		numeric(12,2)
	,update_time_utc	timestamp
);

create table core.generation (
	datetime_utc		timestamp
	,date				date
	,time				time
	,resolution_code	text
	,area_code			text
	,area_display_name	text
	,area_type_code		text
	,area_map_code		text
	,production_type	text
	,generation_mw		numeric(12,2)
	,consumption_mw		numeric(12,2)
	,update_time_utc	timestamp
);

create table core.reservoirs (
	date				date
	,year				numeric(12,2)
	,month				numeric(12,2)
	,week				numeric(12,2)
	,timezone			text
	,resolution_code	text
	,area_code			text
	,area_display_name	text
	,area_type_code		text
	,area_map_code		text
	,stored_energy_mwh	numeric(12,2)
	,update_time_utc	timestamp
);

create table core.flows (
	datetime_utc			timestamp
	,date					date
	,time					time
	,resolution_code		text
	,out_area_code			text
	,out_area_display_name	text
	,out_area_type_code		text
	,out_area_map_code		text
	,in_area_code			text
	,in_area_display_name	text
	,in_area_type_code		text
	,in_area_map_code		text
	,flow_mw				numeric(12,2)
	,update_time_utc		timestamp
);

create table core.prices (
	datetime_utc		timestamp
	,date				date
	,time				time
	,price_eur_mwh		numeric(12,2)
	,bidding_zone		text
	,area_code			text
);
