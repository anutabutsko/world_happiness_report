library(dplyr)
library(ggeasy)
library(ggplot2)
library(ggpubr)
library(plotly)
library(viridis)
library(tidyr)
library(reshape2)
library(DataExplorer)
library(graphics)
library(crosstalk)
library(ggcorrplot)
library(heatmaply)

source("whiStats.R")

boxplot.trend <- happydf %>%
  ggplot(aes(x=as.factor(Year), y= Life.Ladder, fill = Year)) +
  geom_boxplot(position = 'dodge') +
  scale_fill_viridis(alpha=0.7, option= 'viridis')+
  theme_minimal() +
  labs(title = "Happiness Trend Over The Years", 
                        x = "Year", 
                        y = "Happiness Lvl")+ 
  theme(legend.text = element_blank(), # font text of variables in legend
        legend.position = 'none',
        axis.title.x = element_blank())+
  ggeasy::easy_center_title()


# prediction
linear_regression <- function(x, y, data) {
  formula <- as.formula(paste(y, "~", x))
  
  regression <- lm(formula, data = data)
  
  intercept <- coef(regression)[1]
  slope <- coef(regression)[2]
  r_squared_percentage <- round(summary(regression)$r.squared * 100, 1)
  
  return(list(intercept=intercept, 
              slope=slope, 
              r_squared_percentage=r_squared_percentage))
}

# top_perception <- top_happiness %>%
#   ggplot(aes(corruption, Life.Ladder, color=Life.Ladder)) +
#   geom_point(show.legend = FALSE) + 
#   geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
#   labs(title = "Relationship between Perceptions of Corruption\nand Happiness Index", 
#        subtitle="Top 15 Happiest Countries",
#        x = "Perceptions of Corruption", 
#        y = "Happiness Index") +
#   geom_text(aes(label=Country.Name), color="black", vjust=-1, size=2.3) +
#   theme_minimal()
# 
# low_perception <- low_happiness %>%
#   ggplot(aes(corruption, Life.Ladder, color=Life.Ladder)) +
#   geom_point(show.legend = FALSE) + 
#   geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
#   labs(title = "Relationship between Perceptions of Corruption\nand Happiness Index", 
#        subtitle="Top 15 Unhappies Countries",
#        x = "Perceptions of Corruption", 
#        y = "Happiness Index") +
#   geom_text(aes(label=Country.Name), color="black", vjust=-1, size=2.3) +
#   theme_minimal()
# region.mean.by.year <- happydf %>%
#   group_by(Regional.Indicator, Year) %>%
#   summarise(n = n(), Life.Ladder = mean(Life.Ladder, na.rm = TRUE))
# 
# combined.plot <- ggarrange(top_perception, low_perception, ncol = 1, nrow =2)
# top.bottom.15.plot <- annotate_figure(combined.plot, 
#                               top = text_grob("Happiness Trend Across Years", 
#                                               face = "bold", size = 16))
predict <- function(equation, df1){
  # before covid
  before_covid1 <- filter(df1, Year < 2021)
  
  # predicted happiness
  years <- seq(min(2020, max(before_covid1$Year)), 2022, 1)
  
  n <- length(years)
  happiness.index <- numeric(n)
  for (i in 1:n){
    happiness <- equation$intercept + equation$slope * years[i]
    happiness.index[i] <- happiness
  }
  
  predicted.happiness.df <- data.frame(Year = years, Life.Ladder = happiness.index)
  
  return(predicted.happiness.df)
}

prediction.model <- function(df1, df2){
  before_covid1 <- filter(df1, Year < 2021)
  before_covid2 <- filter(df2, Year < 2021)
  
  equation <- linear_regression("Year", "Life.Ladder", before_covid1)
  
  predicted.happiness.df <- predict(equation, before_covid1)
  
  subtitle_before <- paste("Years:", min(df1$Year), "to", max(df1$Year), "\nBefore Covid Regression Equation: Happiness = ", round(equation$intercept, 2), '+ (', round(equation$slope, 2), " * Year)", "   R^2 =", equation$r_squared_percentage, "%")
  
  result <- 
    ggplot(before_covid1, aes(x = Year, y = Life.Ladder)) +
    geom_point(alpha = 0.5, position = "jitter", color="darkblue") +
    geom_line(data=predicted.happiness.df, color="red", size=2) +
    geom_point(data = before_covid2, size = 3, color="darkred", alpha=0.6) +
    geom_smooth(method='lm', color = "darkblue", fill="gray100", se = TRUE, size=0.6) +
    geom_text(data = before_covid2, aes(label = paste0("n=", n), y = 1, color = NULL), size = 2.5) +
    labs(title=paste("World Happiness Distribution Across the Years in", unique(df1$Regional.Indicator)), 
         subtitle=subtitle_before, 
         x="\nYear", 
         y="Happiness Index") +
    theme_minimal() +
    scale_x_continuous(breaks = seq(min(before_covid1$Year), max(before_covid1$Year), 1)) +  # Update this line
    
    scale_y_continuous(breaks = seq(2, 9, 1)) +
    theme(axis.text.x = element_text(angle = 45, hjust = 0.2, vjust = 0),
          legend.position = "none",
          panel.grid.minor = element_blank())
  
  after_covid1 <- filter(df1, Year > 2019)
  after_covid2 <- filter(df2, Year > 2019)
  
  if (nrow(after_covid1) > 1){
    after_equation <- linear_regression("Year", "Life.Ladder", after_covid1)
    
    subtitle_after <- paste("After Covid Regression Equation: Happiness = ", round(after_equation$intercept, 2), '+ (', round(after_equation$slope, 2), " * Year)", "   R^2 =", after_equation$r_squared_percentage, "%")
    
    result <- result +
      geom_point(data = after_covid1, alpha = 0.5, position = "jitter", color="darkblue") +
      geom_point(data = after_covid2, size = 3, color="darkred", alpha=0.6) + 
      geom_smooth(data = after_covid1, method='lm', color = "darkblue", fill="gray100", se = TRUE, size=0.6) +
      geom_text(data = after_covid2, aes(label = paste0("n=", n), y = 1, color = NULL), size = 2.5)
    
    result <- result +
      labs(subtitle=paste0(subtitle_before, "\n", subtitle_after))+
      ggeasy::easy_center_title()
  } else {
    subtitle_after <- paste("No actual post covid data is available.")
    result <- result +
      labs(subtitle=paste0(subtitle_before, "\n", subtitle_after))+
      ggeasy::easy_center_title()
  }
  
  return(result)
}



# MLR Analysis 
WHI.cor <- happydf[,4:13]
WHI.cor <- na.omit(WHI.cor)
whi.corr <- round(cor(WHI.cor), 2) 
whi.p.mat <- cor_pmat(WHI.cor)
whi.corr.plot <- ggcorrplot(whi.corr,
           hc.order = TRUE,
           type = "lower",
           outline.color = "white",
           p.mat = whi.p.mat)



covid.corr.plot <- ggcorrplot(corr_matrix, hc.order = TRUE, 
                        type = "lower", outline.col = "white", 
                        p.mat = p.mat)


MLR_who <- lm(Life.Ladder ~ Avg_Daily_NewCases+Avg_Daily_NewDeaths+
                Avg_Daily_ICU_Occupancy_Per_Million+Avg_Daily_Cumulative_Cases+
                Avg_Daily_ICU_Occupancy+Avg_Daily_Cumulative_Death, data = WHO)


