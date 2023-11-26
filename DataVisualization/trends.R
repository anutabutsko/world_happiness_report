library(dplyr)
library(ggplot2)
library(ggeasy)


df <- read.csv("HappyDataFrame.csv")


trend <- df %>%
  group_by(Year, Continent) %>%
  summarise(avg = mean(Life.Ladder, na.rm = TRUE)) %>%
  ggplot(aes(x = Year, y = avg, color = Continent)) +
  geom_line(linetype='dashed') +
  scale_color_viridis(discrete=TRUE) +
  geom_point(size=3, alpha=0.5) +
  labs("title" = "Happiness Level Across Years by Continent", y="Happiness Level") +
  ggeasy::easy_center_title()

trend

top_trend <- df %>%
  filter(Country.Name == "Denmark") %>%
  ggplot(aes(Year, Life.Ladder)) +
  geom_line(linetype='dashed', color = "forestgreen") +
  geom_point(size=3, alpha=0.5, color = "forestgreen") +
  geom_smooth(method='lm', colour = "black", se = FALSE, size=0.3) +
  labs(title="Top Country: Denmark", y="Happiness Score")


low_trend <- df %>%
  filter(Country.Name == "Afghanistan") %>%
  ggplot(aes(Year, Life.Ladder)) +
  geom_line(linetype='dashed', color = "darkorange") +
  geom_point(size=3, alpha=0.5, color = "darkorange") +
  geom_smooth(method='lm', colour = "black", se = FALSE, size=0.3) +
  labs(title="Worst Country: Afghanistan", y="Happiness Score")


combined_plot <- ggarrange(top_trend, low_trend, ncol = 1, nrow =2)

final_plot <- annotate_figure(combined_plot, top = text_grob("Happiness Trend Across Years", face = "bold", size = 16))
final_plot
