library(here)
here::i_am("DataAnalysis/whi.R")
FunFile <- here("DataAnalysis", "FunctionFile.R")
FunFile <- source(FunFile)

df <- here("DataAnalysis", "Datasets", "WorldHappinessReport.csv")

whi.df <- read.csv(df)

population <- read_csv('Datasets/PopulationData.csv', skip = 4)
population <- population[, c(1:2, 50:(ncol(population) - 1))]

population <- population %>%
  rename(Country.Name = `Country Name`, Country.Code = `Country Code`)

population <- population %>%
  gather(key = "Year", value = "Population", -Country.Name, -Country.Code) %>%
  mutate(Year = as.integer(Year))

population <- population %>%
  mutate(Country.Name = replace(Country.Name, Country.Name == "Russian Federation", "Russia"))


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

# creating a completeness table of the dataframe
whi.table <- completeness(whi.df.clean, 'World Happiness Index')

# used for filtering in InterState.R
location.country <- us.name(whi.df[1:2])

# standardizing the name so it can be used in future data wrangling
country.region <- country.region %>%
  mutate(name = ifelse(name == "Bosnia And Herzegovina", "Bosnia and Herzegovina", name))

# mering the two dataframes together 
by.part <- c('Country.Name' = 'name')
whi.df.clean <- join.df(whi.df.clean, country.region, by.part)

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


df <- whi.df.clean%>%
  rename(Country = Country.Name)

world.map <- world.map.function(df)%>%
  select(-'subregion')

life.Ladder.Difference <- whi.df.clean %>%
  group_by(Country.Name) %>%
  slice(which.min(Year), which.max(Year)) %>%
  summarise(Start.Life.Ladder = Life.Ladder[which.min(Year)],
            End.Life.Ladder = Life.Ladder[which.max(Year)],
            Life.Ladder.Difference = diff(Life.Ladder),
            region = region,
            sub.region = sub.region)


sub.region.trend <- whi.df.clean %>% 
  filter(!is.na(sub.region) & sub.region != "")
sub.region.trend$sub.region <- fct_reorder(sub.region.trend$sub.region, 
                                           sub.region.trend$Life.Ladder, .desc=T)

sub.region.trend.plot <- sub.region.trend %>%
  group_by(Year, sub.region) %>%
  summarise(avg = mean(Life.Ladder, na.rm = TRUE))
sub.region.trend.plot
colnames(sub.region.trend.plot)[2] <- "subRegion"
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

