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

# completeness check of the data and turning it into
# a ggplot table
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
  # changing the values that represent NA and unknown to NA values 
  mutate_all(~ifelse(.== -9 | .== -8, NA, . ))%>%
  # removing column containing version of csv file 
  select(-c(Version))
interStateWar.table <- completeness(interStateWar.clean, 'Inter-state War')
print(interStateWar.table)

intraStateWar.clean <- intraStateWar.event%>%
  # changing the values that represent NA and unknown to NA values 
  mutate_all(~ifelse(.== -9 | .== -8, NA, . ))%>%
  # removing column containing version of csv file 
  select(-c(Version))
intraStateWar.table <- completeness(intraStateWar.clean, 'Intra-state War')
print(intraStateWar.table)

# correlation matrix within the whi.df
ggpairs(whi.df[,4:13], title="correlogram with ggpairs()", 
        method = c("everything", "pearson")) 
corality <- ggcorr(whi.df[,4:13]) 
ggplotly(corality)

# Analysis: There is very little correlation between generosity and GDP per
# capita at 0.7%. Overall, there does not seem to be a correlation between the two.
# We may be seeing a Simpsons paradox and would want to filter on location of country or
# some other factor

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

# Change the numerical value of Where Fight Occurred to categorical variable
# !!! operator allows you to pass the contents of a list as individual arguments to a function
interStateWar.clean <- interStateWar.clean %>%
  mutate(WhereFought = recode(as.character(WhereFought), 
                              !!!wherefought.category))

# fought.count <- interStateWar.clean%>%
#   group_by(WhereFought)%>%
#   count(WhereFought, StateName)

# list of continents 
continents <- c('W. Hemisphere', 'Europe', 'Africa',
                'Middle East','Asia', 'Oceania')

war.continent <-data.frame()
war.country.continent <-data.frame()

for(i in continents){
  x <- interStateWar.clean%>%
    filter(str_detect(WhereFought, i))
  
  continent.only <- x %>%
    summarize(Occurrence = n())
  
  continent.state <- x %>%
    group_by(`Country Name` = StateName) %>%
    summarize(Occurrence = n())
  
  # Add a column for the continent
  continent.state$Continent <- i
  
  # Combine results into a data frame
  war.continent <- rbind(war.continent, data.frame(Continent = i, continent.only))
  war.country.continent <- rbind(war.country.continent, continent.state)
}

location.country <- whi.df[1:2]%>%
  mutate_all(~ifelse(.== 'United States', 'United States of America', . ))

region.continent.join <- distinct(right_join(war.country.continent, location.country))
region.continent.join$Occurrence <- as.numeric(region.continent.join$Occurrence)
# Analysis of Inter-state data set

# BIASIS: From the data we can see that wars fought in W.Hemisphere, Africa, and Oceania is comparatively
# smaller than those of Europe, Middle East, and Asia. This could suggest that the data is skewed
# more to the western thought/western focus on wars. There may be a lake of information about countries
# that are not super powers

# ANAYLSIS: Besides countries that reside within the continent, the next largest regional powers to fight
# on the continent is Western Europe and North America. This suggests a correlation between the colonial past
# and control that Western Europe had on each continent. It may also suggests who is the world power in war right
# now. For instance Western Europe has a lot of political power, but the USA has the largest military might. 

# A Treemap may be a good option to look at region.contineent.join