## ca_cities.csv

These data were extracted from the table on https://en.wikipedia.org/wiki/List_of_municipalities_in_California.

```
source("ca_cities_data.R")
d <- fetchDataFromStateTable("https://en.wikipedia.org/wiki/List_of_municipalities_in_California")
write.csv(
  d[c("city_name", "type", "county", "pop_2020", "pop_2010", "area_mi2", "county_seat", "incorporation_date")],
  file="ca_cities.csv", row.names=FALSE)
```

## ca_cities_wiki_names.gpkg

Original data downloaded from https://gis.data.ca.gov/datasets/CDTFA::city-and-county-boundary-line-changes/explore?layer=0&location=33.924386%2C-118.008294%2C11.67

```
source("~/projects/ca_cities_data/ca_city_boundaries_from_cdtfa.R", chdir=TRUE)
cities <- extractCitiesFromCtdfa(read_sf("~/Downloads/City_and_County_Boundary_Line_Changes_217120214122415134.gpkg"))
write_sf(cities, "~/projects/ca_cities_data/ca_cities_wiki_names.gpkg")
```


