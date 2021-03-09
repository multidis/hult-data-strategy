# World Bank data import example.
library(tidyverse)
library(ggplot2)

# R package to simplify World Bank data load
# https://github.com/vincentarelbundock/WDI
library(WDI)

# Example dataset:
# https://data.worldbank.org/indicator/NV.AGR.TOTL.ZS?view=chart

# single country
wb <- tibble(WDI(indicator='NV.AGR.TOTL.ZS', country=c('KEN'), start=1960, end=2019))
wb

ggplot(data=wb, aes(x=year, y=`NV.AGR.TOTL.ZS`)) + geom_line()


# multiple countries
wb_sel <- tibble(WDI(indicator='NV.AGR.TOTL.ZS', country=c('KEN', 'PHL'), start=1960, end=2019))
wb_sel

ggplot(data=wb_sel, aes(x=year, y=`NV.AGR.TOTL.ZS`, color=country)) + geom_line()

