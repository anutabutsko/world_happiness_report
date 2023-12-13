projectIntroduction.content <- tagList(
  tags$h3(tags$strong("World Happiness Report Analysis"), style = "text-align: center;"),
  tags$h5("by Emma Horton, Hanna Butsko, Jin YuHan Burgess", style = "text-align: center;"),
  tags$p(),
  tags$p(
    "The primary aim of this project is to undertake a comprehensive analysis of the extensive World Happiness Report dataset spanning from 2005 to the present,",
    "which is available on Kaggle. Along with supplementary research and datasets to answer the question:"),
  tags$p(
    tags$ul(
      tags$li("Is there a statistically significant relationship between a country's World Happiness Index and the occurrence of a pandemic?"),
      tags$li("How do factors such as GDP, social support, freedom to make choices, generosity, and perception of corruption correlate with a country's happiness index during times of an epidemic or pandemic?")
    )
  ),
  tags$p(),
  tags$strong("Null Hypothesis (H0):", style = "text-align: center;"),
  tags$p("There is no difference in the mean happiness index scores of countries during a pandemic vs not a pandemic"),
  tags$strong("Alternative Hypothesis (H1):", style = "text-align: center;"),
  tags$p("There is a difference in the mean happiness index scores of countries during a pandemic vs not a pandemic"),
  tags$p(),
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
  tags$h3(tags$strong("The State of World Happiness"), style = "text-align: center;"),
  tags$p(
    tags$ul(
      tags$li("Utilizes statistical methods to analyze happiness data"),
      tags$li("Analyzes average happiness factors over time, standard deviations, and correlations to understand differences in happiness between different countries"),
      tags$li("Limitations include study’s sample size and duration"), 
      tags$li("Acknowledges hindrance in analyzing happiness inequality trends related to income inequality")
    )
  ),
  
  tags$p(tags$em("Relevance to the project:"), "It directly applies statistical concepts covered in class making it a practical example for understanding and applying those concepts.")
)

