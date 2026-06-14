# ETL and Data Model: Norway's Energy Transition Dashboard

## Project Goal

This project turns public electricity data into a clean analytical model for a Power BI dashboard about Norway's energy transition. The dashboard explores how Norway produces, consumes, stores, trades, and prices electricity across time.

The analytical report shows the findings. This ETL report shows the engineering work behind those findings: how the data was extracted, validated, transformed, and prepared for analysis.

## What This Pipeline Does

The pipeline combines Python, SQL, and Power BI:

1. Extract public electricity data from ENTSO-E.
2. Save the raw source data as CSV files.
3. Load raw files into SQL staging tables.
4. Inspect row counts, area codes, and timestamp formats.
5. Transform raw text fields into typed analytical tables.
6. Convert MW values into MWh where time-based aggregation is needed.
7. Add dimensions for geography and calendar analysis.
8. Connect the curated model to Power BI.

## Data Sources

| Dataset | Granularity | Analytical Use |
|---|---:|---|
| Actual total load | Hourly/sub-hourly | Electricity demand and consumption patterns |
| Generation by production type | Hourly/sub-hourly | Energy mix and renewable generation profile |
| Reservoir levels | Weekly | Hydro storage and seasonal flexibility |
| Physical cross-border flows | Hourly/sub-hourly | Imports, exports, and Norway's grid role |
| Day-ahead prices | Hourly | Bidding-zone price comparison |

Raw data volumes checked during inspection:

| Staging Table | Rows |
|---|---:|
| `staging.load` | 752,429 |
| `staging.flows` | 6,155,624 |
| `staging.generation` | 4,495,647 |
| `staging.reservoirs` | 3,522 |
| `staging.prices` | 517,720 |

## Architecture

The project follows a raw-to-curated data pipeline.

```mermaid
flowchart LR
    A[ENTSO-E Public Data] --> B[Python Extraction]
    B --> C[Raw CSV Files]
    C --> D[SQL Staging Tables]
    D --> E[Data Quality Checks]
    E --> F[SQL Core Tables]
    F --> G[Analytical Dimensions and Measures]
    G --> H[Power BI Dashboard]
```

## 1. Python Extraction

The extraction layer uses Python to pull data from ENTSO-E. The notebook is configuration-driven: bidding zones, file-library folders, output filenames, request windows, and download pacing are defined once and reused.

This matters because the project is reproducible. The dashboard is not based on manual spreadsheet downloads.

### Code Example: Extraction Configuration

```python
import pandas as pd
from entsoe import EntsoePandasClient
from entsoe.files import EntsoeFileClient

BIDDING_ZONES = {
    "NO1": "10YNO-1--------2",      # Oslo / southeast
    "NO2": "10YNO-2--------T",      # Southwest
    "NO3": "10YNO-3--------J",      # Central
    "NO4": "10YNO-4--------9",      # North
    "NO5": "10Y1001A1001A48H",      # Bergen / west
}

FILE_FOLDERS = {
    "load": "ActualTotalLoad_6.1.A_r3",
    "generation": "AggregatedGenerationPerType_16.1.B_C_r3",
    "reservoirs": "AggregatedFillingRateOfWaterReservoirsAndHydroStoragePlants_16.1.D_r3",
    "flows": "PhysicalFlows_12.1.G_r3",
}

OUTPUT_FILES = {
    "load": "NO_actual_load.csv",
    "generation": "NO_generation.csv",
    "reservoirs": "NO_reservoirs.csv",
    "flows": "NO_cross_border_flows.csv",
    "prices": "NO_day_ahead_prices.csv",
}

PRICE_START = pd.Timestamp("2014-01-01", tz="UTC")
PRICE_END = pd.Timestamp("2026-01-01", tz="UTC")
BATCH_SIZE = 20
DELAY = 1.0
```

For the public GitHub version, credentials should be read from environment variables:

```python
import os

API_KEY = os.getenv("ENTSOE_API_KEY")
USERNAME = os.getenv("ENTSOE_USERNAME")
PASSWORD = os.getenv("ENTSOE_PASSWORD")
```

## 2. Raw Landing In SQL

