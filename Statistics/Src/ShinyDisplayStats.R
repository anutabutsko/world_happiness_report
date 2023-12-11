library(plotly)
library(shiny)
library(shinydashboard)
source('PlottingStats.R')

# source('AnalysisStats.R')

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "World Happiness Index"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Exploratory Page", tabName = "exploratory", icon = icon("dashboard")),
      menuItem("Influencers of Happiness", tabName = "Happiness", icon = icon("globe")),
      menuItem("Happiness Trend", tabName = "trend", icon = icon('globe'))
    )
  ),
  dashboardBody(
    tabItems(
      # what you will see when you are in the dashboard tab
      tabItem(tabName = "exploratory", box(width = 12, htmlOutput('projectIntroduction'))
              ), # tabItem1
      tabItem(tabName = "Happiness",
              fluidRow(
                tabsetPanel(
                  tabPanel('Background', box(width = 12, htmlOutput('influenceofHappiness.background')),
                           tabsetPanel(
                           tabPanel('About the World Happiness Report', 
                                    box(width = 12, htmlOutput('', 
                                                               style = "height: 250px; overflow-y: auto;"))))),
                  tabPanel('graph 1', box(title = "", 
                                          status = "primary", solidHeader = TRUE,
                                          width = 7),
                           box(width = 5, htmlOutput('', style = "height: 440px; overflow-y: auto;"))),
                  tabPanel('graph 2', box(width = 7, 
                                          title = "", 
                                          status = "primary", solidHeader = TRUE,
                                          # select button used when you want to select multiple things
                                          selectInput("region_check", "Select Region",
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
                                                      selected = 'South Asia'),
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
                                          plotlyOutput('WHIandHappinessByContinent')),
                           box(width = 5, htmlOutput('', style = "height: 597px; overflow-y: auto;")
                               )),
                  tabPanel('graph 3', box(title = "", 
                                          status = "primary", solidHeader = TRUE,
                                          width = 8, plotOutput('')
                  ),
                  box(width = 4, htmlOutput('', style = "height: 440px; overflow-y: auto;")
                      )
                  ) # tabPanel
                ))), # tabItem2
      tabItem(tabName = "trend",
              fluidRow(box(width = 12, status = "primary", solidHeader = TRUE,
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
                                       selected = 'South Asia'), plotlyOutput("HappinessPredictionByRegion")))),
      tabItem(tabName = "works",
              fluidRow(box(width = 12, htmlOutput('works.cited.content')))
      ) # tabItem4
    ) # tabItems 
  ) # dashboard body
)

# Define server logic
server <- function(input, output) {
  # # text description 
  # output$projectIntroduction <- renderUI({
  #   tagList(projectIntroduction.content)
  # })
  # 
  # output$influenceofHappiness.background <- renderUI({
  #   tagList(influenceofHappiness.background.content)
  # })
  # 
  # output$works.cited.content <- renderUI({
  #   tagList(works.cited.content)
  # })
  
  output$WHIandHappinessByContinent <- renderPlotly({
    plot <- happydf %>%
      filter(Regional.Indicator == input$region_check) %>%
      ggplot(aes(Life.Ladder, !!sym(input$WHI_check))) +
      geom_point(alpha=0.5) +
      theme_minimal() +
      geom_smooth(method = "lm", color = "red", fill = "grey", se = TRUE) +
      labs(title=input$region_check, x="Happiness", y=input$WHI_check) +
      ggeasy::easy_center_title()
  
    ggplotly(plot)
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
  # output$happinessIndicatorDistribution <- renderUI({
  #   tagList(happinessIndicatorDistribution.content)
  # })

}

# Run the Shiny app
shinyApp(ui = ui, server = server)
