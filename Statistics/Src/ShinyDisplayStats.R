library(shiny)
library(shinydashboard)
source('PlottingStats.R')
source('AnaylsisStats.R')

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "World Happiness Index"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction", tabName = "exploratory", icon = icon("dashboard")),
      menuItem("Background", tabName = 'background', icon = icon('globe')),
      menuItem("Happiness", tabName = "Happiness", icon = icon("globe")),
      menuItem("Trends and Predictions", tabName = "trend", icon = icon('globe')),
      menuItem("Multiple Linear Regression", tabName = "lineregs", icon = icon('globe'))
    )
  ),
  dashboardBody(
    tabItems(
      # what you will see when you are in the dashboard tab
      tabItem(tabName = "exploratory", box(width = 12, htmlOutput('projectIntroduction', style = "height: 597px; overflow-y: auto;"))
              ), # tabItem1
      tabItem(tabName = "background",
              fluidRow(
                tabsetPanel(
                  tabPanel("Resarch Papers",
                           box(width = 4, htmlOutput("State.ofWorld.Happiness", style="height: 597px; overflow-y: auto;")),
                           box(width = 4,htmlOutput("Happiness.World.Satisfaction", style="height: 597px; overflow-y: auto;")),
                           box(width = 4, htmlOutput("Analyze.and.Predict", style="height: 597px; overflow-y: auto;"))),
                  tabPanel("Datasets",
                           tabsetPanel(
                             tabPanel("Covid Hospitalization",
                                      box(width = 12, htmlOutput("", style="height: 550px; overflow-y: auto;"))
                                      ),
                             tabPanel("Excess Mortality",
                                      box(width = 12, htmlOutput("", style="height: 597px; overflow-y: auto;"))
                                      ),
                             tabPanel("WHO COVID-19 Global Data",
                               box(width = 12, htmlOutput("", style="height: 550px; overflow-y: auto;"))
                             ),
                             tabPanel("World Happiness Report",
                                      box(width = 12, htmlOutput("", style="height: 550px; overflow-y: auto;"))
                             ),
                             tabPanel("Vaccination Data",
                                      box(width = 12, htmlOutput("", style="height: 550px; overflow-y: auto;"))
                             ),
                             
                           ))
                )
              )), # tabItem background
      tabItem(tabName = "Happiness",
              fluidRow(
                tabsetPanel(
                  tabPanel('Correlation', box(status = "primary", solidHeader = TRUE,
                                          width = 8, plotlyOutput("WHIcorr"))),
                  tabPanel('Distribution', box(width = 7, 
                                          title = "Overlook", 
                                          status = "primary", solidHeader = TRUE,
                                          # select button used when you want to select multiple things
                                          selectInput("region_check", "Select Region",
                                                      # names of the valid choices
                                                      choices =
                                                        list('Cumulative', 'South Asia',"Southeast Asia",
                                                             "East Asia", "West Asia",
                                                             "Middle East",
                                                             'Middle East and North Africa',
                                                             "North Africa","Central Africa","East Africa",
                                                             "Sub-Saharan Africa","Southern Africa", 
                                                             "Central and Eastern Europe", "Western Europe",
                                                             "Central Europe", "Commonwealth of Independent States",
                                                             "Caribbean", 'Latin America and Caribbean',
                                                             'North America and ANZ'), 
                                                      selected = 'Cumulative'),
                                          selectInput("WHI_check", "Select Indicator",
                                                      # names of the valid choices
                                                      choices = 
                                                        list('Log.GDP.Per.Capita', 
                                                             'Healthy.Life.Expectancy.At.Birth', 
                                                             'Generosity' ,'Positive.Affect', 
                                                             'Confidence.In.National.Government',
                                                             'Social.Support', 'Freedom.To.Make.Life.Choices',
                                                             'Perceptions.Of.Corruption', 'Negative.Affect'), 
                                                      selected = 'Log.GDP.Per.Capita'), 
                                          plotlyOutput('WHIandHappinessByRegion')),
                           box(width = 5, htmlOutput('')
                               )),
                  tabPanel("Simpson's Paradox", box(title = "Analysis of Possible Simpson's Paradox", 
                                 status = "primary", solidHeader = TRUE,
                                 width = 8, plotOutput('simpsonsPlot')), 
                                 box(width = 4, htmlOutput('simpsons', style = "height: 440px; overflow-y: auto;"))
                             
                  ) # tabPanel
                ))), # tabItem2
      tabItem(tabName = "trend",
              fluidRow(
                tabsetPanel(
                  tabPanel('Happiness Lvl Trend', box(
                    status = 'primary', solidHeader = TRUE,
                    width = 12, plotlyOutput('HappyLvlTrend')
                  )),
                  tabPanel('Prediction', box(width = 7, status = "primary", solidHeader = TRUE,
                                             selectInput("region_trend", "Select Region",
                                                         # names of the valid choices
                                                         choices =
                                                           list('South Asia',"Southeast Asia",
                                                                "East Asia", "West Asia",
                                                                "Middle East",
                                                                'Middle East and North Africa',
                                                                "North Africa","Central Africa","East Africa",
                                                                "Sub-Saharan Africa","Southern Africa", 
                                                                "Central and Eastern Europe", "Western Europe",
                                                                "Central Europe", "Commonwealth of Independent States",
                                                                "Caribbean", 'Latin America and Caribbean',
                                                                'North America and ANZ'), 
                                                         selected = 'South Asia'), plotlyOutput("HappinessPredictionByRegion")),
                           box(width = 5, status = 'primary', solidHeader = TRUE, 
                               htmlOutput('predicationAnalysis', style = "height: 500px; overflow-y: auto;")))
                ))),
      tabItem(tabName = "lineregs", 
              fluidRow(
                tabsetPanel(
                  tabPanel('Correlation Matrix',
                           box(width = 7, status = "primary", solidHeader = TRUE,
                               plotlyOutput('CovidCorr')),
                           box(width = 5, "primary", solidHeader = TRUE,
                               verbatimTextOutput('high.correaltion.content'))),
                  tabPanel('Multiple Linear Regresion', 
                           box(width = 12, status = "primary", solidHeader = TRUE,
                               plotOutput('MLR.Who'))),
                  tabPanel("MLR Summary", 
                           box(width = 12, status = "primary", solidHeader = TRUE,
                               verbatimTextOutput('sum')))
                )
              )),
      tabItem(tabName = "works",
              fluidRow(box(width = 12, htmlOutput('works.cited.content')))
      ) # tabItem4
    ) # tabItems 
  ) # dashboard body
)

