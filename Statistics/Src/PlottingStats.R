library(dplyr)
library(ggeasy)
library(ggplot2)

source("whiStats.R")

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


region.mean.by.year <- happydf %>%
  group_by(Regional.Indicator, Year) %>%
  summarise(n = n(), Life.Ladder = mean(Life.Ladder, na.rm = TRUE))

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
    geom_point(alpha = 0.5, position = "jitter", color="orange") +
    geom_line(data=predicted.happiness.df, color="red", size=2) +
    geom_point(data = before_covid2, size = 3, color="darkred", alpha=0.6) +
    geom_smooth(method='lm', color = "darkred", fill="gray80", se = TRUE, size=0.6) +
    geom_text(data = before_covid2, aes(label = paste0("n=", n), y = 1, color = NULL), size = 2.5) +
    labs(title=paste("World Happiness Distribution Across the Years in", unique(df1$Regional.Indicator)), 
         subtitle=subtitle_before, 
         x="\nYear", 
         y="Happiness Index") +
    theme_minimal() +
    scale_x_continuous(breaks = seq(min(df$Year), max(df$Year), 1)) +
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
      geom_point(data = after_covid1, alpha = 0.5, position = "jitter", color="orange") +
      geom_point(data = after_covid2, size = 3, color="darkred", alpha=0.6) + 
      geom_smooth(data = after_covid1, method='lm', color = "darkred", fill="gray80", se = TRUE, size=0.6) +
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



