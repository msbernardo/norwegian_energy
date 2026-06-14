create table staging.load (
	datetime_utc		text
	,resolution_code	text
	,area_code			text
	,area_display_name	text
	,area_type_code		text
	,area_map_code		text
	,total_load_mw		text
	,update_time_utc	text
);

create table staging.generation (
	datetime_utc		text
	,resolution_code	text
	,area_code			text
	,area_display_name	text
	,area_type_code		text
	,area_map_code		text
	,production_type	text
	,generation_mw		text
	,consumption_mw		text
	,update_time_utc	text
);

create table staging.reservoirs (
	year				text
	,month				text
	,week				text
	,timezone			text
	,resolution_code	text
	,area_code			text
	,area_display_name	text
	,area_type_code		text
	,area_map_code		text
	,stored_energy_mwh	text
	,update_time_utc	text
);

create table staging.flows (
	datetime_utc			text
	,resolution_code		text
	,out_area_code			text
	,out_area_display_name	text
	,out_area_type_code		text
	,out_area_map_code		text
	,in_area_code			text
	,in_area_display_name	text
	,in_area_type_code		text
	,in_area_map_code		text
	,flow_mw				text
	,update_time_utc		text
);

create table staging.prices (
	datetime_utc		text
	,price_eur_mwh		text
	,bidding_zone		text
	,area_code			text
);
