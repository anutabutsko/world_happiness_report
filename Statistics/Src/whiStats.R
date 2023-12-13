library(tidyverse)
whi.df <- read.csv('DatasetStats/WorldHappinessReport.csv')
country.region <- read.csv('DatasetStats/continents.csv')
population <- read.csv('DatasetStats/PopulationData.csv', skip = 4)
covid <- read.csv("DatasetStats/covid-hospitalizations.csv")
case <- read.csv("DatasetStats/WHO-COVID-19-global-data.csv")

country.region <- country.region %>%
  select('name', 'region', 'sub.region')%>%
  rename(sub.region = `sub.region`)

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

happydf <- whi.df.clean %>%
  select(-c(Country.Code))

covid <- covid %>%
  rename(Country.Name = entity) %>%
  pivot_wider(
    names_from = indicator, 
    values_from = value
  ) %>%
  select(Country.Name, date, `Daily ICU occupancy`, `Daily ICU occupancy per million`) %>%
  mutate(
    Year = year(date),
    month = month(date),
    day = day(date),
    week_of_year = week(date),
    year_week = paste(Year, week_of_year, sep = ""),
    year_month = paste(Year, month, sep = "")
  )

# Detailed Averaging for Daily Average ICU Occupies and ICU Occupies per million
# by week
covid_summary <- covid %>%
  group_by(Country.Name, Year, month, week_of_year) %>%
  summarize(
    Avg_Daily_ICU_Occupancy = mean(`Daily ICU occupancy`, na.rm = TRUE),
    Avg_Daily_ICU_Occupancy_Per_Million = mean(`Daily ICU occupancy per million`, na.rm = TRUE)
  )
#THEN by month
covid_summary <- covid_summary %>%
  group_by(Country.Name, Year, month) %>%
  summarize(
    Avg_Daily_ICU_Occupancy = mean(`Avg_Daily_ICU_Occupancy`, na.rm = TRUE),
    Avg_Daily_ICU_Occupancy_Per_Million = mean(`Avg_Daily_ICU_Occupancy_Per_Million`, na.rm = TRUE)
  )
#THEN by Year
covid_summary <- covid_summary %>%
  group_by(Country.Name, Year) %>%
  summarize(
    Avg_Daily_ICU_Occupancy = mean(`Avg_Daily_ICU_Occupancy`, na.rm = TRUE),
    Avg_Daily_ICU_Occupancy_Per_Million = mean(`Avg_Daily_ICU_Occupancy_Per_Million`, na.rm = TRUE)
  )
covid <- covid_summary

class(happydf$Year)= "character"
class(covid$Year)= "character"
#str(happydf)
happydf <- merge(happydf, covid, by = c("Country.Name", "Year"), all.x = TRUE)
happydf$Year <- as.numeric(as.character(happydf$Year))

# plot <- happydf %>% 
#   filter(Continent %in% c("Asia", "Africa", "Europe", "Americas"))
# 
# # Plot
# plot %>%
#   ggplot(aes(x=Year, 
#              y=Life.Ladder, 
#              group=Continent, 
#              color=Continent)) +
#   geom_smooth() +
#   ggtitle("Happiness Over Time") +
#   xlab("Time") +
#   ylab("Happiness")


case <- case %>%
  rename(Country.Name = Country) %>%
  mutate(
    Year = year(Date_reported),
    month = month(Date_reported),
    day = day(Date_reported),
    week_of_year = week(Date_reported),
    year_week = paste(Year, week_of_year, sep = ""),
    year_month = paste(Year, month, sep = "")
  )

# Detailed Averaging for Daily Average ICU Occupies and ICU Occupies per million
# by week
case_summary <- case %>%
  group_by(Country.Name, Country_code, Year, month, week_of_year) %>%
  summarize(
    Avg_Daily_NewCases = mean(New_cases, na.rm = TRUE),
    Avg_Daily_NewDeaths = mean(New_deaths, na.rm = TRUE),
    Avg_Daily_Cumulative_Cases = mean(Cumulative_cases, na.rm = TRUE),
    Avg_Daily_Cumulative_Death = mean(Cumulative_deaths, na.rm = TRUE)
  )
#THEN by month
case_summary <- case_summary %>%
  group_by(Country.Name, Country_code, Year, month) %>%
  summarize(
    Avg_Daily_NewCases = mean(Avg_Daily_NewCases, na.rm = TRUE),
    Avg_Daily_NewDeaths = mean(Avg_Daily_NewDeaths, na.rm = TRUE),
    Avg_Daily_Cumulative_Cases = mean(Avg_Daily_Cumulative_Cases, na.rm = TRUE),
    Avg_Daily_Cumulative_Death = mean(Avg_Daily_Cumulative_Death, na.rm = TRUE)
  )
