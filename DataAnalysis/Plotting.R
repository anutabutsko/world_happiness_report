source("DataAnaylsis.R")
source("whi.R")
source("InterState.R")

# Initial Completeness Table For Files
print(whi.table)
print(interStateWar.table)
print(intraStateWar.table)
print(demonstration.table)

# correlation matrix within the whi.df
ggpairs(whi.df[,4:13], title="correlogram with ggpairs()", 
        method = c("everything", "pearson")) 
corality <- ggcorr(whi.df[,4:13]) 
ggplotly(corality)

# Analysis: There is very little correlation between generosity and GDP per
# capita at 0.7%. Overall, there does not seem to be a correlation between the two.
# We may be seeing a Simpsons paradox and would want to filter on location of country or
# some other factor