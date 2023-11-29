source("DataAnaylsis.R")
source("FunctionFile.R")
source("whi.R")
source("InterState.R")


# # Initial Completeness Table For Files
# print(whi.table)
# print(interStateWar.table)
# print(intraStateWar.table)
# print(demonstration.table)
# 
# 
# # Stats
# ###################################################################################################
# 
# # correlation matrix within the whi.df
# ggpairs(data[,4:13], title="correlogram of years not in pandemic",
#         method = c("everything", "pearson"))
# corality.non <- ggcorr(non.pandemic.years[,4:13]) 
# ggplotly(corality.non)
# 
# 
# ggpairs(pandemic.years[,4:13], title="correlogram of pandemic years", 
#         method = c("everything", "pearson")) 
# corality.pan <- ggcorr(pandemic.years[,4:13]) 
# ggplotly(corality.pan)
# 
# # The major difference/ change in signage although very samll since the correlation
# # was already very week was related to generosity and healthly life expectancy at birth
# # and generosity and log.GDP.Per.Capita.
# # Something we want to be aware of is which countries are reporting during these time frmaes
# 
# # Analysis: There is very little correlation between generosity and GDP per
# # capita at 0.7%. Overall, there does not seem to be a correlation between the two.
# # We may be seeing a Simpsons paradox and would want to filter on location of country or
# # some other factor

# copy
data <- whi.df.clean

world_perception <- data %>%
  group_by(Country.Name) %>%
  summarise(Life.Ladder = mean(Life.Ladder, na.rm = TRUE),
            Confidence.In.National.Government = mean(Confidence.In.National.Government, na.rm = TRUE)) %>%
  ggplot(aes(Life.Ladder, Confidence.In.National.Government, color=Life.Ladder)) +
  geom_point() +
  geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
  labs(title="Relationship between Confidence in National Government\nand Happiness Index",
       x="Happiness", y="Confidence") +
  scale_color_continuous(name="Happiness\nIndex") +
  ggeasy::easy_center_title()


histo.GDP.by.Sub.Region <- data %>%
  ggplot(aes(Log.GDP.Per.Capita,
             fill=as.factor(sub.region))) + geom_histogram(col="white")

violin.GDP.by.Continent <- data %>%
  ggplot(aes(y = region, x = Log.GDP.Per.Capita)) +
  geom_violin(aes(fill = region), alpha = 0.5, color = NA, scale = "area") +
  geom_boxplot(aes(fill = NA), alpha = 0.3, width = 0.15, outlier.alpha = 1) +
  scale_fill_viridis(discrete = TRUE, name = "Continent") +
  labs(title = "Distribution of GDP per Capita by Continent",
       x = "GDP per Capita", y = "Continent")

scatter.plot.GDP.By.Continent <- data %>%
  ggplot(aes(x=region, y=Log.GDP.Per.Capita, color=region)) +
  geom_point(alpha = 0.15, position="jitter") +
  geom_point(data=by_continent, size=4) +
  geom_text(data=by_continent, aes(label=paste0("n=", n), y=5, color=NULL)) +
  labs("title" = "Distribution of GDP per Capita by Continent", y="GDP per Capita")

GDP.Confidence <- data %>%
  ggplot(aes(Log.GDP.Per.Capita, Confidence.In.National.Government,
             color=Log.GDP.Per.Capita)) +
  geom_point() +
  geom_smooth(lty=1, aes(col=Log.GDP.Per.Capita), span=0.005)


density.of.GDP.By.SubRegion <- data %>%
  ggplot(aes(Log.GDP.Per.Capita,
               alpha=Log.GDP.Per.Capita,
               y = as.factor(sub.region),
               fill=as.factor(sub.region))) +
  geom_density_ridges(alpha=0.4,
                      adjust=0.05,
                      position="identity", show.legend=FALSE) +
  scale_alpha_continuous()


histogram.of.GDP.By.SubRegion<- data %>%
  ggplot(aes(Log.GDP.Per.Capita,
             fill=as.factor(Regional.Indicator))) + geom_histogram(col="white")


