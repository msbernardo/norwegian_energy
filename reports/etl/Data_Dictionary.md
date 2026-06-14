# Data Dictionary - Core Tables

This data dictionary describes the curated analytical tables used by the Power BI report.

## `core.load`

Electricity demand/load table.

| Column | Type | Description |
|---|---|---|
| `datetime_utc` | timestamp | Source timestamp in UTC for the load observation. |
| `date` | date | Date extracted from `datetime_utc`, used for calendar joins and date filtering. |
| `time` | time | Time extracted from `datetime_utc`, used for intraday analysis. |
| `resolution_code` | text | Time resolution of the observation, such as `PT60M`, `PT30M`, or `PT15M`. |
| `area_code` | text | ENTSO-E EIC area code. |
| `area_display_name` | text | Human-readable area name from the source data. |
| `area_type_code` | text | ENTSO-E area type classification. |
| `area_map_code` | text | Short area or country code used for mapping and joins. |
| `total_load_mw` | numeric(12,2) | Electricity load in MW. |
| `update_time_utc` | timestamp | Source update timestamp in UTC. |
| `total_load_mwh` | numeric(12,2) | Derived energy demand in MWh, calculated from `total_load_mw` and `resolution_code`. |

## `core.generation`

Electricity generation table by production type.

| Column | Type | Description |
|---|---|---|
| `datetime_utc` | timestamp | Source timestamp in UTC for the generation observation. |
| `date` | date | Date extracted from `datetime_utc`, used for calendar joins and date filtering. |
| `time` | time | Time extracted from `datetime_utc`, used for intraday analysis. |
| `resolution_code` | text | Time resolution of the observation, such as `PT60M`, `PT30M`, or `PT15M`. |
| `area_code` | text | ENTSO-E EIC area code. |
| `area_display_name` | text | Human-readable area name from the source data. |
| `area_type_code` | text | ENTSO-E area type classification. |
| `area_map_code` | text | Short area or country code used for mapping and joins. |
| `production_type` | text | Generation technology or fuel category, such as hydro, wind, fossil gas, or other source categories. |
| `generation_mw` | numeric(12,2) | Actual generation output in MW. |
| `consumption_mw` | numeric(12,2) | Actual consumption related to the generation category, when provided by the source. Blank source values are handled during transformation. |
| `update_time_utc` | timestamp | Source update timestamp in UTC. |
| `actual_generation_mwh` | numeric(12,2) | Derived generated energy in MWh, calculated from `generation_mw` and `resolution_code`. |
| `actual_consumption_mwh` | numeric(12,2) | Derived consumed energy in MWh, calculated from `consumption_mw` and `resolution_code`. |

## `core.reservoirs`

Hydro reservoir storage table.

| Column | Type | Description |
|---|---|---|
| `date` | date | Derived date for the weekly reservoir record, calculated from source year/week values using ISO week logic. |
| `year` | numeric(12,2) | Source year value. |
| `month` | numeric(12,2) | Source month value. |
| `week` | numeric(12,2) | Source week value. |
| `timezone` | text | Source timezone label, such as CET. |
| `resolution_code` | text | Time resolution of the reservoir record, typically weekly. |
| `area_code` | text | ENTSO-E EIC area code. |
| `area_display_name` | text | Human-readable area name from the source data. |
| `area_type_code` | text | ENTSO-E area type classification. |
| `area_map_code` | text | Short area or country code used for mapping and joins. |
| `stored_energy_mwh` | numeric(12,2) | Stored hydro energy in MWh. |
| `update_time_utc` | timestamp | Source update timestamp in UTC. |

## `core.flows`

Physical cross-border electricity flows table.

