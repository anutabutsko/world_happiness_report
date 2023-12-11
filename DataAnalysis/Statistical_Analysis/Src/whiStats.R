library(tidyverse)
whi.df <- read.csv('DatasetStats/WorldHappinessReport.csv')
country.region <- read.csv('DatasetStats/continents.csv')

country.region <- country.region %>%
  select('name', 'region', 'sub.region')%>%
  rename(sub.region = `sub.region`)

population <- read.csv('DatasetStats/PopulationData.csv', skip = 4)
population <- population[, c(1:2, 50:(ncol(population) - 1))]

population <- population %>%
  pivot_longer(cols = starts_with("X"), 
               names_to = "Year", 
               values_to = "Population") %>%
  mutate(Year = as.integer(str_remove(Year, "X")))

population <- population %>%
  mutate(Country.Name = replace(Country.Name, Country.Name == "Russian Federation", "Russia"))

# used in the whi.R
# combining central and eastern Europe together (this represents 
# countries who were part of the former Eastern bloc)
region.Regional.Indicator.Match <- function(df){
  df <- df%>%
    mutate(sub.region = ifelse((sub.region == "Central Europe" | 
                                  sub.region == 'Eastern Europe'), 
                               "Central and Eastern Europe", sub.region))%>%
    # changing this to the Caribbean for simplicity
    mutate(sub.region = ifelse(sub.region == "Anglophone Caribbean", 
                               "Caribbean", sub.region))
  return(df)
}

# setting regional.indicators for countries that do not have one already attached 
whi.df.clean <- whi.df %>%
  mutate(Regional.Indicator = case_when(
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Angola' ~ "Southern Africa",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Belize' ~ "Central America",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Bhutan' ~ "South Asia",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Central African Republic' ~ "Central Africa",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Congo (Kinshasa)' ~ "Central Africa",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Cuba' ~ "Caribbean",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Czechia' ~ "Central Europe",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Djibouti' ~ "East Africa",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Eswatini' ~ "Southern Africa",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Guyana' ~ "Anglophone Caribbean",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Oman' ~ "Middle East",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Qatar' ~ "Middle East",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Somalia' ~ "East Africa",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Somaliland region' ~ "East Africa",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'South Sudan' ~ "North Africa",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Sudan' ~ "North Africa",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Suriname' ~ "South America",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Syria' ~ "Middle East",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Trinidad and Tobago' ~ "Caribbean",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'Turkiye' ~ "Central and Eastern Europe",
    (is.na(Regional.Indicator) | Regional.Indicator == "") & Country.Name == 'State of Palestine' ~ "West Asia",
    TRUE ~ Regional.Indicator
  ))

# setting Continent  for countries that do not have one already attached 
whi.df.clean <- whi.df.clean %>%
  mutate(Continent = case_when(
    Regional.Indicator %in% c("South Asia", "Commonwealth of Independent States", "Southeast Asia", 
                              "East Asia", "Middle East", "West Asia") ~ "Asia",
    Regional.Indicator %in% c("Central and Eastern Europe", "Western Europe", "Central Europe") ~ "Europe",
    Regional.Indicator %in% c("Middle East and North Africa", "Southern Africa", "Sub-Saharan Africa", 
                              "Central Africa", "East Africa", "North Africa") ~ "Africa",
    Regional.Indicator %in% c("Latin America and Caribbean", "North America and ANZ", "Central America", 
                              "Caribbean", "Anglophone Caribbean", "South America") ~ "Americas",
    Regional.Indicator == "North America and ANZ" ~ "Oceania",
    TRUE ~ "Other" 
  ))

country.region <- country.region %>%
  mutate(name = ifelse(name == "Bosnia And Herzegovina", "Bosnia and Herzegovina", name))

# mering the two dataframes together 
by.part <- c('Country.Name' = 'name')
whi.df.clean <- left_join(whi.df.clean, country.region, by.part)

# if region is NA, set it to the value of the Conitnent 
# and same logic for the sub.region
whi.df.clean<- whi.df.clean%>%
  mutate(region = coalesce(region, Continent))%>%
  mutate(sub.region = coalesce(sub.region, Regional.Indicator))
  
# used for plot, further explanation in Plotting.R
by_continent <- whi.df.clean %>%
  group_by(region) %>%
  summarise(n=n(), Log.GDP.Per.Capita=mean(Log.GDP.Per.Capita, na.rm=TRUE))


# some further standardization of data, can find more info in FuntionFile.R
whi.df.clean <- region.Regional.Indicator.Match(whi.df.clean)

whi.df.clean <- left_join(whi.df.clean, population, by = c("Country.Name", "Year"))

df <- whi.df.clean %>%
  select(-c(Country.Code))


# STATS
################################################################################
# pandemic.years <- whi.df.clean%>%
#   subset(Year >= 2020 |
#            (Year > 2013 & Year < 2017) |
#            (Year >= 2009 & Year < 2011))
# 
# non.pandemic.years <- whi.df.clean%>%
#   subset((Year < 2020 & Year >2016) |
#            (Year >= 2011 & Year < 2014) |
#            Year <= 2008)
# 
# swine.flu <- pandemic.years%>%
#   subset(Year >= 2009 & Year < 2011)
# 
# ebola.outbreak <- pandemic.years%>%
#   subset(Year >= 2014 & Year < 2017)
# 
# sar.outbreak <- pandemic.years%>%
#   subset(Year >= 2020)

