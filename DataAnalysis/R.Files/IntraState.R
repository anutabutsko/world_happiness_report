setwd('/Users/yuhanburgess/Documents/GitHub/world_happiness_report/')
source("FunctionFile.R")
source("whi.R")

intra.outcome.category = c(`1` = 'Side A wins',
                           `2` = 'Side B wins',
                           `3` = 'Compromise',
                           `4` = 'The war was transformed into another type of war', 
                           `5` = 'The war is ongoing as of 12/31/2007',
                           `6` = 'Stalemate',
                           `7` = 'Conflict continues at below war level')

wartype.category <- c(`4` = 'Civil war for central control',
              `5` = 'Civil war over local issues',
              `6` = 'Regional internal',
              `7` = 'Intercommunal')

intraStateWar.event <- read_csv('Datasets/Intra-StateWarData_v4.1.csv')

intraStateWar.clean <- StateWar.filter(intraStateWar.event, 9:20)

intraStateWar.clean<- intraStateWar.clean%>%
  mutate(
    EndDay1 = ifelse(EndYear1 == 2023, 31, EndDay1),
    EndMonth1 = ifelse(EndYear1 == 2023, 12, EndMonth1)
  )

intraStateWar.table <- completeness(intraStateWar.clean, 'Intra-state War')

intraStateWar.clean <- intraStateWar.clean %>%
  mutate(WhereFought = recode(as.character(WhereFought), 
                              !!!wherefought.category))%>%
  mutate(WarType = recode(as.character(WarType), 
                              !!!wartype.category))%>%
  mutate(Outcome = recode(as.character(Outcome), 
                          !!!intra.outcome.category))

intraStateWar.clean <- us.name(intraStateWar.clean)
intraStateWarA.column.join <- setNames(colnames(country.region)[1], 
                                       colnames(intraStateWar.clean)[5])
intraStateWarB.column.join <- setNames(colnames(country.region)[1], 
                                       colnames(intraStateWar.clean)[7])

intraStateWar.clean <- join.df(intraStateWar.clean, country.region, 
                               intraStateWarA.column.join)
intraStateWar.clean <- join.df(intraStateWar.clean, country.region, 
                               intraStateWarB.column.join)

intraStateWar.clean <- intraStateWar.clean%>%
  rename(`region.A` = `region.x`, `sub-region.A` = `sub-region.x`, 
         `region.B` = `region.y`, `sub-region.B` = `sub-region.y`)


intra.day <- war.duration(intraStateWar.clean, 10, 13, 16,19)%>%
  rename("war.duration" = 'EndDay1')
intra.month <- war.duration(intraStateWar.clean, 9, 12, 15,18)
intra.year <- war.duration(intraStateWar.clean, 11,14, 17,20)

# change month to days
intra.month.asday<- apply(intra.month, 2, function(x) x*30.4167)

# create a column on the duration of the year with a base of year
intra.war.duration <- ((intra.day + intra.month.asday)/365) + intra.year
intraStateWar.clean <- cbind(intraStateWar.clean, intra.war.duration)
summary(intraStateWar.clean)