The staging schema stores incoming CSV columns as text. This is intentional. Raw landing tables should preserve source values before casting, cleaning, and modelling.

This makes source issues easier to diagnose. If a timestamp, numeric value, or area code arrives in an unexpected format, it can be inspected in staging before it affects the analytical model.

### Code Example: Staging Tables

```sql
create table staging.load (
    datetime_utc        text,
    resolution_code     text,
    area_code           text,
    area_display_name   text,
    area_type_code      text,
    area_map_code       text,
    total_load_mw       text,
    update_time_utc     text
);

create table staging.generation (
    datetime_utc        text,
    resolution_code     text,
    area_code           text,
    area_display_name   text,
    area_type_code      text,
    area_map_code       text,
    production_type     text,
    generation_mw       text,
    consumption_mw      text,
    update_time_utc     text
);

create table staging.flows (
    datetime_utc            text,
    resolution_code         text,
    out_area_code           text,
    out_area_display_name   text,
    out_area_type_code      text,
    out_area_map_code       text,
    in_area_code            text,
    in_area_display_name    text,
    in_area_type_code       text,
    in_area_map_code        text,
    flow_mw                 text,
    update_time_utc         text
);
```

## 3. Data Quality Checks

Before the data is promoted into the core schema, I run simple validation checks:

- row counts for each table
- distinct area and bidding-zone codes
- timestamp format checks
- coverage checks across load, generation, reservoirs, flows, and prices

These checks are small but important. They show whether the pipeline loaded the expected data before transformation begins.

### Code Example: Inspection Queries

```sql
-- Row counts
select count(*) from staging.load;        -- 752,429
select count(*) from staging.flows;       -- 6,155,624
select count(*) from staging.generation;  -- 4,495,647
select count(*) from staging.reservoirs;  -- 3,522
select count(*) from staging.prices;      -- 517,720

-- Area coverage
select distinct area_map_code
from staging.load
order by 1;

select distinct out_area_map_code
from staging.flows
order by 1;

select distinct in_area_map_code
from staging.flows
order by 1;

-- Timestamp format check
select datetime_utc
from staging.prices
limit 5;
```

## 4. Core Analytical Tables

The core schema is the cleaned analytical layer used by Power BI. Here, source values are converted into proper data types and model-friendly fields.

Core tables:

| Table | Purpose |
|---|---|
| `core.load` | Electricity demand/load |
| `core.generation` | Production by generation type |
| `core.reservoirs` | Hydro storage |
| `core.flows` | Cross-border electricity flows |
| `core.prices` | Day-ahead prices by bidding zone |
| `core.dim_areas` | Area and geography metadata |

### Code Example: Typed Core Tables

```sql
create table core.load (
    datetime_utc        timestamp,
    date                date,
    time                time,
    resolution_code     text,
    area_code           text,
    area_display_name   text,
    area_type_code      text,
    area_map_code       text,
    total_load_mw       numeric(12,2),
    update_time_utc     timestamp
);

create table core.generation (
    datetime_utc        timestamp,
    date                date,
    time                time,
    resolution_code     text,
    area_code           text,
    area_display_name   text,
    area_type_code      text,
    area_map_code       text,
    production_type     text,
    generation_mw       numeric(12,2),
    consumption_mw      numeric(12,2),
    update_time_utc     timestamp
);
```

## 5. Staging To Core Transformation

The transformation step casts raw text into useful analytical types, creates date/time fields, and handles incomplete source values.

### Code Example: Generation And Price Transformations

```sql
insert into core.generation
select
    datetime_utc::timestamp,
    datetime_utc::date as date,
    datetime_utc::time as time,
    resolution_code,
    area_code,
    area_display_name,
    area_type_code,
    area_map_code,
    production_type,
    coalesce(nullif(generation_mw, ''), '0')::numeric(12,2),
    coalesce(nullif(consumption_mw, ''), '0')::numeric(12,2),
    update_time_utc::timestamp
from staging.generation;

insert into core.prices
select
    datetime_utc::timestamp,
    datetime_utc::date as date,
    datetime_utc::time as time,
    nullif(price_eur_mwh, '')::numeric(12,2),
    bidding_zone,
    area_code
from staging.prices;
```

