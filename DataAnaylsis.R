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

country.region <- read_csv('/Users/yuhanburgess/Documents/GitHub/world_happiness_report/Datasets/continents.csv')
country.region <- country.region %>%
  select('name', 'region', 'sub-region')

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

count.filter <- function(sub.df){
  df <- sub.df%>%
  summarize(Occurrence = n())
  
  return(df)
}

join.df <- function(df1, df2, x){
  df.join <- distinct(left_join(df1, df2, by = x))
  return(df.join)
}

StateWar.filter <- function(df){
  df <- df%>%
    # changing the values that represent NA and unknown to NA values 
    mutate_all(~ifelse(.== -9 | .== -8, NA, . ))%>%
    # removing column containing version of csv file 
    select(-c(Version))
  return(df)
}

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

us.name <- function(df){
  df%>%
  mutate_all(~ifelse(.== 'United States of America', 'United States', . ))
}

war.duration <- function(df, column1, column2, column3, column4) {
  ifelse(!is.na(df[,column3]), 
         duration <- abs((df[,column4] - df[,column3])
         +(df[,column2] - df[,column1])),
         duration  <- abs((df[,column2] - df[,column1])))
  print(duration)
}




