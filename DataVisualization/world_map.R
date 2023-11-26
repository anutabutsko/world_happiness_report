library(maps)
library(dplyr)
library(ggplot2)
library(plotly)
library(viridis)
library(ggridges)
library(data.table)
library(ggeasy)

world.map <- map_data(map = "world")
world.map <- world.map%>%
  rename(Country.Name = region)
View(world.map)
unique_world_map <- unique(world.map$Country.Name)

unique_df <- unique(df$Country.Name)

# Names in df that do not match names in world.map
names_not_in_world_map <- setdiff(unique_df, unique_world_map)
names_not_in_world_map2 <- setdiff(unique_world_map, unique_df)

# change the names to match df
world.map <- world.map %>%
  mutate(Country.Name = replace(Country.Name, Country.Name == "USA", "United States")) %>%
  mutate(Country.Name = replace(Country.Name, Country.Name %in% c("Democratic Republic of the Congo", "Republic of Congo"), "Congo (Brazzaville)")) %>%
  mutate(Country.Name = replace(Country.Name, Country.Name == "UK", "United Kingdom"))%>%
  mutate(Country.Name = replace(Country.Name, Country.Name == "Czech Republic", "Czechia"))%>%
  mutate(Country.Name = replace(Country.Name, Country.Name %in% c('Trinidad', 'Tobago'), "Trinidad and Tobago"))%>%
  mutate(Country.Name = replace(Country.Name, Country.Name == 'Swaziland', "Eswatini"))

df <- df %>%
  mutate(Country.Name = replace(Country.Name, Country.Name == "Hong Kong S.A.R. of China", "China"))%>%
  mutate(Country.Name = replace(Country.Name, Country.Name == "Taiwan Province of China", "Taiwan"))%>%
  mutate(Country.Name = replace(Country.Name, Country.Name == "State of Palestine", "Palestine"))%>%
  mutate(Country.Name = replace(Country.Name, Country.Name == "Turkiye", "Turkey"))%>%
  mutate(Country.Name = replace(Country.Name, Country.Name == "Somaliland region", "Somalia"))

by.part <- c("Country.Name" = "Country.Name")
world.map <- left_join(world.map, df, by.part)

world.map <- world.map[order(world.map$order),]

life.ladder.plot <- ggplot(world.map, aes(long, lat, group=group)) +
  geom_polygon(aes(fill=Life.Ladder, text = Country.Name),size = 0.2) +
  coord_quickmap() +
  theme_void() +
  scale_fill_viridis(option='magma', name="Index") +
  theme(legend.position='bottom') +
  labs(title="Happiness Index across the World") +
  ggeasy::easy_center_title()

ggplotly(life.ladder.plot, tooltip = c("text", "Life.Ladder"))
