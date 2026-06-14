# Norway's Energy Transition (2015-2025)

**A data-driven analysis of hydropower, market dynamics, and Europe's green battery**

**Author:** Miguel Bernardo  
**Tools used:** Power BI, SQL, ENTSO-E Transparency Platform, Statnett Open Data

## Executive Summary

Norway has one of the world's most distinctive electricity systems. While many European countries rely on a mix of fossil fuels, nuclear power, and renewables, Norway's electricity generation is dominated by hydropower. Between 2015 and 2025, hydropower consistently supplied most of the country's electricity, while wind power gradually became a more visible contributor to the generation mix.

This project analyses Norway's electricity system between 2015 and 2025 using public electricity market and generation data. The analysis explores generation technologies, reservoir behaviour, electricity demand, price dynamics, cross-border flows, and the growing role of wind power.

Several findings stand out. Norway's electricity system behaves like a seasonal storage machine: reservoirs fill during spring and summer and are drawn down during winter, when electricity demand is highest. The 2021 drought exposed the vulnerability of a system that depends heavily on reservoir hydropower. The European energy crisis of 2021-2022 then showed how strongly Southern Norway had become exposed to wider European electricity-market conditions.

The analysis also reveals a growing regional divide between Northern and Southern Norway, driven by transmission constraints and increased market integration. At the same time, wind power and international interconnectors are strengthening Norway's role as a flexible provider of renewable electricity to Europe.

Norway's energy transition is therefore not mainly about replacing fossil-fuel generation. It is about expanding, balancing, and optimising an electricity system that is already highly renewable, while supporting the wider European energy transition.

## 1. Introduction

Norway's electricity sector is one of the cleanest and most renewable power systems in the world. Thanks to its geography, mountainous terrain, and abundant precipitation, hydropower has historically formed the backbone of national electricity generation.

The country's large reservoir network provides a rare ability to store energy over seasonal timescales. In practice, Norway stores potential energy in water rather than relying primarily on fuel stocks or chemical batteries. This capability allows Norway to meet domestic demand, manage seasonal variation, and export renewable electricity to neighbouring markets through interconnectors.

The objective of this project is to investigate how Norway's electricity system evolved between 2015 and 2025 and to identify the major trends, disruptions, and structural changes that shaped the market during this period.

The analysis focuses on four research questions:

- How does Norway's hydropower-based electricity system operate throughout the year?
- What impact did the 2021 drought and 2022 energy crisis have on the Norwegian electricity market?
- How is wind power changing the generation mix?
- What role does Norway play in supporting the wider European energy transition?

## 2. Data and Methodology

The analysis was developed using electricity data obtained from ENTSO-E and Statnett.

The datasets include:

- Electricity generation by technology
- Electricity load
- Reservoir storage levels
- Electricity market prices
- Cross-border electricity flows
- Bidding zone information for NO1-NO5

Data preparation and transformation were performed using SQL and Power BI. The final dashboard integrates more than ten years of market data and enables interactive exploration of trends at national and regional levels.

## 3. Norway's Electricity System

### Hydropower Dominance

The analysis confirms the overwhelming dominance of hydropower within Norway's electricity mix.

In 2015, hydropower accounted for approximately 96% of electricity generation. By 2025, this share had declined slightly to around 90%, largely due to the growth of onshore wind generation. Despite this diversification, hydropower remains the foundation of Norway's electricity system.

![Generation Mix Evolution](../../assets/findings/Norge%20Energi%20-%20Image%201.png)

### Reservoirs as Seasonal Energy Storage

Unlike most electricity systems, Norway stores a large share of its energy in the form of water. The country's reservoir network can hold between approximately 63 TWh in dry years and more than 83 TWh in wet years. This storage capacity is equivalent to roughly half of Norway's annual electricity consumption.

This gives Norway an unusual level of seasonal flexibility. Electricity generated from rainfall and snowmelt can be stored for months before being released during periods of higher demand. Reservoirs therefore provide both flexibility and energy security, allowing Norway to balance seasonal fluctuations in supply and demand while supporting exports to neighbouring countries.

![Reservoir Storage Capacity](../../assets/findings/Norge%20Energi%20-%20Image%202.png)

### Norway as a Net Exporter

Norway consistently exports more electricity than it imports. Although annual exports vary according to hydrological conditions and market prices, the country remains a net exporter in almost every year of the study period.

The main exception was 2019, when Norway became a net importer by approximately 150 GWh.

![Net Imports and Exports](../../assets/findings/Norge%20Energi%20-%20Image%203.png)

## 4. The Seasonal Machine

One of the clearest findings is the predictable seasonal behaviour of the Norwegian electricity system.

### Daily Demand Patterns

Electricity consumption follows a clear daily rhythm. Demand increases rapidly during the early morning as households and businesses begin daily activity, reaches its highest levels during working hours, and then declines through the evening before reaching its lowest levels overnight.

