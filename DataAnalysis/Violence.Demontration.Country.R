source("FunctionFile.R")
source("whi.R")
violent.event <- read_csv('Datasets/political_violence_events_by_country.csv')
demonstration.event <- read_csv('Datasets/demonstration_by_country.csv')
violent.event <- violent.event[,-1]
demonstration.event <- demonstration.event[,-1]


violent.table <- completeness(violent.event, 'Political Violence by Country')
demonstration.table <- completeness(demonstration.event, 'Demonstrations by Country')

vio.column.join <- setNames(colnames(country.region)[1], colnames(violent.event)[1])
dem.column.join <- setNames(colnames(country.region)[1], colnames(demonstration.event)[1])


violent.event.country.join <- join.df(violent.event, country.region, vio.column.join)
demonstration.event.country.join <- join.df(demonstration.event, country.region, dem.column.join)

violent.event.per.year <- count.filter(violent.event.country.join, 
                                       Country, Year)
demonstration.event.per.year <- count.filter(demonstration.event.country.join, 
                                             Country, Year)

violent.event.per.country <- count.filter(violent.event.country.join, 
                                       Country)

demonstration.event.per.country <- count.filter(demonstration.event.country.join, 
                                          Country)

demo.vio.join <- setNames(colnames(demonstration.event.per.country)[1], 
                            colnames(violent.event.per.country)[1])

violent.event.per.country <- violent.event.per.country%>%
  rename(vio.occurrences = Occurrence, vio.TotalEvents = TotalEvents)

demonstration.event.per.country <- demonstration.event.per.country%>%
  rename(demo.occurrences = Occurrence, demo.TotalEvents = TotalEvents)

demo.vio.merged.df <- join.df(violent.event.per.country, demonstration.event.per.country, demo.vio.join)