| Column | Type | Description |
|---|---|---|
| `datetime_utc` | timestamp | Source timestamp in UTC for the flow observation. |
| `date` | date | Date extracted from `datetime_utc`, used for calendar joins and date filtering. |
| `time` | time | Time extracted from `datetime_utc`, used for intraday analysis. |
| `resolution_code` | text | Time resolution of the observation, such as `PT60M`, `PT30M`, or `PT15M`. |
| `out_area_code` | text | ENTSO-E EIC code for the exporting/outgoing area. |
| `out_area_display_name` | text | Human-readable name for the exporting/outgoing area. |
| `out_area_type_code` | text | ENTSO-E area type for the exporting/outgoing area. |
| `out_area_map_code` | text | Short map code for the exporting/outgoing area. |
| `in_area_code` | text | ENTSO-E EIC code for the importing/incoming area. |
| `in_area_display_name` | text | Human-readable name for the importing/incoming area. |
| `in_area_type_code` | text | ENTSO-E area type for the importing/incoming area. |
| `in_area_map_code` | text | Short map code for the importing/incoming area. |
| `flow_mw` | numeric(12,2) | Physical electricity flow in MW. |
| `update_time_utc` | timestamp | Source update timestamp in UTC. |
| `flow_mwh` | numeric(12,2) | Derived energy flow in MWh, calculated from `flow_mw` and `resolution_code`. |

## `core.prices`

Day-ahead electricity price table.

| Column | Type | Description |
|---|---|---|
| `datetime_utc` | timestamp | Source timestamp for the day-ahead price observation. |
| `date` | date | Date extracted from `datetime_utc`, used for calendar joins and date filtering. |
| `time` | time | Time extracted from `datetime_utc`, used for intraday analysis. |
| `price_eur_mwh` | numeric(12,2) | Day-ahead electricity price in EUR/MWh. |
| `bidding_zone` | text | Norwegian bidding zone, such as NO1, NO2, NO3, NO4, or NO5. |
| `area_code` | text | ENTSO-E EIC area code for the bidding zone. |

## `core.dim_areas`

Area dimension used for geographic labels, joins, and filtering.

| Column | Type | Description |
|---|---|---|
| `area_map_code` | text | Primary key. Short area, country, or bidding-zone code used for joins and mapping. |
| `area_display_name` | text | Human-readable area name. |
| `area_type` | text | Area category, such as `Country`, `Bidding Zone`, or `Neighbour`. |
| `country` | text | Country associated with the area. |
| `region` | text | Geographic region, especially useful for Norwegian bidding zones. |
| `tso` | text | Transmission System Operator associated with the area. |
| `is_norway` | boolean | Indicates whether the area is in Norway. |
| `latitude` | numeric(7,4) | Latitude used for map visuals. |
| `longitude` | numeric(7,4) | Longitude used for map visuals. |

## Suggested Relationships In Power BI

| From | To | Relationship Purpose |
|---|---|---|
| `core.load.date` | calendar date | Date filtering for load analysis. |
| `core.generation.date` | calendar date | Date filtering for generation analysis. |
| `core.reservoirs.date` | calendar date | Date filtering for reservoir analysis. |
| `core.flows.date` | calendar date | Date filtering for cross-border flow analysis. |
| `core.prices.date` | calendar date | Date filtering for price analysis. |
| `core.load.area_map_code` | `core.dim_areas.area_map_code` | Area metadata for load. |
| `core.generation.area_map_code` | `core.dim_areas.area_map_code` | Area metadata for generation. |
| `core.reservoirs.area_map_code` | `core.dim_areas.area_map_code` | Area metadata for reservoirs. |
| `core.flows.out_area_map_code` | `core.dim_areas.area_map_code` | Metadata for exporting areas. |
| `core.flows.in_area_map_code` | `core.dim_areas.area_map_code` | Metadata for importing areas. |
| `core.prices.bidding_zone` | `core.dim_areas.area_map_code` | Bidding-zone metadata for prices. |

## Notes

- MW measures describe power at a point or interval.
- MWh measures describe energy over the interval and should be used for totals over time.
- `resolution_code` is essential when converting MW to MWh.
- The staging layer intentionally stores raw source values as text; the core layer is the cleaned analytical model.
