These data were extracted from the table on https://en.wikipedia.org/wiki/List_of_municipalities_in_California.

```
source("ca_cities_data.R")
d <- fetchDataFromStateTable("https://en.wikipedia.org/wiki/List_of_municipalities_in_California")
write.csv(
  d[c("city_name", "type", "county", "pop_2020", "pop_2010", "area_mi2", "county_seat", "incorporation_date")],
  file="ca_cities.csv", row.names=FALSE)
```
