source("DataAnaylsis.R")
source("FunctionFile.R")
source("whi.R")
source("InterState.R")
source("Violence.Demontration.Country.R")

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
  theme_minimal() +
  geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
  labs(title="Relationship between Confidence in National Government\nand Happiness Index",
       x="Happiness", y="Confidence") +
  scale_color_continuous(name="Happiness\nIndex") +
  ggeasy::easy_center_title()

stackedbarbyRegion <- function(data, Continent){
  if (Continent=='Overview'){
    stacked.bar<- data%>%
      ggplot(aes(fill=Outcome, y=n, x=region)) + 
      geom_bar(position="fill", stat="identity")+
      theme(legend.position = 'bottom', axis.text.x = element_blank(),
            axis.title.x = element_blank())+
      theme_minimal() 
  }
  else {
  stacked.bar <- data%>%
    filter(region == Continent) %>%
    ggplot(aes(fill=Outcome, y=n, x=StateName)) + 
    geom_bar(position="stack", stat="identity")+
    theme_minimal() +
    theme(legend.position = 'bottom', axis.text.x = element_blank(),
          axis.title.x = element_blank())
  }
  return(stacked.bar)
}

scatter.plot.GDP.By.Continent <- data %>%
  ggplot(aes(x=region, y=Log.GDP.Per.Capita, color=region)) +
  geom_point(alpha = 0.15, position="jitter") +
  geom_point(data=by_continent, size=4) +
  theme_minimal() +
  geom_text(data=by_continent, aes(label=paste0("n=", n), y=5, color=NULL)) +
  labs("title" = "Distribution of GDP per Capita by Continent", y="GDP per Capita")

GDP.Confidence <- data %>%
  ggplot(aes(Log.GDP.Per.Capita, Confidence.In.National.Government,
             color=Log.GDP.Per.Capita)) +
  geom_point() +
  theme_minimal() +
  geom_smooth(lty=1, aes(col=Log.GDP.Per.Capita), span=0.005)


density.of.GDP.By.SubRegion <- data %>%
  ggplot(aes(Log.GDP.Per.Capita,
               alpha=Log.GDP.Per.Capita,
               y = as.factor(sub.region),
               fill=as.factor(sub.region))) +
  theme_minimal() +
  geom_density_ridges(alpha=0.4,
                      adjust=0.05,
                      position="identity", show.legend=FALSE) +
  scale_alpha_continuous()


histogram.of.GDP.By.SubRegion<- data %>%
  ggplot(aes(Log.GDP.Per.Capita,
             fill=as.factor(Regional.Indicator))) + geom_histogram(col="white")+
  theme_void() 

coul <- brewer.pal(n = 200, name = "YlOrRd") 
life.ladder.plot <- ggplot(world.map, aes(long, lat, group=group)) +
  geom_polygon(aes(fill=Life.Ladder, text = Country),
               color = "black",size = 0.2) +
  coord_quickmap() +
  theme_minimal() +
  scale_fill_gradientn(colors = coul, name = "Life.Ladder")+
  theme(legend.position='bottom') +
  ggeasy::easy_center_title()


correlation.matrix <- ggcorr(data[,4:13])

top_happiness <- data %>%
  group_by(Country.Name) %>%
  summarise(Life.Ladder = mean(Life.Ladder, na.rm = TRUE), 
            confidence = mean(Confidence.In.National.Government, na.rm = TRUE)) %>%
  arrange(desc(Life.Ladder)) %>%
  head(15)

top_perception <- top_happiness %>%
  ggplot(aes(Life.Ladder, confidence, color=Life.Ladder)) +
  geom_point(show.legend = FALSE) + 
  geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
  theme_minimal() +
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
    theme_void() +
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
    theme_void() +
    facet_wrap(~Country.Name, scales = "free_y", ncol = 3) +
    guides(color = FALSE) +  # Turn off the color legend
  return(sub.region.trend.by.Country)
}

