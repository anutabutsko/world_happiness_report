setwd('/Users/yuhanburgess/Documents/GitHub/world_happiness_report/')
source("DataAnaylsis.R")

intraStateWar.event <- read_csv('Intra-StateWarData_v4.1.csv')

intraStateWar.clean <- StateWar.filter(intraStateWar.event)

intraStateWar.table <- completeness(intraStateWar.clean, 'Intra-state War')