projectIntroduction.content <- tagList(
  tags$h3("World Happiness Report Analysis", style = "text-align: center;"),
  tags$h5("by Emma Horton, Hanna Butsko, Jin YuHan Burgess", style = "text-align: center;"),
  tags$p(),
  tags$p(
    "The primary aim of this project is to undertake a comprehensive analysis of the extensive World Happiness Report dataset spanning from 2005 to the present,",
    "which is available on Kaggle. Along with supplementary research and datasets to answer the question: Is there a statistically significant relationship between a country's World Happiness ",
    "Index and the occurrence of a pandemic? Specifically, how do factors such as GDP, social support, freedom to make choices, generosity, and perception of corruption ",
    "correlate with a country's happiness index during times of an epidemic or pandemic?"
  ),
  tags$p(),
  tags$strong("Null Hypothesis (H0):", style = "text-align: center;"),
  tags$p("There is no difference in the mean happiness index scores of countries during a pandemic vs countries when there is not a pandemic"),
  tags$strong("Alternative Hypothesis (H1):", style = "text-align: center;"),
  tags$p("There is a difference in the mean happiness index scores of countries during a pandemic vs countries when there is not a pandemic"),
  tags$p(),
  tags$strong("Datasets used in Project", style = "text-align: center;"),
  tags$p("continents.csv"), tags$p("covid-hospitalizations.csv"), tags$p("excess_mortality.csv"),tags$p("PopulationData.csv"),
  tags$p("WHO-COVID-19-global-data.csv"), tags$p("WorldHappinessReport.csv"),tags$p("vaccination-data.csv"),
  tags$strong("Additional Research", style = "text-align: center;"),
  tags$p('The State of World Happiness'), tags$p("Analyze and Predict the 2022 World Happiness Report Based on the Past Year's Dataset"),
  tags$p('Happiness and Life Satisfaction - Our World in Data'),
  tags$strong('Descriptive and Inferential Analysis', style = "text-align: center;"),
  tags$p(tags$em('Descriptive statistics:'), 'The expected summaries will include central tendency and dispersion measures such as mean, median, standard deviation, variance, kurtosis, skewness, ',
         'range, minimum and maximum values. The report will include a combination between time series and boxplot to graph the distribution of within and between time periods (or groups).'),
  tags$p(tags$em("Correlation Assessment:"), 'The analysis should include correlation assessments between factors influencing happiness and epidemic/pandemic-related health statistics such as COVID-19 deaths, ',
         'hospitalizations, or vaccine distribution (WHO Coronavirus (COVID-19) Data 2023). This will involve examining how these health indicators correlate with happiness (Life.Ladder). This will provide ',
         'insights into the impact of the epidemic/pandemic on well-being.'),
  tags$p(tags$em("Inferential Analysis:"), 'Our analysis will estimate the population parameter using a 95% confidence interval and utilize regression techniques to understand the temporal trend of ',
         'Happiness over time. We will assess the significance of epidemic/pandemic events on the slope and perform a comparison of deviations from that line during periods of interest with the goal to uncover ',
         'the projected path with and without the occurrence of epidemic/pandemic events')
)

State.ofWorld.Happiness.content <- tagList(
  tags$h3("The State of World Happiness",style = "text-align: center;"),
  tags$p(),
  tags$p("This study utilizes statistical methods to examine central tendencies and dispersion in happiness data, employing 95% confidence intervals for these analyses. It focuses on average happiness factors over time, 
         standard deviations within regions and countries, and correlation analysis to understand differences in happiness between OECD countries and others. The report notes a limitation in its sample size and duration, 
         hindering a comprehensive analysis of happiness inequality trends in relation to income inequality. Understanding these statistical concepts that we have covered in class will be pivotal in our ability to assess the 
         data and form our own analysis.")
)

Happiness.World.Satisfaction.content <- tagList(
  tags$h3("Happiness and Life Satisfaction", style = "text-align: center;"),
  tags$p(),
  tags$p("The study from Our World in Data performs distribution Analysis to understand how life satisfaction scores spread across different levels in various regions in order to identify patterns and disparities in happiness not 
         found in simpler analysis such as averages alone. The article uses correlation analysis to examine the relationship between GDP per capita and average life satisfaction across countries which we understand to be linear relationships 
         from the classroom preparation. Finally, stochastic Dominance is  used to compare distributions between regions to determine which region generally reports higher happiness levels. Although not covered in class, this is a way to compare 
         two probability distributions (which are covered) to see which one generally has better results. It checks if one group is always as good as or better than the other in all situations.")
)

Analyze.and.Predict.content <- tagList(
  tags$h3("Analyze and Predict the 2022 World Happiness Report Based on the Past Year's Dataset",style = "text-align: center;"),
  tags$p(),
  tags$p("This study utilizes linear regression to forecast happiness scores in various countries. By using linear regression, this study predicts ladder scores using each country’s GDP and provides the best fit linear equation. 
         It leverages data from previous World Happiness Reports, validating its predictions against 2022 outcomes, achieving an RMSE of 0.236 and an MSE of 0.056, the study emphasizes understanding key statistical measures like 
         Mean Absolute Error (MAE), Mean Squared Error (MSE), and Root Mean Square Error (RMSE) to evaluate the accuracy and reliability of its predictions. The study also performs Principal Component Analysis (PCA) to analyze 
         gender equality and life satisfaction. Selection trees were used as well as for life satisfaction prediction."),
  tags$p(), 
  tags$strong("Mean Absolute Error (MAE)"),
  tags$p("measures the average of the absolute difference between the actual and predicted values.  Mean Squared Error (MSE) measures the mean square error of the mismatch between predicted and real values. Root Mean Square Error (RMSE) 
         is the square root of mean squared error." )
)