life.ladder.plot <- ggplot(world.map, aes(long, lat, group=group)) +
  geom_polygon(aes(fill=Life.Ladder, text = Country.Name),
               color = "black",size = 0.2) +
  coord_quickmap() +
  theme_void() +
  scale_fill_viridis(option='magma', name="Index") +
  theme(legend.position='bottom') +
  ggeasy::easy_center_title()


corrality <- ggpairs(data[,4:13],
        method = c("everything", "pearson"))+
  theme(axis.text.y = element_blank(),  # removing x or y axis labels
        axis.title.y = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x = element_blank())


correlation.matrix <- ggcorr(data[,4:13])

top_happiness <- data %>%
  group_by(Country.Name) %>%
  summarise(Life.Ladder = mean(Life.Ladder, na.rm = TRUE), confidence = mean(Confidence.In.National.Government, na.rm = TRUE)) %>%
  arrange(desc(Life.Ladder)) %>%
  head(15)

top_perception <- top_happiness %>%
  ggplot(aes(Life.Ladder, confidence, color=Life.Ladder)) +
  geom_point(show.legend = FALSE) + 
  geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
  labs(title="Relationship between Confidence in\nNational Government and Happiness Index", subtitle="Top 15 Happiest Countries", x="Happiness", y="Confidence") +
  geom_text(aes(label=Country.Name), color="black", vjust=-1, size=2.3)

regression_lines_of_indicators <- function(data, continent, indicator){
  corruption <- data %>%
    filter(region==continent) %>%
    #group_by(Country.Name) %>%
    #summarise(Life.Ladder = mean(Life.Ladder),
              #Perceptions.Of.Corruption = mean(indicator)) %>%
    ggplot(aes(Life.Ladder, !!sym(indicator))) +
    geom_point(alpha=0.5) +
    geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
    labs(title=continent, x="Happiness", y=indicator) +
    ggeasy::easy_center_title()
  return(corruption)
}


time.series.happiness <- function(data, subRegion){
  sub.region.trend.by.Country <- data %>%
    filter(sub.region == subRegion) %>%
    ggplot(aes(x = Year, y = Life.Ladder, color = Country.Name)) +
    geom_line(show.legend = FALSE) +
    xlab("") +
    facet_wrap(~Country.Name, scales = "free_y", ncol = 3) +
    guides(color = FALSE) +  # Turn off the color legend
    theme_minimal()
  return(sub.region.trend.by.Country)
}

happiness.trend <- data %>%
  group_by(Year, region) %>%
  summarise(avg = mean(Life.Ladder, na.rm = TRUE)) %>%
  ggplot(aes(x = Year, y = avg, color = region)) +
  geom_line(linetype='dashed') +
  scale_color_viridis(discrete=TRUE) +
  geom_point(size=3, alpha=0.5) +
  labs("title" = "Happiness Level Across Years by Continent", y="Happiness Level") +
  ggeasy::easy_center_title()


# treemap.conflict <- treemap(inter.region.continent.join,
#         index = c('Continent', 'region.mirror'),
#         vSize = 'Occurrence',
#         type = 'index')


# corruption_gen <- data %>%
#   ggplot(aes(x = Life.Ladder, y = Perceptions.Of.Corruption, 
#              color = region)) + geom_point() +
#   geom_smooth(fill = "transparent",
#               method = "lm", formula = y ~ x,
#               size = 3, linewidth = 1, boxlinewidth = 0.4) +
#   theme_modern_rc() + guides(color = 'none')
# ggplotly(corruption_gen)
# 
# corruption <- data %>%
#   group_by(sub.region, Year) %>%
#   summarise(Life.Ladder = mean(Life.Ladder),
#             Perceptions.Of.Corruption = mean(Perceptions.Of.Corruption)) %>%
# ggplot(aes(x = Life.Ladder, y = Perceptions.Of.Corruption, 
#                  color = sub.region)) + geom_point() +
#   geom_smooth(fill = "transparent",
#                    method = "lm", formula = y ~ x,
#                    size = 3, linewidth = 1, boxlinewidth = 0.4) +
#   theme_modern_rc() + guides(color = 'none')
# ggplotly(corruption)