This pattern reflects the influence of commercial and industrial activity on the electricity system. Residential demand remains important throughout the day, but daytime consumption is strongly shaped by workplaces, services, and industrial activity.

![Average Hourly Load Profile](../../assets/findings/Norge%20Energi%20-%20Image%204.png)

### Weekly Demand Patterns

The same relationship appears at the weekly scale. Electricity demand remains consistently higher from Monday to Friday, corresponding to normal industrial and commercial activity. During weekends, consumption declines as factories, offices, and many businesses reduce operations.

This distinction between weekdays and weekends highlights the contribution of economic activity to total electricity demand.

![Average Load by Day of Week](../../assets/findings/Norge%20Energi%20-%20Image%205.png)

### The Seasonal Battery

Norway's most distinctive electricity-system feature is its ability to store energy across seasons through hydropower reservoirs. During spring and summer, rising temperatures and snowmelt from mountainous regions generate large inflows into reservoirs. At the same time, electricity demand falls as heating requirements decrease, allowing reservoirs to refill. Storage levels typically reach their annual maximum between August and September.

As autumn transitions into winter, the cycle reverses. Reservoir inflows decline while electricity demand rises sharply. Norway's widespread use of electric heating makes consumption highly sensitive to temperature, causing demand to nearly double between the summer trough and winter peak.

To meet this increased demand, hydropower operators progressively release water stored during the warmer months. Reservoir levels decline throughout winter and reach their lowest point shortly before the spring snowmelt begins the cycle again.

![Seasonal Load Pattern](../../assets/findings/Norge%20Energi%20-%20Image%206.png)

![Seasonal Reservoir Filling Levels Pattern](../../assets/findings/Norge%20Energi%20-%20Image%207.png)

### Seasonal Electricity Prices

Before 2021, electricity prices followed a relatively stable seasonal pattern. Prices tended to be lowest during spring and summer, when reservoirs were being replenished, and highest during winter, when demand increased.

![Monthly Price Patterns Before 2020](../../assets/findings/Norge%20Energi%20-%20Image%208.png)

After 2021, this historical seasonal pattern became much less stable. A growing divergence emerged between Southern Norway and the Central and Northern regions. This shift was driven by a combination of the 2021 drought, increased integration with European electricity markets through new interconnectors, transmission bottlenecks within Norway, and the broader European energy crisis.

As a result, electricity prices became increasingly influenced by external market conditions rather than only by domestic hydrology and seasonal demand.

![Monthly Price Patterns After 2020](../../assets/findings/Norge%20Energi%20-%20Image%209.png)

### Long-Term Demand Trends

Over the last decade, total electricity consumption remained relatively stable but showed a modest upward trend. Annual demand increased by approximately 5 TWh between 2015 and 2025.

Although modest compared with seasonal variation, this trend suggests that electricity demand is gradually increasing despite efficiency improvements. The increase is consistent with Norway's broader electrification pathway, including electric vehicles and the continued electrification of residential heating.

![Annual Electricity Demand](../../assets/findings/Norge%20Energi%20-%20Image%2010.png)

### Key Insight

Norway's electricity demand is shaped by repeating cycles at different timescales. At the daily level, consumption rises during working hours and falls overnight. At the weekly level, demand is stronger from Monday to Friday and lower during weekends. The largest variation is seasonal: monthly electricity demand rises from summer lows of around 8.5 TWh to winter peaks around 15 TWh, mainly because heating is heavily electrified.

Hydropower reservoirs respond to this rhythm by storing water during the lower-demand spring and summer months and releasing it during winter, when consumption is highest. This interaction between demand cycles and reservoir operation is what makes Norway's power system behave like a natural seasonal battery.

## 5. The 2021 Drought

The year 2021 was one of the most important stress tests of Norway's electricity system during the study period.

### Record Low Reservoir Levels

After exceptionally high storage levels in 2020, Norway experienced a particularly dry year in 2021. Reservoir inflows remained below normal for much of the year, resulting in low storage levels during autumn and winter.

![Reservoir Levels 2021 vs Historical Average](../../assets/findings/Norge%20Energi%20-%20Image%2011.png)

### Multi-Year Impact

The consequences of the drought extended beyond a single year. Reservoir filling rates remained below historical norms until approximately 2023, demonstrating the long-term impact that hydrological variability can have on electricity markets.

![Reservoir Recovery Trends](../../assets/findings/Norge%20Energi%20-%20Image%2012.png)

The prolonged period of lower reservoir levels between 2021 and 2023 may have been influenced by both reduced hydrological inflows and sustained incentives to generate and export electricity during a period of exceptionally high European electricity prices.

### Rising Market Tensions

Although electricity production remained relatively stable, lower reservoir levels increased concerns around long-term supply security and contributed to upward pressure on electricity prices. The drought showed that a renewable electricity system can still be exposed to natural-resource risk when it depends heavily on hydrology.

