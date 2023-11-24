# install.packages(GGally')
# install.packages('gt')
# install.packages('treemap')
library(readr)
library(GGally) # ggcorr
library(plotly) # interactive map
library(dplyr)
library(ggplot2)
library(gt) # table 
library(gridExtra) # getting multiple tables in one window
library(treemap) # boxing based off proportion
library(stringr) # for string detection
library(d3Tree)
library(viridis)
library(ggridges)
library(maps)
library(dplyr)
library(data.table)
library(ggeasy)


# setwd('/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis')

# file to get a more precies understanding of continent and subregions within continent  
country.region <- read_csv('Datasets/continents.csv')
country.region <- country.region %>%
  select('name', 'region', 'sub-region')%>%
  rename(sub.region = `sub-region`)

# used in InterState.R
wherefought.category <- c(
  `1` = 'W. Hemisphere', `2` = 'Europe', `4` = 'Africa', `6` = 'Middle East',
  `7` = 'Asia', `9` = 'Oceania', `11` = 'Europe & Middle East', `12` = 'Europe & Asia',
  `13` = 'W. Hemisphere & Asia', `14` = 'Europe, Africa & Middle East',
  `15` = 'Europe, Africa, Middle East, & Asia',
  `16` = 'Africa, Middle East, Asia & Oceania',
  `17` = 'Asia & Oceania', `18` = 'Africa & Middle East',
  `19` = 'Europe, Africa, Middle East, Asia & Oceania'
)

# list of continents 
continents <- c('W. Hemisphere', 'Europe', 'Africa',
                'Middle East','Asia', 'Oceania')

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

# used in the InterState.R
# combining central and eastern Europe together (this represents 
# countries who were part of the former Eastern bloc)
for.interstatewar.region.Regional.Indicator.Match <- function(df){
  df <- df%>%
    mutate(sub.region = ifelse((sub.region == "Central Europe" | 
                                  sub.region == 'Eastern Europe'), 
                               "Central and Eastern Europe", sub.region))%>%
    # standardizing naming conventions
    mutate(region.mirror = ifelse(region.mirror == 'W. Hemisphere', 
                                  'Americas', region.mirror))
  
  return(df)
}

# completeness check of the data and turning it into
# a ggplot table
completeness <- function(df, title){
  complete.prop <- apply(df, 2, function(x) (1- (sum(is.na(x)/length(x))))*100)
  
  complete.df <- data.frame(Sub_Indexs = colnames(df), Completeness = complete.prop)
  complete.df%>%
    gt()%>%
    tab_header(title = md(title),
               subtitle = md('`Completeness Table`'))
  
}

# used to count occurrences of 'Events' within the Violenc.Demonstration.Country.R
count.filter <- function(sub.df, ..., value.col = "Events") {
  group.vars <- enquos(...) # it turns the arguments provided into a list of quoted expressions
  
  # does operation without any grouping
  if (length(group_vars) == 0) {
    df <- sub.df %>%
      summarize(Occurrence = n(), TotalEvents = sum(!!sym(value.col), na.rm = TRUE))
    
    # does sum operation based off grouping
  } else {
    df <- sub.df %>%
      group_by(!!!group.vars) %>%
      summarize(Occurrence = n(), TotalEvents = sum(!!sym(value.col), na.rm = TRUE))
  }
  
  return(df)
}


join.df <- function(df1, df2, x){
  df.join <- distinct(left_join(df1, df2, by = x))
  return(df.join)
}

# redefines special values for data anaylsis
StateWar.filter <- function(df, col.range){
  df <- df%>%
    # changing the values that represent NA and unknown to NA values 
    mutate_all(~ifelse(.== -9 | .== -8, NA, . ))%>%
    # removing column containing version of csv file 
    select(-c(Version))%>%
    #
    mutate(across(all_of(col.range), 
                  ~case_when(. == -7 ~ 2023,
                             is.na(.) | str_detect(as.character(.), "-") ~ NA,
                             TRUE ~ as.numeric(.))))
  return(df)
}

# determines number of wars per continent and twars per
# continent by country
war.continent.filter <- function(interStateWar.clean, continents){
  war.continent <-data.frame()
  war.country.continent <-data.frame()
  
  for(i in continents){
    # subset df based on the continent 
    # that war occurred
    x <- interStateWar.clean%>%
      filter(str_detect(WhereFought, i))
    
    # getting occurrences of wars fought on continent
    continent.only <- x%>%
      distinct(x[,1])%>%
      summarize(Occurrence = n())
    
    # getting occurrences of wars fought on continent
    # and country 
    continent.state <- x %>%
      group_by(`Country Name` = StateName) %>%
      summarize(Occurrence = n())
    
    # Add a column for the continent
    continent.state$Continent <- i
    
    # Combine results into a data frame
    war.continent <- rbind(war.continent, data.frame(Continent = i, continent.only))
    war.country.continent <- rbind(war.country.continent, continent.state)
  }
  return(list(war.continent = war.continent, war.country.continent = war.country.continent))
}

# changes United States of America to United States
us.name <- function(df){
  df%>%
    mutate_all(~ifelse(.== 'United States of America', 'United States', . ))
}

# used to calculate duration of war
war.duration <- function(df, column1, column2, column3, column4) {
  # when startyear2 is true than there are two timeframes that the 
  # war occurred 
  ifelse(!is.na(df[,column3]), 
         duration <- abs((df[,column4] - df[,column3])
                         +(df[,column2] - df[,column1])),
         # counts if there is not a year in startyear2
         duration  <- abs((df[,column2] - df[,column1])))
  return(duration)
}

continent.region.uni <- function(df){
  df <- df %>%
    mutate(region.mirror = case_when(
      `sub.region` == 'Western Asia' ~ 'Middle East',
      str_detect(sub.region, 'Europe') ~ 'Europe',
      str_detect(sub.region, 'Africa') ~ 'Africa',
      str_detect(sub.region, 'Australia') ~ 'Oceania',
      (is.na(sub.region))~ Continent, 
      TRUE ~ sub.region  # Default case when none of the conditions are met
    ))
  
}

# returning df that does not contain duplicate of the same war
distinct.war.type <- function(df){
  freq.df<- df%>%
  distinct(WarNum, .keep_all = TRUE) %>%
    select(WarNum, WarName, StartYear1, EndYear1)
  
  return(freq.df)
}