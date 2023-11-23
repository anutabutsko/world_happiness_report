source("whi.R")
source("InterState.R")
source("IntraState.R")
source("Violence.Demontration.Country.R")

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

# most battles are fought in Europe, Middle East, and Asia

# Asian front: The increase in battles on the Asian front could be a result of 
# communist ideology spreading in Cambodia, China, and Vietnam. This 
# time frame could be around the 1930-1970

# Middle East: The wars fought in the Middle Eastern front could be
# in relation of revolt and revolution. In my opinion it would be categorized
# as wars for statehood. Later wars could relate to 'War on Terrorism`` imposed 
# by the US

# Europe: We have the WWI(1917) and WWII(1940) which was fought on many different fronts.
# Europe seems to be dealing with battles among each other. 

# America: Besides WW's, cold war, and 9/11, I would assume manifest destiny (1845) is playing a part in 
# some of their earlier wars

# Africa: was colonized by the Europeans and during this timefrme, these countries were
# losing control of strict governance over country so their activities did not meet requirement
# of war to show up in file.

# INTERESTING: look at distribution based on date

print(war.count.by.country.continent)
summary(war.count.by.country.continent)

summary(war.participation.by.country)

top.25 <- as.data.frame(war.participation.by.country[
  war.participation.by.country$total > quantile(war.participation.by.country$total,
                                   prob=.75),])
print(top.25)
# ANAYLSIS: Looking at countries, and counting number of interstate wars they have participated in
# we can see that France is at the top with 21 appearances 

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


table(interStateWar.clean$Outcome)

table(total.distinct.wars$StartYear1)
# 1914: WWII | There could have been an increase in wars due to fractional disrepare in the government after the
# WW. On average there seemes to be 1-2 wars a year (this does not look at the duration so a country may end in
# a year not listed in the table)

summary(violent.event.per.year)
head(arrange(violent.event.per.year,desc(TotalEvents)), n = 10)
# Majority of violent events look to be focused on areas centered near the equator,
# areas such as the middle east and northern Africa, Central and South America, as well as
# some Asian countries. 

summary(demonstration.event.per.year)
head(arrange(demonstration.event.per.year,desc(TotalEvents)), n = 10)

summary(demonstration.event.per.country)
# we can try an compare the overall distribution of the whi index and cross analysis with the
# occurrence of violent events in that country 




