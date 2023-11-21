setwd('/Users/yuhanburgess/Documents/GitHub/world_happiness_report/')
source("DataAnaylsis.R")
source("whi.R")

interStateWar.event <- read_csv('Datasets/Inter-StateWarData_v4.0.csv')
interStateWar.clean <- StateWar.filter(interStateWar.event)

interStateWar.table <- completeness(interStateWar.clean, 'Inter-state War')

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

interStateWar.clean <- us.name(interStateWar.clean)
column.join <- setNames(colnames(country.region)[1], colnames(interStateWar.clean)[5])
interStateWar.clean <- join.df(interStateWar.clean, country.region, column.join)
interStateWar.clean <- subset(interStateWar.clean, select = -c(WarType))
# # list of continents 
# continents <- c('W. Hemisphere', 'Europe', 'Africa',
#                 'Middle East','Asia', 'Oceania')

# creating two different dataframes for analysis based on 
# battles on continent and then battles fought on continent
# with distinction based on country
result <- war.continent.filter(interStateWar.clean, continents)
war.continent <- result$war.continent
war.country.continent <- result$war.country.continent


by.part <- c("Country Name" = "name")
region.continent.join <- distinct(join.df(war.country.continent, 
                                          country.region, by.part))

region.continent.join <- continent.region.uni(region.continent.join)

region.continent.join$Occurrence <- as.numeric(region.continent.join$Occurrence)

summary(region.continent.join)
# ANAYLSIS: There is a right skew to the graph where a majority of countries are in a 
# war 2-3 times on a continent

state.war <- region.continent.join%>%
  group_by(`Country Name`)%>%
  summarise(total = sum(Occurrence, na.rm = TRUE))

summary(state.war)

top.25 <- as.data.frame(state.war[state.war$total > quantile(state.war$total, prob=.75),])
# ANAYLSIS: Looking at countries, and counting number of interstate wars they have participated in
# we can see that France is at the top with 21 appearances 

# Analysis of Inter-state data set

# CAVEAT: There may be some wars that are continued from another. this can be determined by looking at
# Transto column. There are very few wars that meet this requirement so we count those that transition into
# a different war as different instances 

# BIASIS: From the data we can see that wars fought in W.Hemisphere, Africa, and Oceania is comparatively
# smaller than those of Europe, Middle East, and Asia. This could suggest that the data is skewed
# more to the western thought/western focus on wars. There may be a lake of information about countries
# that are not super powers

# ANAYLSIS: Besides countries that reside within the continent, the next largest regional powers to fight
# on the continent is Western Europe and North America. This suggests a correlation between the colonial past
# and control that Western Europe had on each continent. It may also suggests who is the world power in war right
# now. For instance Western Europe has a lot of political power, but the USA has the largest military might. 

# A Treemap may be a good option to look at region.contineent.join


# Determine the duration of the war 
# war.duration function contained in DataAnalysis

# identify difference 
day <- war.duration(interStateWar.clean, 7, 10, 13,16)%>%
  rename("war.duration" = 'EndDay1')
month <- war.duration(interStateWar.clean, 6, 9, 12,15)
year <- war.duration(interStateWar.clean, 8,11, 14,17)

# change month to days
month.asday<- apply(month, 2, function(x) x*30.4167)

# create a column on the duration of the year with a base of year
war.duration <- ((day + month.asday)/365) + year
interStateWar.clean <- cbind(interStateWar.clean, war.duration)
summary(interStateWar.clean)

# ANAYLSIS: the majority of the wars are between 1 and 2 years. This data set is right
# skewed as we can see that out max is 10 years but 50% of the data fell 
# between 0.178 and 2.447 years. 

# ANAYLSIS: We can see the summary for the column "Outcome' which mainly ranges between 1 
# and 2. this Category is more so categorical than numeric since each number refers to the
# outcome of each country. If you look at documentation, then we can se that a majority of
# outcomes results in a win or loss.

# List used to convert the outcome from numerical to categorial
outcome.category <- c(
  `1` = 'Winner', `2` = 'Loser', `3` = 'Compromise/Tied', 
  `4` = 'The war was transformed into another type of war',
  `5` = 'The war is ongoing as of 12/31/2007', `6` = 'Stalemate',
  `7` = 'Conflict continues at below war level', `8` = 'changed sides'
)

# Change the numerical value of Where Fight Occurred to categorical variable
# !!! operator allows you to pass the contents of a list as individual arguments to a function
interStateWar.clean <- interStateWar.clean %>%
  mutate(Outcome = recode(as.character(Outcome), 
                              !!!outcome.category))

table(interStateWar.clean$Outcome)

interStateWar.State.Outcomes <- interStateWar.clean%>%
  group_by(StateName, Outcome)%>%
  count()