# Define server logic
server <- function(input, output) {
  # text description
  output$projectIntroduction <- renderUI({
    projectIntroduction.content
  })
  
  output$State.ofWorld.Happiness <- renderUI({
    State.ofWorld.Happiness.content
  })
  
  output$Happiness.World.Satisfaction <- renderUI({
    Happiness.World.Satisfaction.content
  })
  
  output$Analyze.and.Predict <- renderUI({
    Analyze.and.Predict.content
  })

  output$simpsons <- renderUI({
    simpsons.content
  })
  
  output$predicationAnalysis <- renderUI({
    predicationAnalysis.content
  })
  # 
  # output$works.cited.content <- renderUI({
  #   tagList(works.cited.content)
  # })
  
  output$HappyLvlTrend <- renderPlotly({
    ggplotly(boxplot.trend)
  })
  
  output$WHIcorr <- renderPlotly({
    ggplotly(whi.corr.plot)
  })
  
  output$WHIandHappinessByRegion <- renderPlotly({
    if (input$region_check =='Cumulative'){
      world_perception <- happydf %>%
        group_by(Country.Name) %>% 
        summarise(Life.Ladder = mean(Life.Ladder), indicator = mean(!!as.name(input$WHI_check)))
      
      WHIandHappinessByRegion.plot <-  
        ggplot(world_perception, aes(x = indicator, y = Life.Ladder, text = Country.Name)) +
        geom_point(alpha = 0.3, color = "darkblue") + 
        geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE, aes(group = 1)) +
        theme_minimal() + 
        ggeasy::easy_center_title()
    }else{
    WHIandHappinessByRegion.plot <- happydf %>%
      filter(Regional.Indicator == input$region_check) %>%
      ggplot(aes(Life.Ladder, !!sym(input$WHI_check))) +
      geom_point(alpha=0.5) +
      theme_minimal() +
      geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
      labs(title=input$region_check, x="Happiness", y=input$WHI_check) +
      ggeasy::easy_center_title()
    }
    ggplotly(WHIandHappinessByRegion.plot)
  })
  
  output$simpsonsPlot <- renderPlot({
    final_plot <- annotate_figure(combined_plot, top = 
                                    text_grob("Relationship between Perceptions of Corruption\nand Happiness Index", face = "bold", size = 13))
    final_plot
  })
  
  output$simpsonsPlot15 <- renderPlot({
    top.bottom.15.plot
  })
  
  output$HappinessPredictionByRegion <- renderPlotly({
    happydf <- happydf %>%
      filter(!Regional.Indicator %in% c("South America", "Anglophone Caribbean", "Central America"))
    
    df1 <- filter(happydf, Regional.Indicator == input$region_trend)
    regions <- unique(region.mean.by.year$Regional.Indicator)
    df2 <- filter(region.mean.by.year, Regional.Indicator == input$region_trend)
    
    plot <- prediction.model(df1, df2)
    
    ggplotly(plot)
  })
  
  output$CovidCorr <- renderPlotly({
    ggplotly(covid.corr.plot)
  })
  
  output$MLR.Who <- renderPlot({
    #Get residuals
    model_residuals = MLR_who$residuals
    
    # diagnostic plots #YUHAN
    
    par(mfrow = c(2, 2))  # grid for plots
    #The histogram looks normal; hence we can conclude the normality with enough confidence.
    
    hist(model_residuals)
    # residuals vs. fitted values (check homoscedasticity)
    plot(MLR_who, 1)
    # Q-Q Plot (check for normality of residuals)
    plot(MLR_who, 2)
    # Cook's distance (check outliers)
    plot(MLR_who, 5)
    par(mfrow = c(1, 1)) #  plotting layout
  })
  
  output$highCorrelation <- renderPrint({
    high.correlation.content <- data.frame(
      Variable1 = variable_names,
      Variable2 = correlated_variable_names,
      Correlation = correlation_values
    )
    print(high.correlation.content)
  })
  
  output$sum <- renderPrint({
    summary(MLR_who)
  })


}

# Run the Shiny app
shinyApp(ui = ui, server = server)
