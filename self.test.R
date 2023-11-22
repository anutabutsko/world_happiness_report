look <- ggplot(country.join, aes(x = Year, y = Events, col= region))+
  geom_point(size = 0.3, position = 'jitter')

data analysis

# Dictionary to map numeric values to categories
wherefought.category <- c(
  `1` = 'W. Hemisphere', `2` = 'Europe', `4` = 'Africa', `6` = 'Middle East',
  `7` = 'Asia', `9` = 'Oceania', `11` = 'Europe & Middle East', `12` = 'Europe & Asia',
  `13` = 'W. Hemisphere & Asia', `14` = 'Europe, Africa & Middle East',
  `15` = 'Europe, Africa, Middle East, & Asia',
  `16` = 'Africa, Middle East, Asia & Oceania',
  `17` = 'Asia & Oceania', `18` = 'Africa & Middle East',
  `19` = 'Europe, Africa, Middle East, Asia & Oceania'
)


continent.region.uni <- function(df){
  df <- df %>%
    mutate(region.mirror = case_when(
      `sub-region` == 'Western Asia' ~ 'Middle East',
      str_detect(`sub-region`, 'Europe') ~ 'Europe',
      str_detect(`sub-region`, 'Africa') ~ 'Africa',
      str_detect(`sub-region`, 'America') ~ 'W. Hemisphere',
      str_detect(`sub-region`, 'Australia') ~ 'Oceania',
      (is.na(`sub-region`))~ `Continent`, 
      TRUE ~ `sub-region`  # Default case when none of the conditions are met
    ))
  
}