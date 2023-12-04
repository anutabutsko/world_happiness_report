library(shiny)
library(shinydashboard)
source('Plotting.R')

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "World Happiness Index"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Exploratory Page", tabName = "exploratory", icon = icon("dashboard")),
      menuItem("Influencers of Happiness", tabName = "Happiness", icon = icon("globe")),
      menuItem("Happiness Trend", tabName = "trend", icon = icon('globe')), 
      menuItem("Happiness and Conflicts", tabName = "warandpeace", icon = icon("globe")),
      menuItem("Works Cited", tabName = 'works', icon = icon("globe"))
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
                                    box(width = 12, htmlOutput('WHR', 
                                                               style = "height: 250px; overflow-y: auto;"))))),
                  tabPanel('graph 1', box(title = "Corr. Matrix of Happiness Indicators", 
                                          status = "primary", solidHeader = TRUE,
                                          width = 7, plotlyOutput('correlationMatrix')),
                           box(width = 5, htmlOutput('correlationMaxtrixText', style = "height: 440px; overflow-y: auto;"))),
                  tabPanel('graph 2', box(width = 7, 
                                          title = "Happiness Indicators and Happiness by Continent", 
                                          status = "primary", solidHeader = TRUE,
                                          # select button used when you want to select multiple things
                                          selectInput("Corruption_check", "Select Continent",
                                                      # names of the valid choices
                                                      choices =
                                                        list('Africa', 'Americas', 
                                                             'Asia' ,'Europe', 'Oceania'), 
                                                      selected = 'Africa'),
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
                                          plotlyOutput('WHIandHappinessByCountinent')),
                           box(width = 5, htmlOutput('happinessIndicatorByContinent', style = "height: 597px; overflow-y: auto;")
                               )),
                  tabPanel('graph 3', box(title = "Happiness Indicator Distribution", 
                                          status = "primary", solidHeader = TRUE,
                                          width = 8, plotOutput('HappinessIndicator'),
                                          radioButtons("Happiness_check", "Select Happiness Indicator",
                                                       # names of the valid choices
                                                       choiceNames =
                                                         list('Life.Ladder', 'Log.GDP.Per.Capita', 
                                                              'Healthy.Life.Expectancy.At.Birth' ,'Generosity', 
                                                              'Positive.Affect', 'Confidence.In.National.Government',
                                                              'Freedom.To.Make.Life.Choices', 'Perceptions.Of.Corruption',
                                                              'Negative.Affect', 'Social.Support'),
                                                       choiceValues =
                                                         list('Life.Ladder', 'Log.GDP.Per.Capita', 
                                                              'Healthy.Life.Expectancy.At.Birth' ,'Generosity', 
                                                              'Positive.Affect', 'Confidence.In.National.Government',
                                                              'Freedom.To.Make.Life.Choices', 'Perceptions.Of.Corruption',
                                                              'Negative.Affect', 'Social.Support')) # radio button
                  ),
                  box(width = 4, htmlOutput('happinessIndicatorDistribution', style = "height: 440px; overflow-y: auto;")
                      )
                  ) # tabPanel
                ))), # tabItem2
      tabItem(tabName = "trend",
              fluidRow(
                tabsetPanel(
                  tabPanel('Background',box(width = 12,
                                            htmlOutput('trendBackground'))),
                  tabPanel('graph 1', tabsetPanel(
                    tabPanel("Happiness Trend By Continent",
                             box(title = "Happiness Lvl Over The Years By Continent", 
                                 status = "primary", solidHeader = TRUE,
                                 width = 6, plotlyOutput('happinessTrend')),
                             box(width = 6, htmlOutput('happinessByContinentText', style = "height: 440px; overflow-y: auto;"))
                    ),
                    tabPanel("Happiness Trend by Sub-region", 
                             box(status = "primary", solidHeader = TRUE,
                                 width = 8, plotlyOutput('happinessSubregionTrend')),
                             box(width = 4, 
                                 p("This is a textbox to discribe the happiness trend by Continent"))))),
                  tabPanel('graph 2', box(title = "Happiness Trend Over Time by Country",
                                          width = 12, selectInput("dumbell_check", "Select Continent",
                                                                  # names of the valid choices
                                                                  choices =
                                                                    list('Africa', 'Americas', 
                                                                         'Asia' ,'Europe', 'Oceania'),
                                                                  selected = 'Africa'),
                                          plotOutput('dumbellWHITrend')),
                           box(width = 12, 
                               p("This is a textbox to discribe the Happiness Trend Over Time by Country"))),
                  tabPanel('graph 3', box(width = 12, title = "Top and bottom 15 Countries",
                                          status = "primary", solidHeader = TRUE,
                                          plotlyOutput('TopBottom15')),
                           box(width = 12,
                               p("This is a textbox to discribe the Top and bottom 15 Countries"))),
                  tabPanel('graph 4', box(width = 12, title = "Country Comparison of the Happiest and least Happiest", 
                                          status = "primary", solidHeader = TRUE, 
                                          plotOutput('lowestHighestCountryComparsion')),                           
                           box(width = 12, 
                               p("This is a textbox to discribe the Country Comparison of the Happiest and least Happiest")))
                ) # tabsetPanel 
              )),
      tabItem(tabName = "warandpeace",
              fluidRow(
                tabsetPanel(
                  tabPanel('Background', width = 12, 
                           box(width = 12, htmlOutput('warandpeace.background.content', style = "height: 300px; overflow-y: auto;")),
                               tabsetPanel(
                                 tabPanel("About Correlate of War Project", 
                                          box(width = 12, htmlOutput('about.COW.content', style = "height: 400px; overflow-y: auto;")
                                              )),
                                tabPanel("About ACLED Cured Data", 
                                         box(width = 12, htmlOutput('about.ACLED.content'))
                                 ))),
                  tabPanel('graph 1', box(width = 12,
                                          plotOutput('TreeMapConflicts')),
                           box(width = 12, p("Textbox to discribe the tree map conflict"))),
                  tabPanel('graph 2', box(width = 12, title = 'War Outcome of Countries', 
                                          status = "primary", solidHeader = TRUE,
                                          # select button used when you want to select multiple things
                                          selectInput("Outcome_check", "Select Continent",
                                                      # names of the valid choices
                                                      choices =
                                                        list('Overview', 'Africa', 'Americas', 
                                                             'Asia' ,'Europe', 'Oceania'),
                                                      selected = 'Overview'),
                                          plotlyOutput('WarOutcomes')
                  ),
                  box(width = 12, 
                      p("Textbox to discribe the War Outcome of Countries"))),
                  tabPanel('graph 3', fluidRow(box(title = "Happiness and Conflict Across the World", 
                                                   status = "primary", solidHeader = TRUE,
                                                   width = 12, sliderInput("year_slider", "Select Year",
                                                                           min = 2005,
                                                                           max = 2022,
                                                                           value = 2022, step = 1),
                                                   fluidRow(box(status = 'primary', solidHeader = TRUE,
                                                                width = 12, plotlyOutput('WHchoroplethMap')),
                                                            box(status = 'primary', solidHeader = TRUE,
                                                                width = 12, plotlyOutput('WDchloroplethMap')),
                                                            box(status = 'primary', solidHeader = TRUE,
                                                                width = 12, plotlyOutput('WVchloroplethMap'))
                                                   )), # outer box
                                               box(title = "Demonstrations by Continent",
                                                   status = "primary", solidHeader = TRUE,
                                                   width = 6, plotlyOutput("stackedDemonstrations")),
                                               box(title = "Violence by Continent",
                                                   status = "primary", solidHeader = TRUE,
                                                   width = 6, plotlyOutput("stackedViolence")),
                                               box(width = 12, 
                                               p("Textbox discription for Happiness and Conflict Across 
                                                                 the World"))
                  )) #tabPanel
                )) # fluidrow
      ), # tabItem3
      tabItem(tabName = "works",
              fluidRow(box(width = 12, title = "Works Cited", htmlOutput('works.cited.content')))
      ) # tabItem4
    ) # tabItems 
  ) # dashboard body
)

