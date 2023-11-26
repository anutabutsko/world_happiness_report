library(dplyr)
library(ggplot2)
library(ggeasy)

df <- read.csv("HappyDataFrame.csv")


world_perception <- df %>%
  group_by(Country.Name) %>% 
  summarise(Life.Ladder = mean(Life.Ladder), Perceptions.Of.Corruption = mean(Perceptions.Of.Corruption)) %>%
  ggplot(aes(Life.Ladder, Perceptions.Of.Corruption)) +
  geom_point(alpha=0.2, color="gold") + 
  geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
  labs(title="Relationship between Perceptions of Corruption\nand Happiness Index Across the World", x="Happiness", y="Corruption") +
  ggeasy::easy_center_title() +
  geom_text(aes(label=Country.Name), vjust=-1, size=1.8)

world_perception

corruption_regression <- function(df, continent){
  corruption <- df %>%
    filter(Continent==continent) %>%
    group_by(Country.Name) %>% 
    summarise(Life.Ladder = mean(Life.Ladder), Perceptions.Of.Corruption = mean(Perceptions.Of.Corruption)) %>%
    ggplot(aes(Life.Ladder, Perceptions.Of.Corruption)) +
    geom_point(alpha=0.5, color="gold") + 
    geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
    labs(title=continent, x="Happiness", y="Corruption") +
    ggeasy::easy_center_title()
  return(corruption)
}

cor_america <- corruption_regression(df, "Americas")
cor_asia <- corruption_regression(df, "Asia")
cor_europe <- corruption_regression(df, "Europe")
cor_africa <- corruption_regression(df, "Africa")

combined_plot <- ggarrange(cor_america, cor_asia, cor_europe, cor_africa, ncol = 2, nrow =2, common.legend = TRUE, legend="bottom")

final_plot <- annotate_figure(combined_plot, top = text_grob("Relationship between Perceptions of Corruption\nand Happiness Index", face = "bold", size = 13))
final_plot


top_happiness <- df %>%
  group_by(Country.Name) %>%
  summarise(Life.Ladder = mean(Life.Ladder, na.rm = TRUE), corruption = mean(Perceptions.Of.Corruption, na.rm = TRUE)) %>%
  arrange(desc(Life.Ladder)) %>%
  head(15)

top_perception <- top_happiness %>%
  ggplot(aes(Life.Ladder, corruption, color=Life.Ladder)) +
  geom_point(show.legend = FALSE) + 
  geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
  labs(title="Relationship between Confidence in\nNational Government and Happiness Index", subtitle="Top 15 Happiest Countries", x="Happiness", y="Confidence") +
  geom_text(aes(label=Country.Name), color="black", vjust=-1, size=2.3)

top_perception

low_happiness <- df %>%
  group_by(Country.Name) %>%
  summarise(Life.Ladder = mean(Life.Ladder, na.rm = TRUE), corruption = mean(Perceptions.Of.Corruption, na.rm = TRUE)) %>%
  arrange(Life.Ladder) %>%
  head(15)

low_perception <- low_happiness %>%
  ggplot(aes(Life.Ladder, corruption, color=Life.Ladder)) +
  geom_point(show.legend = FALSE) + 
  geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
  labs(title="Relationship between Confidence in\nNational Government and Happiness Index", subtitle="Top 15 Unhappies Countries", x="Happiness", y="Confidence")+
  geom_text(aes(label=Country.Name), color="black", vjust=-1, size=2.3)

low_perception
