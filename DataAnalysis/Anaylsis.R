happinessByContinentText.content <- tagList(
  tags$h3("Global Happiness Trends and Analysis by Continent"),
  tags$strong("1. Country Distribution by Continent"),
  tags$p(tags$em("Africa: 43 countries")),
  tags$p(tags$em("Europe: 38 countries (including Western Europe, CIS, Central, and Eastern Europe)")),
  tags$p(tags$em('Asia: 37 countries')),
  tags$p(tags$em("Americas: 26 countries")),
  tags$p(tags$em("Oceania: 2 countries")),
  tags$p(),
  tags$strong("2. General Observations"),
  tags$p("Approximately 25% of the global population rates their happiness at the mid-point (5 out of 11)."),
  tags$p("Significant disparities in average life evaluations exist among regions, notably between Africa and other continents and Oceania and the other continents."),
  tags$p(),
  tags$strong("3. Trends in Positive and Negative Affects"),
  tags$p("Positive Affect: Higher on average but varies greatly between regions."),
  tags$p("Negative Affect: Showed an increasing trend from 2010-2018, rising globally from 22% to 28%. This trend differs among regions."),
  tags$p(),
  tags$strong("4. Regional Variations and Economic Impacts"),
  tags$p("Post-2007-2008 financial crisis, all regions experienced a drop in happiness, with Europe (Western, CIS, Central, and Eastern) showing varied recovery patterns."),
  tags$p("Happiness convergence is observed in parts of Europe, but disparities remain, particularly between Central and Eastern Europe and the CIS."),
  tags$p("Economic factors play a role, but other factors like trust and social relationships also significantly impact happiness levels."),
  tags$p(),
  tags$strong("5. Country-Level Happiness Averages"),
  tags$p("Wide inter-country variations in happiness, with Northern Europe scoring highest (average 7.6) and sub-Saharan Africa lowest (average 3.4)."),
  tags$p("Key factors contributing to these differences include income, healthy life expectancy, social support, perceived freedom, and corruption levels."),
  tags$p(),
  tags$strong('6. Inequality of Happiness'),
  tags$p("Within-country happiness inequality varies significantly."),
  tags$p("High-scoring countries exhibit varying levels of happiness equality. For example, Denmark and the Netherlands show more equality, whereas countries like Costa Rica and the U.S. display greater dispersion."),
  tags$p("Income inequality trends in OECD countries do not necessarily correlate with happiness inequality."),
  tags$p(),
  tags$strong("Conclusion"),
  tags$p("This analysis underscores that happiness is influenced by a complex interplay of economic, social, and institutional factors. The global happiness trend reveals significant regional disparities, influenced by both material and non-material aspects of life.")
)

warandpeace.background.content <- tagList(
  tags$h3("Happiness and Conflict"),
  tags$p("This section delves into the correlation between war and conflict and a country's Happiness Score. The project draws upon one dataset from the Correlates of War Project and two datasets from the ACLED curated data catalog. The correlation between war and conflict and a country's happiness level is explored, recognizing that ongoing conflicts can lead to a decline in the maintenance of social infrastructure. This page examines potential trends between global conflicts and the Happiness Scores of countries, shedding light on the complex interplay between geopolitical factors and well-being."),
  tags$p(),
  tags$strong("The Correlate of War Project:"),
  tags$p("The", tags$span("Inter-State War", style = "color:blue"), "dataset contains wars between the years 1823-2003. The data helps to gain a better understanding of the possible state of countries during the years before the initial scores were taken."),
  tags$p(),
  tags$strong("ACLED Cured Data:"),
  tags$p("The", tags$span("Number of demonstration events by country-year", style = "color:blue"), "and the", tags$span("Number of political violence events by country-month-year", style = "color:blue"), "span between the years 1997-2023. This dataset helps to gain a better understanding of the possible state of countries during the same timeframe as the scores gained from the World Happiness Report.")
)

    # Your existing content goes here
