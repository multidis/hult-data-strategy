# Example reading csv weather dataset:
# http://www.bom.gov.au/climate/dwo/IDCJDW2124.latest.shtml
library(tidyverse)
library(ggplot2)

# NOTE: dates are not formatted in a standard way in this file
# http://www.bom.gov.au/climate/dwo/202103/text/IDCJDW2124.202103.csv
# use a helper package to work with non-standard date formats
library(lubridate)

# csv file needs to be cleaned up as well
weather <- read_csv("weather_clean.csv")

# now we can use as_date function to clean up the format;
# also, pay attention to backticks (``): the problem is column names are complex
ggplot(data=weather, aes(x=as_date(Date), y=`Rainfall (mm)`)) + geom_line()

# one column vs another, not involving date
ggplot(data=weather, aes(x=`Sunshine (hours)`, y=`Rainfall (mm)`)) + geom_point()

# customize text
ggplot(data=weather, aes(x=as_date(Date), y=`Rainfall (mm)`)) + geom_line() +
  labs(x="Date", title="Sydney rainfall observations (2021)")
