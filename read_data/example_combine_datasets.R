## Example combining multiple datasets for visualization.
library(tidyverse)
library(ggplot2)

# R package to simplify World Bank data load
# https://github.com/vincentarelbundock/WDI
library(WDI)

# selected country codes
wb_countries <- c("USA", "CAN", "MEX")

# query multiple datasets;
# rename data metric column to "metric" consistently;
# also specify what metric it was in a separate "indicator" column (to distinguish datasets)
wb_br <- tibble(WDI(indicator='SP.DYN.CBRT.IN', country=wb_countries, start=1960, end=2018)) %>%
    rename(metric = `SP.DYN.CBRT.IN`) %>% mutate(indicator = "birth")
wb_dr <- tibble(WDI(indicator='SP.DYN.CDRT.IN', country=wb_countries, start=1960, end=2018)) %>%
    rename(metric = `SP.DYN.CDRT.IN`) %>% mutate(indicator = "death")

# concatenate the datasets: bind_rows function
# https://dplyr.tidyverse.org/reference/bind.html
wb_comb <- bind_rows(wb_br, wb_dr)

# chart using available columns in the combined dataset:
# separate countries by color, indicator by line type
ggplot(data=wb_comb, aes(x=year, y=metric, color=country)) +
    geom_line(aes(linetype=indicator)) +
    labs(x = "", y="Number per 1000 people", title="Your narrative here") +
    theme_minimal() + theme(legend.title = element_blank())