## 6. Reservoir Week-To-Date Logic

Reservoir data arrives as year and week values. For Power BI time intelligence, the data needs a real date field that can join to the calendar dimension.

### Code Example: ISO Week Date Conversion

```sql
insert into core.reservoirs
select
    (to_date("year" || '-' || week, 'IYYY-IW') + interval '6 days')::date as date,
    "year"::numeric(12,2),
    "month"::numeric(12,2),
    week::numeric(12,2),
    timezone,
    resolution_code,
    area_code,
    area_display_name,
    area_type_code,
    area_map_code,
    stored_energy_mwh::numeric(12,2),
    update_time_utc::timestamp
from staging.reservoirs;
```

## 7. MW To MWh Conversion

Several ENTSO-E measures arrive as MW, which is a power value. For totals over time, the dashboard needs MWh, which is an energy value.

The conversion depends on the time resolution:

| Resolution | Multiplier |
|---|---:|
| `PT60M` | 1.00 |
| `PT30M` | 0.50 |
| `PT15M` | 0.25 |

This prevents misleading aggregation. Summing MW directly over time would not represent total energy.

### Code Example: Resolution-Aware Energy Conversion

```sql
alter table core.load
add column total_load_mwh numeric(12,2);

update core.load
set total_load_mwh = total_load_mw *
    case resolution_code
        when 'PT60M' then 1.0
        when 'PT30M' then 0.5
        when 'PT15M' then 0.25
        else 1.0
    end;

alter table core.generation
add column actual_generation_mwh numeric(12,2);

update core.generation
set actual_generation_mwh = generation_mw *
    case resolution_code
        when 'PT60M' then 1.0
        when 'PT30M' then 0.5
        when 'PT15M' then 0.25
        else 1.0
    end;

alter table core.flows
add column flow_mwh numeric(12,2);

update core.flows
set flow_mwh = flow_mw *
    case resolution_code
        when 'PT60M' then 1.0
        when 'PT30M' then 0.5
        when 'PT15M' then 0.25
        else 1.0
    end;
```

## 8. Area Dimension

The area dimension adds human-readable labels and geography to the energy data. It supports map visuals, bidding-zone filtering, country filtering, and cleaner report labels.

### Code Example: Area Dimension

```sql
create table core.dim_areas (
    area_map_code      text primary key,
    area_display_name  text,
    area_type          text,
    country            text,
    region             text,
    tso                text,
    is_norway          boolean,
    latitude           numeric(7,4),
    longitude          numeric(7,4)
);

insert into core.dim_areas values
('NO',  'Norway',         'Country',      'Norway', 'National',  'Statnett', true, 64.5731, 17.8880),
('NO1', 'Norway SE',      'Bidding Zone', 'Norway', 'Southeast', 'Statnett', true, 59.9139, 10.7522),
('NO2', 'Norway SW',      'Bidding Zone', 'Norway', 'Southwest', 'Statnett', true, 58.9700,  5.7331),
('NO3', 'Norway Central', 'Bidding Zone', 'Norway', 'Central',   'Statnett', true, 63.4305, 10.3951),
('NO4', 'Norway North',   'Bidding Zone', 'Norway', 'North',     'Statnett', true, 68.4385, 17.4279),
('NO5', 'Norway West',    'Bidding Zone', 'Norway', 'West',      'Statnett', true, 60.3913,  5.3221);
```


## Power BI Readiness

The final model is Power BI-ready because it exposes:

- typed fact tables for load, generation, reservoirs, flows, and prices
- date and time fields for time-series analysis
- MWh measures for correct energy aggregation
- area metadata for maps and bidding-zone filters
- calendar fields for sorting, grouping, and time intelligence
- a clean split between raw staging and curated analytical tables


## Portfolio Summary

The dashboard tells the analytical story of Norway's energy transition. The ETL pipeline shows how that story was made reliable.

By separating raw staging from typed core tables, validating the data before modelling it, and converting power values into energy values correctly, this project demonstrates more than dashboard design. It shows the practical data engineering work needed to turn public energy data into a trustworthy analytical product.
