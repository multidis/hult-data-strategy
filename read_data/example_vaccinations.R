# Example COVID vaccinations data:
library(tidyverse)
library(ggplot2)

# https://ourworldindata.org/grapher/covid-vaccination-doses-per-capita?stackMode=absolute&region=World
vac <- read_csv("https://raw.githubusercontent.com/multidis/hult-data-strategy/main/read_data/covid-vaccination-doses-per-capita.csv")

# keep in mind: total vaccinations are provided over time,
# a simple summation (e.g. Tableau default for tile plot) would not work here
vac

# group by country and select up-to-date vaccination metric; also sort in descending order
vac_summary <- vac %>% group_by(Entity) %>%
    summarize(vac_to_date = max(total_vaccinations_per_hundred)) %>%
    arrange(desc(vac_to_date))
vac_summary

# example chart (too many countries to see clearly)
ggplot(data=vac_summary, aes(x=vac_to_date, y=Entity)) + geom_col()

# select top-20 countries
ggplot(data=vac_summary[1:20,], aes(x=vac_to_date, y=reorder(Entity, vac_to_date))) + geom_col()

# clean up text labels etc.
ggplot(data=vac_summary[1:20,], aes(x=vac_to_date, y=reorder(Entity, vac_to_date))) + geom_col() +
    labs(x="Vaccinations per hundred", y = "", title="COVID vaccination progress")


# if you want a treemap: install treemapify package
library(treemapify)
ggplot(data=vac_summary, aes(area=vac_to_date, label=Entity)) +
    geom_treemap(fill="#FFCCCC") + geom_treemap_text()
