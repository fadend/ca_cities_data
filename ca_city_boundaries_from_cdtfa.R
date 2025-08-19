# Extract California city boundaries from data provided by CDTFA,
# e.g., as at https://gis.data.ca.gov/datasets/CDTFA::city-and-county-boundary-line-changes/explore?layer=0&location=33.924386%2C-118.008294%2C11.67.
# Normalizes the city names to match those as on Wikipedia.
# Combines (unions) geometries split across multiple rows to have one
# row per city.
#
# Example usage:
# > source("~/projects/ca_cities_data/ca_city_boundaries_from_cdtfa.R", chdir=TRUE)
# > cities <- extractCitiesFromCtdfa(read_sf("~/Downloads/City_and_County_Boundary_Line_Changes_217120214122415134.gpkg"))
# > write_sf(cities, "~/projects/ca_cities_data/ca_cities_wiki_names.gpkg")

library(dplyr)
library(sf)

# TODO: check this in or replace with equivalent package function.
replaceStrings <- function(x, mapping) {
  replacement <- mapping[x]
  x[!is.na(names(replacement))] <- unlist(mapping, use.names=FALSE)
  return(x)
}

# Mapping from the city names used by CDTFA to those used in Wikipedia,
# which also seem to be those used by Google Maps, etc.
CDTFA_TO_WIKI <- list(
    `Angels`="Angels Camp",
    `California`="California City",
    `Industry`="City of Industry")

CA_CITIES <- read.csv("ca_cities.csv", stringsAsFactors=FALSE)

# CDTFA boundary data, e.g., as from https://gis.data.ca.gov/datasets/CDTFA::city-and-county-boundary-line-changes/explore?layer=0&location=33.924386%2C-118.008294%2C11.67.
extractCitiesFromCtdfa <- function(cdtfaBoundaries, expectedCities=CA_CITIES$city_name) {
    d <- subset(cdtfaBoundaries, CITY != "Unincorporated")
    d$CITY <- replaceStrings(d$CITY, CDTFA_TO_WIKI)
    stopifnot(setequal(d$CITY, expectedCities))
    return(d %>% group_by(CITY) %>% summarise(SHAPE=st_union(SHAPE)))
}
