# Example reading csv dataset.
library(tidyverse)
library(ggplot2)

# Public US DOT data:
# https://www.transtats.bts.gov/OT_Delay/OT_DelayCause1.asp
flight_delay <- read_csv("https://raw.githubusercontent.com/multidis/hult-data-strategy/main/read_data/SFO_2019_airline_delay_causes.csv")
flight_delay

# transform grouping by carrier
flight_delay_comp <- flight_delay %>% group_by(carrier_name) %>%
    summarize(delayedpct = 100*sum(arr_del15)/sum(arr_flights))
flight_delay_comp

# horizontal bar chart comparison
ggplot(flight_delay_comp, aes(x=reorder(carrier_name, delayedpct), y=delayedpct)) +
    geom_col() + coord_flip(clip = "off") + labs(x="", y="Percent of flights delayed")

# separate bars above a threshold by color
ggplot(flight_delay_comp, aes(x=reorder(carrier_name, delayedpct),
                              y=delayedpct,
                              fill=(delayedpct > 30))) +
    geom_col() + coord_flip(clip = "off") + labs(x="", y="Percent of flights delayed")

# remove unnecessary legend for the color fill
ggplot(flight_delay_comp, aes(x=reorder(carrier_name, delayedpct),
                              y=delayedpct,
                              fill=(delayedpct > 30))) +
    geom_col(show.legend = FALSE) + coord_flip(clip = "off") +
    labs(x="", y="Percent of flights delayed", title="Narrative here.")
