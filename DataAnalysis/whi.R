source("FunctionFile.R")
whi.df <- read.csv('Datasets/WorldHappinessReport.csv')


whi.table <- completeness(whi.df, 'World Happiness Index')

# used for filtering in InterState.R
location.country <- us.name(whi.df[1:2])
