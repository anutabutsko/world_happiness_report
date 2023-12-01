
source("FunctionFile.R")


inter.outcome.category <- c(
  `1` = 'Winner', `2` = 'Loser', `3` = 'Compromise/Tied', 
  `4` = 'The war was transformed into another type of war',
  `5` = 'The war is ongoing as of 12/31/2007', `6` = 'Stalemate',
  `7` = 'Conflict continues at below war level', `8` = 'changed sides'
)

interStateWar.event <- read_csv("interStateWar.event")

# deals with special cases, can find more detail in FunctionFile.R
interStateWar.clean <- StateWar.filter(interStateWar.event, 6:17)

# creates a completeness table that is also a ggplot
interStateWar.table <- completeness(interStateWar.clean, 'Inter-state War')

# Change the numerical value of Where Fight Occurred to categorical variable
# !!! operator allows you to pass the contents of a list as individual arguments to a function
interStateWar.clean <- interStateWar.clean %>%
  mutate(WhereFought = recode(as.character(WhereFought), 
                              !!!wherefought.category))%>%
  mutate(Outcome = recode(as.character(Outcome), 
                          !!!inter.outcome.category))

# changing United States of America to United States
interStateWar.clean <- us.name(interStateWar.clean)

# create a method on which to join two columns with different column names
interStateWar.column.join <- setNames(colnames(country.region)[1], 
                                      colnames(interStateWar.clean)[5])

# updating dataframe to contain information of continent and 
# sub-region of continent for country
interStateWar.clean <- join.df(interStateWar.clean, country.region, 
                               interStateWar.column.join)

# removing WarType since they all have a value of 1
interStateWar.clean <- subset(interStateWar.clean, select = -c(WarType))

# creating two different dataframes for analysis based on 
# battles on continent and then battles fought on continent
# with distinction based on country
result <- war.continent.filter(interStateWar.clean, continents)
war.count.by.continent <- result$war.continent
war.count.by.country.continent <- result$war.country.continent

# merging based on different column names 
by.part <- c("Country Name" = "name")

# updating dataframe to contain information of continent and 
# sub-region of continent for country
inter.region.continent.join <- distinct(join.df(war.count.by.country.continent, 
                                          country.region, by.part))

# update dataframe to fix discrepancy between the possible continents and the region columns
inter.region.continent.join <- continent.region.uni(inter.region.continent.join)

# standardizing some labeling of sub.region to match trend seen in whi.df.clean
inter.region.continent.join <- for.interstatewar.region.Regional.Indicator.Match(inter.region.continent.join)

# setting values in occurrence as nermical values  
inter.region.continent.join$Occurrence <- as.numeric(inter.region.continent.join$Occurrence)

inter.region.continent.join$region <- coalesce(inter.region.continent.join$region, 
                                        inter.region.continent.join$region.mirror)
# counting the number of thimes a country has participated in a war
war.participation.by.country <- inter.region.continent.join%>%
  group_by(`Country Name`)%>%
  summarise(total = sum(Occurrence, na.rm = TRUE))

# Determine the duration of the war 
# identify difference 
inter.day <- war.duration(interStateWar.clean, 7, 10, 13,16)%>%
  rename("war.duration" = 'EndDay1')
inter.month <- war.duration(interStateWar.clean, 6, 9, 12,15)
inter.year <- war.duration(interStateWar.clean, 8,11, 14,17)

# change month to days
inter.month.asday<- apply(inter.month, 2, function(x) x*30.4167)

# create a column on the duration of the year with a base of year
inter.war.duration <- ((inter.day + inter.month.asday)/365) + inter.year
interStateWar.clean <- cbind(interStateWar.clean, inter.war.duration)

# find the total total number of each outcome a country has experienced
interStateWar.State.Outcomes <- interStateWar.clean%>%
  group_by(StateName, Outcome)%>%
  count()

interStateWar.State.Outcomes <- left_join(interStateWar.State.Outcomes, country.region, by = c('StateName'='name'))

# there are a lot of duplicates beause each side is a different entry
# so we are looking at total numbers of unique wars 
total.distinct.wars <- distinct.war.type(interStateWar.clean)