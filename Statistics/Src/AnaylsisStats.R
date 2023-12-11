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