#THEN by Year
case_summary <- case_summary %>%
  group_by(Country.Name, Country_code, Year) %>%
  summarize(
    Avg_Daily_NewCases = mean(Avg_Daily_NewCases, na.rm = TRUE),
    Avg_Daily_NewDeaths = mean(Avg_Daily_NewDeaths, na.rm = TRUE),
    Avg_Daily_Cumulative_Cases = mean(Avg_Daily_Cumulative_Cases, na.rm = TRUE),
    Avg_Daily_Cumulative_Death = mean(Avg_Daily_Cumulative_Death, na.rm = TRUE)
  )
case <- case_summary

class(happydf$Year)= "character"
class(case$Year)= "character"

happydf <- merge(happydf, case, by = c("Country.Name", "Year"), all.x = TRUE)
happydf$Year <- as.numeric(as.character(happydf$Year))

happydf <- happydf %>%
  mutate(Epi_Pandemic_Year = case_when(
    Year %in% c(2014, 2015, 2016) ~ 1,
    Year %in% c(2009, 2010) ~ 1,
    Year %in% c(2020, 2021, 2022) ~ 1,
    TRUE ~ 0
  ))

corruption_regression <- function(df, continent){
  df_clean<- df[!is.na(df$Perceptions.Of.Corruption), ] %>%
    filter(Continent==continent)
  
  correlation <- round(cor(df_clean$Life.Ladder, df_clean$Perceptions.Of.Corruption),2)
  
  corruption <- df %>%
    filter(Continent==continent) %>%
    group_by(Country.Name) %>% 
    summarise(Life.Ladder = mean(Life.Ladder), Perceptions.Of.Corruption = mean(Perceptions.Of.Corruption)) %>%
    ggplot(aes(Perceptions.Of.Corruption, Life.Ladder)) +
    geom_point(alpha=0.5, color="darkblue") + 
    geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
    labs(title=continent, 
         subtitle = paste("Correlation coefficient:", correlation), 
         x="Corruption", 
         y="Happiness") +
    ggeasy::easy_center_title() +
    theme_minimal()
  return(corruption)
}
cor_america <- corruption_regression(happydf, "Americas")
cor_asia <- corruption_regression(happydf, "Asia")
cor_europe <- corruption_regression(happydf, "Europe")
cor_africa <- corruption_regression(happydf, "Africa")
combined_plot <- ggarrange(cor_america, cor_asia, cor_europe, cor_africa, ncol = 2, nrow =2, common.legend = TRUE, legend="bottom")


top_happiness <- happydf %>%
  group_by(Country.Name) %>%
  summarise(Life.Ladder = mean(Life.Ladder, na.rm = TRUE), corruption = mean(Perceptions.Of.Corruption, na.rm = TRUE)) %>%
  arrange(desc(Life.Ladder)) %>%
  head(15)

low_happiness <- happydf %>%
  group_by(Country.Name) %>%
  summarise(Life.Ladder = mean(Life.Ladder, na.rm = TRUE), corruption = mean(Perceptions.Of.Corruption, na.rm = TRUE)) %>%
  arrange(Life.Ladder) %>%
  head(15)

WHO <- happydf %>%
  select(Country.Name,Regional.Indicator,Year, Life.Ladder, Continent, 
         Avg_Daily_ICU_Occupancy_Per_Million, Avg_Daily_NewCases,Avg_Daily_Cumulative_Cases, 
         Epi_Pandemic_Year,Avg_Daily_ICU_Occupancy, Avg_Daily_NewDeaths, Avg_Daily_Cumulative_Death) %>%
  na.omit(happydf)

columns_to_exclude <- c("Life.Ladder", "Country.Name", "Regional.Indicator", "Continent", "Epi_Pandemic_Year")

reduced_data <- WHO[, !(names(WHO) %in% columns_to_exclude)]
reduced_data <- na.omit(reduced_data)

# Compute correlation at 2 decimal places
corr_matrix = round(cor(reduced_data), 2)
# Compute a matrix of correlation p-values
p.mat <- cor_pmat(reduced_data)


high_correlations <- which(corr_matrix > 0.8 & corr_matrix < 0.99, arr.ind = TRUE)
correlation_values <- corr_matrix[high_correlations]
variable_names <- rownames(corr_matrix)[high_correlations[, 1]]
correlated_variable_names <- colnames(corr_matrix)[high_correlations[, 2]]

high.correlation.content <- data.frame(
  Variable1 = variable_names,
  Variable2 = correlated_variable_names,
  Correlation = correlation_values
)


