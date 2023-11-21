setwd('/Users/yuhanburgess/Documents/GitHub/world_happiness_report/')
source("DataAnaylsis.R")
source("whi.R")
violent.event <- read_csv('Datasets/political_violence_events_by_country.csv')
demonstration.event <- read_csv('Datasets/demonstration_by_country.csv')
violent.event <- violent.event[,-1]

violent.table <- completeness(violent.event, 'Political Violence by Country')
demonstration.table <- completeness(demonstration.event[,-1], 'Demonstrations by Country')

column.join <- setNames(colnames(country.region)[1], colnames(violent.event)[1])

country.join <- join.df(violent.event, country.region, column.join)