happiness.trend <- data %>%
  group_by(Year, region) %>%
  summarise(avg = mean(Life.Ladder, na.rm = TRUE)) %>%
  ggplot(aes(x = Year, y = avg, color = region)) +
  geom_line(linetype='dashed') +
  theme_minimal() +
  scale_color_viridis(discrete=TRUE) +
  geom_point(size=3, alpha=0.5) +
  labs(y="Happiness Level") +
  ggeasy::easy_center_title()

top_trend <- data %>%
  filter(Country.Name == "Denmark") %>%
  ggplot(aes(Year, Life.Ladder)) +
  theme_minimal() +
  geom_line(linetype='dashed', color = "darkblue") +
  geom_point(size=3, alpha=0.5, color = "darkblue") +
  geom_smooth(method='lm', colour = "black", se = FALSE, size=0.3) +
  labs(title="Top Country: Denmark", y="Happiness Score")


low_trend <- data %>%
  filter(Country.Name == "Afghanistan") %>%
  ggplot(aes(Year, Life.Ladder)) +
  theme_minimal() +
  geom_line(linetype='dashed', color = "darkorange") +
  geom_point(size=3, alpha=0.5, color = "darkorange") +
  geom_smooth(method='lm', colour = "black", se = FALSE, size=0.3) +
  labs(title="Worst Country: Afghanistan", y="Happiness Score")


combined_plot <- ggarrange(top_trend, low_trend, ncol = 1, nrow =2)

final_plot <- annotate_figure(combined_plot, 
                              top = text_grob("Happiness Trend Across Years", 
                                              face = "bold", size = 16))

stacked.violence <- violent.event.per.year%>%
  filter(!is.na(region))%>%
  ggplot(aes(fill=region, y=TotalEvents, x=Year)) + 
  geom_bar(position = "fill", stat = "identity",color = 'grey30', size = 0.2) +
  theme_minimal() +
  scale_fill_brewer(palette = "YlOrRd", name = "Region", type = "qual")

stacked.demonstrations <- demonstration.event.per.year%>%
  filter(!is.na(region))%>%
  ggplot(aes(fill=region, y=TotalEvents, x=Year)) + 
  geom_bar(position = "fill", stat = "identity", color = "grey30", size = 0.2) +
  theme_minimal() +
  scale_fill_brewer(palette = "YlOrRd", name = "Region", type = "qual")

life.Ladder.Difference.by.country <- function(df, regionselected){
  plot <- df%>%
    filter(region == regionselected)%>%
    ggplot(aes(y = Country.Name, x = Start.Life.Ladder, 
                                  xend = Start.Life.Ladder + Life.Ladder.Difference)) +
    geom_dumbbell(
      aes(color = ifelse(Life.Ladder.Difference < 0, 'grey10', 'seagreen3')),  # Color of the line
      size = 0.5,            # Line width
      dot_guide = FALSE,   # Whether to add a guide from origin to X or not
      size_x = 1,          # Size of the X point
      size_xend = 1,       # Size of the X end point
      colour_x = "red",    # Color of the X point
      colour_xend = "blue"  # Color of the X end point
    ) + theme_minimal() +
    scale_color_identity()+  # To ensure color mapping works as expected
    xlab('Happiness Index Trend')+
    ylab("Countries")
  return(plot)
}

# Convert to factor with custom levels
top.bottom.plot<- top.bottom%>%
  arrange(Life.Ladder) %>%  # Arrange in descending order
  mutate(Country.Name = factor(Country.Name, levels = Country.Name))%>%
ggplot(aes(x=Life.Ladder, y=Country.Name, color = color)) +
  geom_point() + 
  geom_segment( aes(x=0, xend=Life.Ladder, y=Country.Name, yend=Country.Name), size = 1)+
  theme_minimal()+
  scale_color_identity()+
  guides(color = FALSE) 

ggplotly(test, tooltip = "Life.Ladder")
