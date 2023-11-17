setwd('/Users/yuhanburgess/Documents/GitHub/world_happiness_report/')
source("DataAnaylsis.R")

intraStateWar.event <- read_csv('Intra-StateWarData_v4.1.csv')

intraStateWar.clean <- intraStateWar.event%>%
  # changing the values that represent NA and unknown to NA values 
  mutate_all(~ifelse(.== -9 | .== -8, NA, . ))%>%
  # removing column containing version of csv file 
  select(-c(Version))
intraStateWar.table <- completeness(intraStateWar.clean, 'Intra-state War')