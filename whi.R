setwd('/Users/yuhanburgess/Documents/GitHub/world_happiness_report/')
source("DataAnaylsis.R")
whi.df <- read.csv('Datasets/WorldHappinessReport.csv')


whi.table <- completeness(whi.df, 'World Happiness Index')
print(whi.table)

# correlation matrix within the whi.df
ggpairs(whi.df[,4:13], title="correlogram with ggpairs()", 
        method = c("everything", "pearson")) 
corality <- ggcorr(whi.df[,4:13]) 
ggplotly(corality)

# Analysis: There is very little correlation between generosity and GDP per
# capita at 0.7%. Overall, there does not seem to be a correlation between the two.
# We may be seeing a Simpsons paradox and would want to filter on location of country or
# some other factor

# used for filtering in InterState.R
location.country <- whi.df[1:2]%>%
  mutate_all(~ifelse(.== 'United States', 'United States of America', . ))