## 6. The European Energy Crisis

The European energy crisis of 2021-2022 transformed the Norwegian electricity market.

### Regional Price Divergence

Historically, electricity prices across Norway's five bidding zones moved more closely together. Beginning in late 2021, prices in Southern Norway separated dramatically from those in Central and Northern Norway.

Norwegian energy prices began surging in 2021 due to a combination of post-pandemic demand growth, unusually low domestic hydropower reservoir levels, and new high-capacity subsea cables that connected Southern Norway more directly to higher-priced continental and UK electricity markets.

![Prices by Bidding Zone](../../assets/findings/Norge%20Energi%20-%20Image%2013.png)

### Record Price Differences

On 30 August 2022, electricity prices in Southern Norway reached 660 EUR/MWh while Northern Norway experienced prices of just 11 EUR/MWh. Despite belonging to the same national electricity market, consumers in the two regions faced a price difference of nearly 60 times.

This was one of the clearest examples in the analysis of how transmission constraints and international market exposure can create sharply different outcomes within the same country.

![Price Spread North vs South](../../assets/findings/Norge%20Energi%20-%20Image%2014.png)

### European Market Integration

The crisis demonstrated how strongly Southern Norway had become linked to European electricity markets through international interconnectors. Despite generating almost entirely renewable electricity, Norwegian prices became increasingly influenced by wider European market conditions.

## 7. The Rise of Wind Power

Norway's electricity mix remains hydro-dominated, but wind power has become an increasingly important contributor.

### Growth of Wind Generation

Wind generation increased from approximately 2% of total electricity generation in 2015 to around 9% after 2022. This growth did not replace hydropower as the foundation of the system, but it added a meaningful second renewable source to the national generation mix.

![Wind Growth Over Time](../../assets/findings/Norge%20Energi%20-%20Image%2015.png)

### Seasonal Complementarity

Wind generation peaks during autumn and winter. This complements hydropower generation by reducing the need to release water from reservoirs during periods of high electricity demand.

![Wind Generation Seasonality](../../assets/findings/Norge%20Energi%20-%20Image%2016.png)

The relationship between wind and hydropower is one of the most important renewable-energy combinations in the Norwegian system: wind contributes more during the months when demand is high, while reservoirs provide dispatchable flexibility.

## 8. Norway as Europe's Green Battery

Norway's interconnector network expanded significantly during the study period.

### NordLink and North Sea Link

The expansion of Norway's interconnector network changed the country's role in the European electricity market. Historically, Norway's cross-border electricity trade was concentrated around neighbouring Nordic markets, particularly Sweden and Denmark. The commissioning of NordLink to Germany and the North Sea Link to the United Kingdom in 2021 created new direct routes between Norway's flexible hydropower system and two large, higher-priced European electricity markets.

NordLink connects Southern Norway with Germany, allowing Norwegian hydropower to support the German grid during periods of high demand or low renewable output. In the opposite direction, the cable can also allow Norway to import electricity when continental renewable generation is abundant, preserving water in reservoirs.

The North Sea Link performs a similar role between Norway and the United Kingdom. By linking Norwegian hydropower with the British electricity system, it provides an additional source of flexible renewable power and strengthens market integration across the North Sea.

The impact of these connections is visible in the cross-border flow evolution. Norway's role as a green battery is no longer limited to the Nordic region; it is increasingly connected to the wider European power system.

![Cross-Border Flow Evolution](../../assets/findings/Norge%20Energi%20-%20Image%2017.png)

### Supporting European Decarbonisation

By exporting flexible renewable electricity, Norway helps balance fluctuations in renewable generation across Europe. This role is likely to become increasingly important as neighbouring countries continue expanding wind and solar generation.

## 9. Conclusions

This analysis shows that Norway has one of the world's most distinctive and strategically important electricity systems.

Five conclusions emerge from the data:

1. Hydropower remains the backbone of Norwegian electricity generation, consistently supplying the majority of total production.
2. Reservoir storage functions as a seasonal battery, allowing Norway to balance supply and demand across the year.
3. The 2021 drought and 2022 energy crisis revealed vulnerabilities linked to hydrological dependence and growing market integration.
4. Wind power has become an increasingly important complement to hydropower, particularly during autumn and winter.
5. Through expanding interconnector capacity, Norway is strengthening its position as Europe's green battery and supporting the broader energy transition.

Norway's transition is therefore different from the transition underway in many other European countries. The main challenge is not replacing fossil-fuel generation with renewables, but managing a highly renewable electricity system under changing conditions: rising demand, hydrological variability, regional transmission constraints, price volatility, and deeper integration with Europe.

The project demonstrates how public electricity-market data can be transformed into an analytical model, explored through Power BI, and interpreted through an energy-system lens to explain real market behaviour.


