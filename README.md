# Norge Energi: Norway's Energy Transition Dashboard

A Power BI and data engineering portfolio project analysing Norway's electricity system using public ENTSO-E data.

The project combines Python extraction, SQL modelling, Power BI dashboarding, and analytical storytelling around hydropower, demand, reservoirs, cross-border flows, wind growth, and electricity prices.

## Project Preview

![Dashboard preview](assets/dashboard/Pbix%20-%20Norge%20Energi%201.png)

## Repository Structure

```text
reports/findings/      Complete analytical findings report
reports/etl/           ETL report with code and data dictionary
assets/findings/       Images used in the findings report
assets/dashboard/      Power BI dashboard screenshots
assets/architecture/   Pipeline architecture diagram
notebooks/             Sanitized extraction notebook
sql/                   Ordered SQL scripts for schema and transformations
data/                  Data instructions and optional samples
```

## Main Reports

- [Final findings](reports/findings/Final_Findings.md)
- [ETL report with code](reports/etl/ETL_Report.md)
- [Data dictionary](reports/etl/Data_Dictionary.md)

## Data Sources

The project uses public electricity data from ENTSO-E, including:

- actual total load
- generation by production type
- reservoir storage levels
- physical cross-border flows
- day-ahead prices

## Reproducing The ETL Pipeline

### 1. Configure Credentials

Create a local `.env` file based on `.env.example`:

```bash
ENTSOE_API_KEY=your_entsoe_api_key_here
ENTSOE_USERNAME=your_entsoe_file_library_username_here
ENTSOE_PASSWORD=your_entsoe_file_library_password_here
```

Never commit `.env` or real credentials.

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

### 3. Extract Raw Data

Run:

```text
notebooks/01_entsoe_extraction.ipynb
```

Expected generated files:

```text
NO_actual_load.csv
NO_generation.csv
NO_reservoirs.csv
NO_cross_border_flows.csv
NO_day_ahead_prices.csv
```

The raw CSV files are intentionally not committed because they are large.

### 4. Build SQL Schemas

Run the SQL scripts in order:

```text
sql/00_schema_creation.sql
sql/01_staging_tables_creation.sql
sql/02_core_tables_creation.sql
```

### 5. Load CSV Files Into Staging

Import each generated CSV into its matching staging table:

| CSV File | Staging Table |
|---|---|
| `NO_actual_load.csv` | `staging.load` |
| `NO_generation.csv` | `staging.generation` |
| `NO_reservoirs.csv` | `staging.reservoirs` |
| `NO_cross_border_flows.csv` | `staging.flows` |
| `NO_day_ahead_prices.csv` | `staging.prices` |

### 6. Inspect And Transform

Run:

```text
sql/03_data_inspection.sql
sql/04_staging_into_core.sql
sql/05_mw_to_mwh.sql
sql/06_dim_areas.sql
```


## Engineering Highlights

- Python extraction from ENTSO-E API and File Library
- SQL staging and typed core schemas
- validation checks before transformation
- timestamp normalization and null handling
- MW-to-MWh conversion based on time resolution
- area and calendar dimensions for Power BI
- multi-million-row energy datasets

## Security Note

The public notebooks use environment-variable placeholders. Real API keys, usernames, passwords, `.env` files, and raw CSV exports should not be committed.
