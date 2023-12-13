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
  tags$p("There is no difference in the mean happiness index scores of countries during a pandemic vs countries when there is not a pandemic"),
  tags$strong("Alternative Hypothesis (H1):", style = "text-align: center;"),
  tags$p("There is a difference in the mean happiness index scores of countries during a pandemic vs countries when there is not a pandemic"),
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
  tags$h3(tags$strong("The State of World Happiness"),style = "text-align: center;"),
  tags$p(),
  tags$p("This study utilizes statistical methods to examine central tendencies and dispersion in happiness data, employing 95% confidence intervals for these analyses. It focuses on average happiness factors over time, 
         standard deviations within regions and countries, and correlation analysis to understand differences in happiness between OECD countries and others. The report notes a limitation in its sample size and duration, 
         hindering a comprehensive analysis of happiness inequality trends in relation to income inequality. Understanding these statistical concepts that we have covered in class will be pivotal in our ability to assess the 
         data and form our own analysis.")
)

Happiness.World.Satisfaction.content <- tagList(
  tags$h3(tags$strong("Happiness and Life Satisfaction"), style = "text-align: center;"),
  tags$p(),
  tags$p("The study from Our World in Data performs distribution analysis to understand how life satisfaction scores spread across different levels in various regions in order to identify patterns and disparities in happiness not found in simpler analysis such as averages alone. The article uses correlation analysis to examine the relationship between GDP per capita and average life satisfaction across countries, which we understand to be linear relationships from the classroom preparation. Finally, stochastic dominance is used to compare distributions between regions to determine which region generally reports higher happiness levels. Although not covered in class, this is a way to compare two probability distributions (which are covered) to see which one generally has better results. It checks if one group is always as good as or better than the other in all situations."),
  tags$p(
    tags$h5(tags$strong("Descriptive Statistics"), style = "text-align: center;"),
    tags$p(),
    tags$ul(
      tags$li("Happiness Score Distribution: by country, region, and crossed with other possible impacting variables"),
      tags$li("Happiness Trend: by country, region, and crossed with other possible impacting variables")
    )
  ),
  tags$p(
    tags$h5(tags$strong("Inferential Statistics"), style = "text-align: center;"),
    tags$p(),
    tags$ul(
      tags$li("Regression analysis"),
      tags$li("Confidence interval testing")
    )
  ),
  tags$h5(tags$strong("Advantages and Limitations of Research"), style = "text-align: center;"), 
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
  ),
  tags$p(), 
  tags$h5(tags$strong("Our Research"), style = "text-align: center;"), 
  tags$p(), 
  tags$strong("Implementations"), 
  tags$p(
    tags$ul(
      tags$li("Look at another external factor: Looking at epi-/pandemics as another facet to happiness score")
        )
      ) 
)


Analyze.and.Predict.content <- tagList(
  tags$h3(tags$strong("Analyze and Predict the 2022 World Happiness Report Based on the Past Year's Dataset"),style = "text-align: center;"),
  tags$p(),
  tags$p("This study utilizes linear regression to forecast happiness scores in various countries. By using linear regression, this study predicts ladder scores using each country’s GDP and provides the best fit linear equation. 
         It leverages data from previous World Happiness Reports, validating its predictions against 2022 outcomes, achieving an RMSE of 0.236 and an MSE of 0.056, the study emphasizes understanding key statistical measures like 
         Mean Absolute Error (MAE), Mean Squared Error (MSE), and Root Mean Square Error (RMSE) to evaluate the accuracy and reliability of its predictions. The study also performs Principal Component Analysis (PCA) to analyze 
         gender equality and life satisfaction. Selection trees were used as well as for life satisfaction prediction."),
  tags$p(), 
  tags$strong("Mean Absolute Error (MAE)"),
  tags$p("measures the average of the absolute difference between the actual and predicted values.  Mean Squared Error (MSE) measures the mean square error of the mismatch between predicted and real values. Root Mean Square Error (RMSE) 
         is the square root of mean squared error." ),
  tags$p(
         tags$h5(tags$strong("Descriptive Statistics"),style = "text-align: center;"),
         tags$p(),
         tags$ul(
           tags$li("Mean happiness score across all countries between 2021-2022"),
           tags$li("Happiness Score Distribution by Regional.Indicator"),
           tags$li("Correlation coefficients between Life.Ladder and other happiness indicators")
         )
  ),
  tags$p(
         tags$h5(tags$strong("Inferential Statistics"),style = "text-align: center;"),
         tags$p(),
         tags$ul(
           tags$li("Linear regression will predict ladder scores using each country’s GDP and provide the best fit linear equation"),
           tags$li("Model evaluation using MAE, MSE, RMSE"),
           tags$li("Infer statistical importance of GDP and happiness score"), 
         )
  ), 
  tags$p(), 
  tags$h5(tags$strong("Advantages and Limitations of Research"),style = "text-align: center;"), 
  tags$p(), 
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
    ),
    tags$p(), 
    tags$h5(tags$strong("Our Research"),style = "text-align: center;"), 
    tags$p(), 
    tags$strong("Implementations"), 
    tags$p(
      tags$ul(
        tags$li("Longitudinal Data: incorporate data related to COVID-19 to assess possible influence on happiness score"), 
        tags$li("Partitioning: Implement partitioning based on possible regional similarities to identify possible differences"),
      )
    ), 
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