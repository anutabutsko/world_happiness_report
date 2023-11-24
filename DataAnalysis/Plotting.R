source("DataAnaylsis.R")
source("whi.R")
# source("InterState.R")

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

# by_continent <- whi.df.clean %>%
#   group_by(region) %>%
#   summarise(n = n(), Log.GDP.Per.Capita = mean(Log.GDP.Per.Capita, na.rm = TRUE))
  
data <- whi.df.clean

violin.GDP.by.Continent <- data %>%
  ggplot(aes(y = region, x = Log.GDP.Per.Capita)) +
  geom_violin(aes(fill = region), alpha = 0.5, color = NA, scale = "area") +
  geom_boxplot(aes(fill = NA), alpha = 0.3, width = 0.15, outlier.alpha = 1) +
  scale_fill_viridis(discrete = TRUE, name = "Continent") +
  labs(title = "Distribution of GDP per Capita by Continent", x = "GDP per Capita", y = "Continent")

scatter.plot.GDP.By.Continent <- data %>%
  ggplot(aes(x=region, y=Log.GDP.Per.Capita, color=region)) +
  geom_point(alpha = 0.15, position="jitter") +
  geom_point(data=by_continent, size=4) +
  geom_text(data=by_continent, aes(label=paste0("n=", n), y=5, color=NULL)) +
  labs("title" = "Distribution of GDP per Capita by Continent", y="GDP per Capita")

GDP.Confidence <- data %>%
  ggplot(aes(Log.GDP.Per.Capita, Confidence.In.National.Government, color=Log.GDP.Per.Capita)) +
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