# Define server logic
server <- function(input, output) {
  # reactive functions
  filtered.WH.data <- reactive({
    world.filtered.data <- world.map
    world.filtered.data <- world.filtered.data[world.filtered.data$Year == input$year_slider, ]
    return(world.filtered.data)
  })
  
  # reactive functions
  filtered.WD.data <- reactive({
    world.demonstrations.filtered.data <- world.demonstrations
    world.demonstrations.filtered.data <- world.demonstrations.filtered.data[world.demonstrations.filtered.data$Year
                                                                             == input$year_slider, ]
    return(world.demonstrations.filtered.data)
  })
  
  # reactive functions
  filtered.WV.data <- reactive({
    world.violence.filtered.data <- world.violence
    world.violence.filtered.data <- world.violence.filtered.data[world.violence.filtered.data$Year
                                                                 == input$year_slider, ]
    return(world.violence.filtered.data)
  })
  
  # filter whi.df.clean to the specified year dictated by the radioButton
  happy.df <- reactive({
    happy <- whi.df.clean
    happy <- happy[, colnames(happy) %in% input$Happiness_check, drop = FALSE]
    return(happy)
  })
  
  # text description 
  output$projectIntroduction <- renderUI({
    tagList(projectIntroduction.content)
  })
  
  output$influenceofHappiness.background <- renderUI({
    tagList(influenceofHappiness.background.content)
  })
  
  output$WHR <- renderUI({
    tagList(WHR.content)
  })
  
  output$correlationMaxtrixText <-renderUI({
    tagList(correlationMaxtrixText.content)
  })
  
  output$happinessIndicatorByContinent <- renderUI({
    tagList(happinessIndicatorByContinent.content)
  })

  output$happinessIndicatorDistribution <- renderUI({
    tagList(happinessIndicatorDistribution.content)
  })
  
  output$trendBackground <- renderUI({
    tagList(trendBackground.content)
  })
  
  output$happinessByContinentText <- renderUI({
    tagList(happinessByContinentText.content)
  })
  
  output$warandpeace.background.content <- renderUI({
    tagList(warandpeace.background.content)
  })
  
  output$about.COW.content <- renderUI({
    tagList(about.COW.content)
  })
  
  output$about.ACLED.content <- renderUI({
    tagList(about.ACLED.content)
  })
  
  output$works.cited.content <- renderUI({
    tagList(works.cited.content)
  })
  
  output$correlationMatrix <- renderPlotly({
    ggplotly(correlation.matrix)
  })
  
  output$happinessSubregionTrend <- renderPlotly({
    ggplotly(trend)
  })
  
  output$HappinessIndicator <- renderPlot({
    data %>%
      ggplot(aes(y=region, x=.data[[input$Happiness_check]])) +
      geom_violin(aes(fill=region), alpha=0.5, color=NA, scale="area", show.legend=FALSE) +
      geom_boxplot(aes(fill=NA), alpha=0.3, width=0.15, outlier.alpha=1, show.legend=FALSE) +
      scale_fill_viridis(discrete=TRUE) +
      labs("title" = paste("Distribution of", input$Happiness_check, "by Continent"), x= input$Happiness_check)
  })
  
  output$TopBottom15 <- renderPlotly({
    ggplotly(top.bottom.plot)
  })
  
  output$happinessTrend<- renderPlotly({
    ggplotly(happiness.trend)
  })
  
  output$dumbellWHITrend <- renderPlot({
    plot <- life.Ladder.Difference.by.country(life.Ladder.Difference, input$dumbell_check)
    plot
  })
  # Happiness
  output$WHIandHappinessByCountinent <- renderPlotly({
    plot <- regression_lines_of_indicators(data, input$Corruption_check, input$WHI_check)
    ggplotly(plot)
  })
  
  output$lowestHighestCountryComparsion <- renderPlot({
    final_plot
  })
  
  # warandpeace
  output$TreeMapConflicts <- renderPlot({
    treemap.conflict <- treemap(inter.region.continent.join,
                                index = c('Continent', 'region.mirror'),
                                vSize = 'Occurrence',
                                type = 'index')
  })
  
  output$WarOutcomes <- renderPlotly({
    plot <- stackedbarbyRegion(interStateWar.State.Outcomes, input$Outcome_check)
    ggplotly(plot)
  })
  
  output$stackedDemonstrations <- renderPlotly({
    ggplotly(stacked.demonstrations)
  })
  
  output$stackedViolence <- renderPlotly({
    ggplotly(stacked.violence)
  })
  
  output$WHchoroplethMap <- renderPlotly({
    coul <- brewer.pal(n = 200, name = "YlOrRd") 
    # use data from filter.data to create display
    life.ladder.plot <- ggplot(filtered.WH.data(), aes(long, lat, group = group)) +
      geom_polygon(aes(fill = Life.Ladder, text = Country), color = "black", size = 0.2) +
      coord_quickmap() +
      theme_void() +
      scale_fill_gradientn(colors = coul, name = "Life.Ladder")+
      theme(legend.position = 'bottom') +
      labs(title = paste("Happiness Index across the World - Year", input$year_slider)) +
      ggeasy::easy_center_title()
    
    # tooltip will show life.ladder and country.name when you hover over country
    ggplotly(life.ladder.plot, tooltip = c("text", "Life.Ladder"))
  })
  
  output$WDchloroplethMap <- renderPlotly({
    coul <- brewer.pal(n = 200, name = "YlOrRd")
    
    demonstrations.plot <- ggplot(filtered.WD.data(), aes(long, lat, group = group)) +
      geom_polygon(aes(fill = Events, text = Country), color = 'black', size = 0.2) +
      coord_quickmap() +
      theme_void() +
      scale_fill_gradientn(colors = coul, name = "Events")+
      theme(legend.position = 'bottom') +
      labs(title = "Demonstrations Across the World") +
      ggeasy::easy_center_title()
    
    ggplotly(demonstrations.plot, tooltip = c("text", "Events"))
  })
  
  output$WVchloroplethMap <- renderPlotly({
    coul <- brewer.pal(n = 200, name = "YlOrRd")
    
    violence.plot <- ggplot(filtered.WV.data(), aes(long, lat, group = group)) +
      geom_polygon(aes(fill = Events, text = Country), color = 'black', size = 0.2) +
      coord_quickmap() +
      theme_void() +
      scale_fill_gradientn(colors = coul, name = "Events")+
      theme(legend.position = 'bottom') +
      labs(title = "Violence Across the World") +
      ggeasy::easy_center_title()
    
    ggplotly(violence.plot, tooltip = c("text", "Events"))
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
