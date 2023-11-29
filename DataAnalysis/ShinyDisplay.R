library(shiny)
library(shinydashboard)
source('Plotting.R')
# source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/DataAnaylsis.R")
# source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/Plotting.R")

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "World Happiness Index"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Exploratory Page", tabName = "exploratory", icon = icon("dashboard")),
      menuItem("Influencers of Happiness", tabName = "Happiness", icon = icon("globe")),
      menuItem("Happiness and Conflicts", tabName = "warandpeace", icon = icon("globe")),
      menuItem("Exploratory Plots", tabName = 'plotting', icon = icon("globe"))
    )
  ),
  dashboardBody(
    tabItems(
      # what you will see when you are in the dashboard tab
      tabItem(tabName = "exploratory",
              fluidRow(
                box(title = "Happiness Lvl Over The Years By Continent", 
                    status = "primary", solidHeader = TRUE,
                    width = 6, plotlyOutput('happinessTrend')),
                box(title = "Happiness Index across the World", 
                    status = "primary", solidHeader = TRUE,
                    width = 6, plotlyOutput('choroplethMapStag'))
              ), # fluidRow
              fluidRow(
                box(title = "Happiness Index Data Check", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, radioButtons("Happiness_check", "Select Happiness Indicator",
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
                                                   'Negative.Affect', 'Social.Support')), # radio button
                    plotlyOutput('HappinessIndicator')),
                box(title = "Corr. Matrix of Happiness Indicators", 
                    status = "primary", solidHeader = TRUE,
                    width = 5, plotlyOutput('correlationMatrix'))
              ) # fluidrow 
      ), # tabitem1
      tabItem(tabName = "Happiness",
              tabsetPanel(
                tabPanel('graph 1', box(width = 12, 
                                        title = "Happiness Indicators and Happiness by Continent", 
                                        status = "primary", solidHeader = TRUE,
                                        # select button used when you want to select multiple things
                                        selectInput("Corruption_check", "Select Continent",
                                                    # names of the valid choices
                                                    choices =
                                                      list('Africa', 'Americas', 
                                                           'Asia' ,'Europe', 'Oceania'), selected = 'Africa'),
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
                                        plotlyOutput('WHIandHappinessByCountinent'))),
                tabPanel('graph 2', box(width = 12,title = "Country Comparison of the Happiest and least Happiest", 
                                        status = "primary", solidHeader = TRUE, 
                                        plotOutput('lowestHighestCountryComparsion')))
              ) # tabsetPanel
      ), # tabItem2
      tabItem(tabName = "warandpeace",
              tabsetPanel(
                tabPanel('graph 1', box(width = 12,
                                        plotOutput('TreeMapConflicts'))),
                tabPanel('graph 2', box(width = 12, title = 'War Outcome of Countries', 
                                        status = "primary", solidHeader = TRUE,
                                        # select button used when you want to select multiple things
                                        selectInput("Outcome_check", "Select Continent",
                                                    # names of the valid choices
                                                    choices =
                                                      list('Overview', 'Africa', 'Americas', 
                                                           'Asia' ,'Europe', 'Oceania'), selected = 'Overview'),
                                        plotlyOutput('WarOutcomes')
                )),
                tabPanel('graph 3', fluidRow(box(title = "Happiness and Conflict Across the World", 
                                                 status = "primary", solidHeader = TRUE,
                                                 width = 12, sliderInput("year_slider", "Select Year",
                                                                         min = 1997,
                                                                         max = 2023,
                                                                         value = 2023, step = 1),
                                                 fluidRow(box(status = 'primary', solidHeader = TRUE,
                                                              width = 12, plotlyOutput('WHchoroplethMap')),
                                                          box(status = 'primary', solidHeader = TRUE,
                                                              width = 12, plotlyOutput('WDchloroplethMap')),
                                                          box(status = 'primary', solidHeader = TRUE,
                                                              width = 12, plotlyOutput('WVchloroplethMap'))
                                                 ) # inner fluidRow
                ), # outer box
                box(title = "Demonstrations by Continent",
                    status = "primary", solidHeader = TRUE,
                    width = 6, plotlyOutput("stackedDemonstrations")),
                box(title = "Violence by Continent",
                    status = "primary", solidHeader = TRUE,
                    width = 6, plotlyOutput("stackedViolence")),
                )), #outer fluidRow & tabPanel
              ) # tabsetPanel
      ), # tabItem3
      tabItem(tabName = "plotting",
              tabsetPanel(
                tabPanel('graph 1', box(width = 12)),
                tabPanel('graph 2', box(width = 12)),
                tabPanel('graph 3', box(width = 12))
              ) # tabsetPanel
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
  # dashboard 
  
  # gives a general overview of correlation
  # between all the Happiness index
  output$correlationMatrix <- renderPlotly({
    ggplotly(correlation.matrix)
  })
  
  output$choroplethMapStag <- renderPlotly({
    ggplotly(life.ladder.plot)
  })
  
  output$HappinessIndicator <- renderPlotly({
    happiness.boxplot <- ggplot(whi.df.clean, 
                                aes(x = region, 
                                    y = .data[[input$Happiness_check]], 
                                    fill = region)) +
      geom_boxplot(notch = TRUE) +
      # set ylabel to the colname that we are looking at
      labs(y = input$Happiness_check)
    
    ggplotly(happiness.boxplot)
  })
  
  output$happinessTrend<- renderPlotly({
    ggplotly(happiness.trend)
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