Happiness.World.Satisfaction.content <- tagList(
  tags$h3(tags$strong("Happiness and Life Satisfaction"), style = "text-align: center;"),
  tags$p(),
  tags$p(
    tags$ul(
      tags$li("Analyzes how life satisfaction scores spread across various regions"),
      tags$li("Identifies patterns and disparities in happiness not found in simpler analysis such as averages alone"),
      tags$li("Examines the relationship between GDP per capita and average life satisfaction, understood to be linear from the lectures"), 
      tags$li("Uses Stochastic Dominance to compare distributions between regions and determine which region generally reports higher happiness levels")
    )
  ),
  tags$p(tags$em("Relevance to the project:"), "Although not covered in class, this paper delves into Stochastic Dominance, which is a method for 
         comparing two probability distributions. It allows us to see which group consistently outperforms the other. While introducing new concepts 
         not covered in class, it still relates to probability distributions and encourages deeper understanding of statistical analysis."),
  tags$p(),
  tags$p(
    tags$ul(
      tags$li("Regression analysis"),
      tags$li("Confidence interval testing")
    )
  ),
  tags$p(), 
  tags$strong("Advantages"), 
  tags$p(
    tags$ul(
      tags$li("Factor Variability: looks at different factors that could affect happiness besides those indicated to affect happiness"), 
      tags$li("Additional Research: Implements datasets from multiple sources")
    )
  ), 
  tags$p(), 
  tags$strong("Limitations"), 
  tags$p(
    tags$ul(
      tags$li("Broad scope: leads to more descriptive analysis and could be lacking in some inferential analysis")
    )
  )
)


Analyze.and.Predict.content <- tagList(
  tags$h3(tags$strong("Analyze and Predict the 2022 World Happiness Report Based on the Past Year's Dataset"),style = "text-align: center;"),
  tags$p(),
  tags$p(
    tags$ul(
      tags$li("Utilizes linear regression to forecast happiness scores in various countries"),
      tags$li("Uses each country’s GDP to predict happiness scores providing the best fit linear equation"),
      tags$li("Validates data from its predictions with 2022 outcomes from World Happiness Reports"), 
      tags$li("Accuracy metrics: RMSE of 0.236 and MSE of 0.056"),
      tags$li("Focuses on the importance of statistical measures like Mean Absolute Error (MAE), Mean Squared Error (MSE), and Root Mean Square Error (RMSE) to evaluate prediction’s accuracy and reliability"), 
      tags$li("The study also performs Principal Component Analysis (PCA) to analyze gender equality and life satisfaction")
    )
  ),
  tags$p(tags$em("Relevance to the project:"), "Utilizes the same data from the World Happiness report as we are using in our project. This alignment allows for direct comparison of finding with our project’s work."),
    tags$strong("Advantages"), 
    tags$p(
      tags$ul(
        tags$li("Predictive Modeling that is Replicable: a quantitative frameworks is established when the study uses machine learning models, linear regression, and comparison of previous research to identify trends"), 
        tags$li("Additional Research: by comparing the linear regression attained in this research with other methods offering insight into the efficacy of other approaches"),
      )
    ), 
    tags$p(), 
    tags$strong("Limitations"), 
    tags$p(
      tags$ul(
        tags$li("Limited Scope: the study mainly focus on GDP as a factor of happiness although there are other factors in play"), 
        tags$li("Single Source: The study is only done on one dataset pulled from Kaggle"),
        tags$li("Temporally Limited: The study is mainly focused between 2021-2022 which could limit the scope of how long lasting an effect could have")
      )
  ) 
)

simpsons.content <- tagList(
  tags$h5(tags$strong("Analysis"), style = "text-align: center;"),
  tags$p("Simpson's Paradox occurs when a trend appears in several different groups of data but disappears or reverses when these 
         groups are combined. This paradox highlights the importance of examining data within its specific context."), 
  tags$p(
    tags$ul(
      tags$li("perception of corruption and the happiness index worldwide, correlation coefficient = -0.43."),
      tags$p(),
      tags$li("America correlation coefficient suggests a stronger negative relationship between corruption and happiness"),
      tags$li("Europe correlation coefficient indicates a very strong negative relationship"),
      tags$li("Asia correlation coefficient showing a weaker negative relationship"),
      tags$li("Africa correlation coefficient suggests close to no relationship between corruption and happiness"),
    )
  )
)

predicationAnalysis.content <- tagList(
  # tags$h5(tags$strong("Analysis"), style = "text-align: center;"),
  # tags$p("In these plots, we can visualize the regression of the happiness index for pre-COVID years (2005 – 2020), the predicted 
  #        happiness index for COVID years (2020-2022) based on that regression equation, and the actual happiness regression during the 
  #        COVID years. The key observations based on these results are as follows:"), 
  # tags$p(),
  tags$p("1. Regions where the happiness index has decreased during COVID years:"),
  tags$p(
    tags$ul(
      tags$li('Central Europe'),
      tags$li('South Asia'),
      tags$li('Sub-Saharan Africa'),
      tags$li('North America')
    )
  ),
  tags$p(),
  tags$p('2. Regions where the happiness index has increased during COVID years:'),
  tags$p(
    tags$ul(
      tags$li('East Asia'),
      tags$li('Latin America'),
      tags$li('Southeast Asia')
    )
  ),
  tags$p(),
  tags$p('3. Regions where the happiness index hasn’t or has barely changed:'),
  tags$p(
    tags$ul(
      tags$li('Western Europe'),
      tags$li('Eastern Europe'),
      tags$li('North Africa')
    )
  ),
  tags$p(),
  tags$p('4. Regions with no data available for COVID years:'),
  tags$p(
    tags$ul(
      tags$li('Caribbean'),
      tags$li('Central Africa'),
      tags$li('East Africa'),
      tags$li('Middle East'),
      tags$li('North Africa'),
      tags$li('South Africa'),
      tags$li('West Asia')
    )
  )
)

html_output <- tags$table(
  tags$tr(
    tags$th("Variable1"),
    tags$th(),
    tags$th("Variable2"),
    tags$th("Correlation")
  ),
  tags$tr(
    tags$td("Avg_Daily_Cumulative_Cases"),
    tags$td(),
    tags$td("Avg_Daily_NewCases"),
    tags$td("0.94")
  ),
  tags$tr(
    tags$td("Avg_Daily_NewCases"),
    tags$td(),
    tags$td("Avg_Daily_Cumulative_Cases"),
    tags$td("0.94")
  ),
  tags$tr(
    tags$td("Avg_Daily_NewDeaths"),
    tags$td(),
    tags$td("Avg_Daily_ICU_Occupancy"),
    tags$td("0.86")
  ),
  tags$tr(
    tags$td("Avg_Daily_ICU_Occupancy"),
    tags$td(),
    tags$td("Avg_Daily_NewDeaths"),
    tags$td("0.86")
  )
)