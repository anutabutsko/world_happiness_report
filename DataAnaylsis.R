# install.packages(GGally')
# install.packages('gt')
# install.packages('treemap')
library(readr)
library(GGally) # ggcorr
library(plotly) # interactive map
library(dplyr)
library(gt) # table 
library(gridExtra) # getting multiple tables in one window
library(treemap) # boxing based off proportion
library(stringr) # for string detection
library(d3Tree)
setwd('/Users/yuhanburgess/Documents/GitHub/world_happiness_report/Datasets/')

whi.df <- read_csv('WorldHappinessReport.csv')
violent.event <- read_csv('political_violence_events_by_country.csv')
interStateWar.event <- read_csv('Inter-StateWarData_v4.0.csv')
intraStateWar.event <- read_csv('Intra-StateWarData_v4.1.csv')

completeness <- function(df, title){
  complete.prop <- apply(df, 2, function(x) (1- (sum(is.na(x)/length(x))))*100)
  
  complete.df <-data.frame(Sub_Indexs = colnames(df), Completeness = complete.prop)
  complete.df%>%
    gt()%>%
    tab_header(title = md(title),
               subtitle = md('`Completeness Table`'))
  
}
# Creating  completeness tables for data analysis 
whi.table <- completeness(whi.df, 'World Happiness Index')
print(whi.table)

violent.table <- completeness(violent.event[,-1], 'World Happiness Index')
print(violent.table)

interStateWar.clean <- interStateWar.event%>%
  mutate_all(~ifelse(.== -9 | .== -8, NA, . ))%>%
  select(-c(Version))
interStateWar.table <- completeness(interStateWar.clean, 'Inter-state War')
print(interStateWar.table)

intraStateWar.clean <- intraStateWar.event%>%
  mutate_all(~ifelse(.== -9 | .== -8, NA, . ))%>%
  select(-c(Version))
intraStateWar.table <- completeness(intraStateWar.clean, 'Intra-state War')
print(intraStateWar.table)

# correlation matrix
ggpairs(whi.df[,4:13], title="correlogram with ggpairs()", 
        method = c("everything", "pearson")) 
corality <- ggcorr(whi.df[,4:13]) 
ggplotly(corality)




# Dictionary to map numeric values to categories
wherefought.category <- c(
  `1` = 'W. Hemisphere', `2` = 'Europe', `4` = 'Africa', `6` = 'Middle East',
  `7` = 'Asia', `9` = 'Oceania', `11` = 'Europe & Middle East', `12` = 'Europe & Asia',
  `13` = 'W. Hemisphere & Asia', `14` = 'Europe, Africa & Middle East',
  `15` = 'Europe, Africa, Middle East, & Asia',
  `16` = 'Africa, Middle East, Asia & Oceania',
  `17` = 'Asia & Oceania', `18` = 'Africa & Middle East',
  `19` = 'Europe, Africa, Middle East, Asia & Oceania'
)

# !!! operator allows you to pass the contents of a list as individual arguments to a function
interStateWar.clean <- interStateWar.clean %>%
  mutate(WhereFought = recode(as.character(WhereFought), 
                              !!!wherefought.category))

fought.count <- interStateWar.clean%>%
  group_by(WhereFought)%>%
  count(WhereFought, StateName)

continents <- c('W. Hemisphere', 'Europe', 'Africa',
                'Middle East','Asia', 'Oceania')
war.continent <-data.frame()
for(i in continents){
  x <- interStateWar.clean%>%
    subset(grepl(i, WhereFought))%>%
    count()
  
  war.continent <- rbind(war.continent, data.frame(Continent = i, Occurance = x$n))
}


