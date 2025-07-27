library(httr)
library(XML)

fetchDataFromStateTable <- function(wikipediaUrl) {
    wikiTables <- readHTMLTable(doc=content(GET(wikipediaUrl), "text"))

    stats <- setNames(tail(wikiTables[[2]], n=-2),
    c("city_name", "type", "county", "pop_2020", "pop_2010", "pop_delta", "area_mi2",
        "area_km2", "pop_density", "incorporation_date"))

    stats$county_seat <- grepl("†|‡", stats$city_name)
    stats$city_name <- gsub("†|‡", "", stats$city_name)
    stats$pop_2020 <- as.numeric(gsub(",", "", stats$pop_2020))
    stats$pop_2010 <- as.numeric(gsub(",", "", stats$pop_2010))
    stats$area_mi2 <- as.numeric(stats$area_mi2)
    return(stats)
}