# Data Folder

Raw ENTSO-E CSV exports are not committed to this repository because several files are large.

Recreate them by running:

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
dim_calendar.xlsx
```

Small sample files can be added under `data/sample/` if needed for demonstration.