about.COW.content <- tagList(
  tags$h3("The Correlates of War (COW) Project"),
  tags$p("The Correlates of War (COW) project facilitates the collection, dissemination, and use of free resource, quantitative data in international relations."),
  tags$p(),
  tags$strong("The wars identified in this dataset meet certain requirements:"),
  tags$p("I. Wars that take place between or among states (members of the interstate system)"),
  tags$p("II. Sustained combat, involving organized armed forces, resulting in a minimum of 1,000 battle-related combatant fatalities within a 12-month period"),
  tags$p("III. A conflict is categorized as a war when both sides have armed forces capable of “effective resistance”"),
  tags$p(),
  tags$strong("Variables in dataset:"),
  tags$p("WarNum - the number assigned to the war"),
  tags$p("WarName - the name given to the war"),
  tags$p("WarType - 1 = Inter-state war"),
  tags$p("Ccode – the System Membership number (or Country Code) for the state participant"),
  tags$p("State Name - the name of the System Member"),
  tags$p("StartMonth1 - the month in which sustained combat began"),
  tags$p("StartDay1 - the day on which sustained combat began"),
  tags$p("StartYear1 - the year in which sustained combat began"),
  tags$p("EndMonth1 - the month in which sustained combat ended, or the month of the last major engagement after which fatalities declined below the war fatality threshold"),
  tags$p("EndDay1- the day on which sustained combat ended, or the day after the last major engagement after which fatalities declined below the war fatality threshold"),
  tags$p("EndYear1 - the year in which sustained combat ended, or the year of the last major engagement after which fatalities declined below the war fatality threshold"),
  tags$p("StartMonth2 - after a break in the fighting, the month in which sustained combat resumes"),
  tags$p("StartDay2- after a break in the fighting, the day on which sustained combat resumes"),
  tags$p("StartYear2 - after a break in the fighting, the year in which sustained combat resumes"),
  tags$p("EndMonth2 - after fighting resumes, the month in which sustained combat ended, or the month of the last major engagement after which fatalities declined below the war fatality threshold"),
  tags$p("EndDay2- after fighting resumes, the day on which sustained combat ended, or the day after the last major engagement after which fatalities declined below the war fatality threshold:"),
  tags$p("EndYear2 - after fighting resumes, the year in which sustained combat ended, or the year of the last major engagement after which fatalities declined below the war fatality threshold"),
  tags$p("TransFrom - the War"),
  tags$p("WhereFought - Region(s) where combat involving the state occurred. Values are:"),
  tags$p(em("1 = W. Hemisphere")),tags$p(em("2 = Europe")),tags$p(em("4 = Africa")),
  tags$p(em("6 = Middle East")), tags$p(em("7 = Asia")),tags$p(em("9 = Oceania")),
  tags$p(em("11 = Europe & Middle East")),tags$p(em("12 = Europe & Asia")),
  tags$p(em("13 = W. Hemisphere & Asia")),tags$p(em("14 = Europe, Africa & Middle East")),
  tags$p(em("15 = Europe, Africa, Middle East, & Asia")),tags$p(em("16 = Africa, Middle East, Asia & Oceania")),
  tags$p(em("17 = Asia & Oceania")), tags$p(em("18 = Africa & Middle East")),
  tags$p(em("19 = Europe, Africa, Middle East, Asia & Oceania")),
  tags$p("Initiator - whether the state initiated the war"),
  tags$p(em("1 = Yes")),tags$p(em("2 = No")),
  tags$p("TransTo - the WarNum of the war that this war transformed into"),
  tags$p("Outcome code"),tags$p(em("1 = Winner")),tags$p(em("2 = Loser")),
  tags$p(em("3 = Compromise/Tied")),
  tags$p(em("4 = The war was transformed into another type of war")),
  tags$p(em("5 = The war is ongoing as of 12/31/2007")),
  tags$p(em("6 = Stalemate")),
  tags$p(em("7 = Conflict continues at below war level")),
  tags$p(em("8 = changed sides")),
  tags$p("BatDeaths - the battle-related combatant fatalities suffered by the state"),
  tags$p(strong("Important: "), "-9 = unknown, -7 = war ongoing as of 12/31/2007, -8 = Not applicable")
)

about.ACLED.content <- tagList(
  tags$h3("The ACLED Data Project"),
  tags$p("The ACLED is an event-based data project designed for disaggregated conflict analysis and crisis mapping."),
  tags$p(),
  tags$p("Demonstrations: All protest and violent demonstration events (may overlap with political violence files as they both include Excessive force against protesters)"),
  tags$p("Political Violence: All battle, explosions/remote violence, and violence against civilians events"),
  tags$p(),
  tags$strong("Variables in dataset:"),
  tags$p("Country - Country it occurred"),
  tags$p("Month - month it occurred"),
  tags$p("Year - year it occurred"),
  tags$p("Events - Occurrence of Instances")
)

works.cited.content <- tagList(
  tags$h3("References"),
  tags$p(
  tags$em("COW War Data, 1816 – 2007 (v4.0) – Correlates of War"),
  ". (2020). Correlatesofwar.org. ",
  tags$a(href = "https://correlatesofwar.org/data-sets/cow-war/", "https://correlatesofwar.org/data-sets/cow-war/")),
  tags$p(
  tags$em("Curated Data - ACLED"),
  ". (2023, August 15). ACLED. ",
  tags$a(href = "https://acleddata.com/curated-data-files/#peacekeepers", "https://acleddata.com/curated-data-files/#peacekeepers")
  ),
  tags$p(
  tags$em("Facebook logo"),
  ". (2023). R-Charts.com. ",
  tags$a(href = "https://r-charts.com/distribution/dumbbell-plot-ggplot2/", "https://r-charts.com/distribution/dumbbell-plot-ggplot2/")
  ),
  tags$p(
  "Holtz, Y. (2023).",
  tags$em("The R Graph Gallery – Help and inspiration for R charts"),
  ". The R Graph Gallery. ",
  tags$a(href = "https://r-graph-gallery.com/", "https://r-graph-gallery.com/")),
  tags$p(
  tags$em("Shiny - Build a user interface"),
  ". (2023). Posit.co. ",
  tags$a(href = "https://shiny.posit.co/r/getstarted/shiny-basics/lesson2/", "https://shiny.posit.co/r/getstarted/shiny-basics/lesson2/")),
  tags$p(
  "to, I. (2023, January 12).",
  tags$em("Introduction to Data Visualization with ggplot2"),
  ". Datacamp.com; DataCamp. ",
  tags$a(href = "https://www.datacamp.com/courses/introduction-to-data-visualization-with-ggplot2", "https://www.datacamp.com/courses/introduction-to-data-visualization-with-ggplot2"))
)













