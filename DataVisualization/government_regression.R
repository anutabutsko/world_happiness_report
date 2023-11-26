library(dplyr)
library(ggplot2)
library(ggeasy)


df <- read.csv("HappyDataFrame.csv")

world_perception <- df %>%
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

world_perception

government_regression <- function(df, continent){
  government <- df %>%
    filter(Continent==continent) %>%
    group_by(Country.Name) %>% 
    summarise(Life.Ladder = mean(Life.Ladder, na.rm = TRUE), 
              Confidence.In.National.Government = mean(Confidence.In.National.Government, na.rm = TRUE)) %>%
    ggplot(aes(Life.Ladder, Confidence.In.National.Government, color=Life.Ladder)) +
    geom_point() + 
    geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
    labs(title=continent, x="Happiness", y="Confidence") +
    scale_color_continuous(name="Happiness\nIndex") +
    ggeasy::easy_center_title()
  return(government)
}

gov_america <- government_regression(df, "Americas")
gov_europe <- government_regression(df, "Europe")
gov_africa <- government_regression(df, "Africa")
gov_asia <- government_regression(df, "Asia")

combined_plot <- ggarrange(gov_america, gov_asia, gov_europe, gov_africa, ncol = 2, nrow =2, common.legend = TRUE, legend="bottom")

final_plot <- annotate_figure(combined_plot, top = text_grob("Relationship between Confidence in National Government and Happiness Index", face = "bold", size = 13))
final_plot


top_happiness <- df %>%
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

top_perception

low_happiness <- df %>%
  group_by(Country.Name) %>%
  summarise(Life.Ladder = mean(Life.Ladder, na.rm = TRUE), confidence = mean(Confidence.In.National.Government, na.rm = TRUE)) %>%
  arrange(Life.Ladder) %>%
  head(15)

low_perception <- low_happiness %>%
  ggplot(aes(Life.Ladder, confidence, color=Life.Ladder)) +
  geom_point(show.legend = FALSE) + 
  geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
  labs(title="Relationship between Confidence in\nNational Government and Happiness Index", subtitle="Top 15 Unhappies Countries", x="Happiness", y="Confidence")+
  geom_text(aes(label=Country.Name), color="black", vjust=-1, size=2.3)

low_perception
