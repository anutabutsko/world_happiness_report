setwd('/Users/yuhanburgess/Documents/GitHub/world_happiness_report/')
source("whi.R")
source("InterState.R")
source("IntraState.R")
# source("Violence.Demontration.Country.R")

# InterState Analysis
summary(interStateWar.clean)

# ANAYLSIS: the majority of the wars are between 1 and 2 years. This data set is right
# skewed as we can see that out max is 10 years but 50% of the data fell 
# between 0.178 and 2.447 years. 

# ANAYLSIS: We can see the summary for the column "Outcome' which mainly ranges between 1 
# and 2. this Category is more so categorical than numeric since each number refers to the
# outcome of each country. If you look at documentation, then we can se that a majority of
# outcomes results in a win or loss.

summary(inter.region.continent.join)
# ANAYLSIS: There is a right skew to the graph where a majority of countries are in a 
# war 2-3 times on a continent

print(war.count.by.continent) 
summary(war.count.by.continent)

print(war.count.by.country.continent)
summary(war.count.by.country.continent)

summary(war.participation.by.country)

top.25 <- as.data.frame(inter.state.war[inter.state.war$total > quantile(inter.state.war$total, prob=.75),])
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

table(interStateWar.clean$Outcome)
