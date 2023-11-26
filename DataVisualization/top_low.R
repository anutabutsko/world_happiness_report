library(dplyr)
library(ggplot2)

df <- read.csv("HappyDataFrame.csv")

top_happiness <- df %>% 
  group_by(Country.Name) %>% 
  summarise(Life.Ladder = mean(Life.Ladder)) 

top_happiness <- top_happiness %>%
  arrange(desc(Life.Ladder)) %>% 
  head(15)

top <- ggplot(top_happiness, aes(x = reorder(Country.Name, -Life.Ladder), y = Life.Ladder)) +
  geom_bar(stat = "identity", fill = "royalblue") +
  labs(title = "Countries with the Highest Happiness Score", x = "Country", y = "Happiness Score") +
  geom_text(aes(label = round(Life.Ladder,2), vjust = -.5, fontface = "italic"), show.legend = FALSE, size = 3.5 ) +
  theme(axis.text.x = element_text(angle = -90, hjust = 0, vjust = 0))

low_happiness <- df %>% 
  group_by(Country.Name) %>% 
  summarise(Life.Ladder = mean(Life.Ladder)) 

low_happiness <- low_happiness %>%
  arrange(Life.Ladder) %>% 
  head(15)

low <- ggplot(low_happiness, aes(x = reorder(Country.Name, -Life.Ladder), y = Life.Ladder)) +
  geom_bar(stat = "identity", fill = "darkorange") +
  labs(title = "Countries with the Lowest Happiness Score", x = "Country", y = "Happiness Score") +
  geom_text(aes(label = round(Life.Ladder,2), vjust = -.5, fontface = "italic"), show.legend = FALSE, size = 3.5 ) +
  theme(axis.text.x = element_text(angle = -90, hjust = 0, vjust = 0))

top
low