# source("InterState.R")
# source("IntraState.R")
# source("Violence.Demontration.Country.R")
# 
# # InterState Analysis
# summary(interStateWar.clean)
# 
# # ANAYLSIS: the majority of the wars are between 1 and 2 years. This data set is right
# # skewed as we can see that out max is 10 years but 50% of the data fell
# # between 0.178 and 2.447 years.
# 
# # ANAYLSIS: We can see the summary for the column "Outcome' which mainly ranges between 1
# # and 2. this Category is more so categorical than numeric since each number refers to the
# # outcome of each country. If you look at documentation, then we can se that a majority of
# # outcomes results in a win or loss.
# 
# summary(inter.region.continent.join)
# # ANAYLSIS: There is a right skew to the graph where a majority of countries are in a
# # war 2-3 times on a continent
# 
# print(war.count.by.continent)
# summary(war.count.by.continent)
# 
# # most battles are fought in Europe, Middle East, and Asia
# 
# # Asian front: The increase in battles on the Asian front could be a result of
# # communist ideology spreading in Cambodia, China, and Vietnam. This
# # time frame could be around the 1930-1970
# 
# # Middle East: The wars fought in the Middle Eastern front could be
# # in relation of revolt and revolution. In my opinion it would be categorized
# # as wars for statehood. Later wars could relate to 'War on Terrorism`` imposed
# # by the US
# 
# # Europe: We have the WWI(1917) and WWII(1940) which was fought on many different fronts.
# # Europe seems to be dealing with battles among each other.
# 
# # America: Besides WW's, cold war, and 9/11, I would assume manifest destiny (1845) is playing a part in
# # some of their earlier wars
# 
# # Africa: was colonized by the Europeans and during this timefrme, these countries were
# # losing control of strict governance over country so their activities did not meet requirement
# # of war to show up in file.
# 
# # INTERESTING: look at distribution based on date
# 
# print(war.count.by.country.continent)
# summary(war.count.by.country.continent)
# 
# summary(war.participation.by.country)
# 
# top.25 <- as.data.frame(war.participation.by.country[
#   war.participation.by.country$total > quantile(war.participation.by.country$total,
#                                    total.world.mapprob=.75),])
# print(top.25)
# # ANAYLSIS: Looking at countries, and counting number of interstate wars they have participated in
# # we can see that France is at the top with 21 appearances
# 
# # CAVEAT: There may be some wars that are continued from another. this can be determined by looking at
# # Transto column. There are very few wars that meet this requirement so we count those that transition into
# # a different war as different instances
# 
# # BIASIS: From the data we can see that wars fought in W.Hemisphere, Africa, and Oceania is comparatively
# # smaller than those of Europe, Middle East, and Asia. This could suggest that the data is skewed
# # more to the western thought/western focus on wars. There may be a lake of information about countries
# # that are not super powers
# 
# # ANAYLSIS: Besides countries that reside within the continent, the next largest regional powers to fight
# # on the continent is Western Europe and North America. This suggests a correlation between the colonial past
# # and control that Western Europe had on each continent. It may also suggests who is the world power in war right
# # now. For instance Western Europe has a lot of political power, but the USA has the largest military might.
# 
# # A Treemap may be a good option to look at region.continent.join
# 
# 
# table(interStateWar.clean$Outcome)
# 
# table(total.distinct.wars$StartYear1)
# # 1914: WWII | There could have been an increase in wars due to fractional disrepare in the government after the
# # WW. On average there seemes to be 1-2 wars a year (this does not look at the duration so a country may end in
# # a year not listed in the table)
# 
# summary(violent.event.per.year)
# head(arrange(violent.event.per.year,desc(TotalEvents)), n = 10)
# # Majority of violent events look to be focused on areas centered near the equator,
# # areas such as the middle east and northern Africa, Central and South America, as well as
# # some Asian countries.
# 
# summary(demonstration.event.per.year)
# head(arrange(demonstration.event.per.year,desc(TotalEvents)), n = 10)
# 
# summary(demonstration.event.per.country)
# we can try an compare the overall distribution of the whi index and cross analysis with the
# occurrence of violent events in that country

# top_happiness <- whi.df.clean %>%
#   group_by(Country.Name) %>%
#   summarise(Life.Ladder = mean(Life.Ladder, na.rm = TRUE), confidence = mean(Confidence.In.National.Government, na.rm = TRUE)) %>%
#   arrange(desc(Life.Ladder)) %>%
#   head(15)
# 
# # Stats
# ###################################################################################################
# summary(pandemic.years)
# summary(non.pandemic.years)
# 
# # The most missing data is in relation to the national government,
# # The Perceptions.Of.Corruption and Confidence.In.National.Government
# 
