library(shiny)
library(shinydashboard)

# source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/DataAnaylsis.R")
source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/Plotting.R")

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "World Happiness Index"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Happiness", tabName = "Happiness", icon = icon("globe")),
      menuItem("GDP", tabName = "GDP", icon = icon("globe"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                box(title = "Corr. of Happiness Indicators", 
                    status = "primary", solidHeader = TRUE,
                    width = fillRow(height = 7), plotlyOutput('corrality'))
              ),
              fluidRow(
                box(title = "Corr. Matrix of Happiness Indicators", 
                    status = "primary", solidHeader = TRUE,
                    width = 5, plotlyOutput('correlationMatrix')),
                box(title = "GDP and Confidence in Government", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, plotOutput('GDPConfidence'))
              ), # fluidrow
              fluidRow(
                box(title = "Log GDP by Sub-Region", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, plotOutput('densitySubRegion')),
                box(title = "Happiness Index across the World", 
                    status = "primary", solidHeader = TRUE,
                    width = 5, plotOutput('choroplethMapStag'))
              ) # fluidrow
      ), # tabitem1
      tabItem(tabName = "Happiness",
              fluidRow(
                box(title = "Happiness Index across the World", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, plotlyOutput('choroplethMap')),
                box(width = 5,
                    sliderInput("year_slider", "Select Year",
                                min = min(world.map$Year),
                                max = max(world.map$Year),
                                value = min(world.map$Year), step = 1))
              ), # fluidrow  
              fluidRow(
                box(title = "Happiness Index Data Check", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, plotlyOutput('HappinessIndicator')),
                box(width = 5,
                    radioButtons("Happiness_check", "Select Happiness Indicator",
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
                ) # box
              ) # fluidrow 
      ), # tabItem2
      tabItem(tabName = "GDP",
              fluidRow(
                box(title = "GDP Index by Continent", 
                    status = "primary", solidHeader = TRUE,
                    width = 5,
                    tabsetPanel(
                      tabPanel("graph 1", plotOutput('GDPContinentScatter')),
                      tabPanel("graph 2", plotOutput('GDPContinentViolin')),
                    ) # tabsetPanel
                ), # box
                box(title = "GDP Index By Continent", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, plotlyOutput('GDPperContinent')),
                box(width = 7,
                    radioButtons("Continent_check", "Select Continent",
                                       choiceNames =
                                         list('Africa', 'Americas', 'Asia' ,'Europe', 'Oceania'),
                                       choiceValues =
                                         list('Africa', 'Americas', 'Asia' ,'Europe', 'Oceania'))     
                    ) # box
              ) # fluidrow
      ) # tabItem3
    ) # tabItems
  ) # dashboard body
)

# Define server logic
server <- function(input, output) {
  filtered.data <- reactive({
    world.filtered.data <- world.map
    world.filtered.data <- world.filtered.data[world.filtered.data$Year == input$year_slider, ]
    return(world.filtered.data)
  })
  
  GDP.data <- reactive({
    gdp.continent <- whi.df.clean
    gdp.continent <- gdp.continent[gdp.continent$region == input$Continent_check, ]
    return(gdp.continent)
  })
  
  happy.df <- reactive({
    happy <- whi.df.clean
    happy <- happy[, colnames(happy) %in% input$Happiness_check, drop = FALSE]
    return(happy)
  })
  
  # Happiness tab
  output$choroplethMap <- renderPlotly({
    life.ladder.plot <- ggplot(filtered.data(), aes(long, lat, group = group)) +
      geom_polygon(aes(fill = Life.Ladder, text = Country.Name), color = "black", size = 0.2) +
      coord_quickmap() +
      theme_void() +
      scale_fill_viridis(option = 'magma', name = "Index") +
      theme(legend.position = 'bottom') +
      labs(title = paste("Happiness Index across the World - Year", input$year_slider)) +
      ggeasy::easy_center_title()
    
    ggplotly(life.ladder.plot, tooltip = c("text", "Life.Ladder"))
  })
  
  output$HappinessIndicator <- renderPlotly({

    output$HappinessIndicator <- renderPlotly({
      happiness.boxplot <- ggplot(whi.df.clean, 
                                  aes(x = region, 
                                      y = .data[[input$Happiness_check]], fill = region)) +
        geom_boxplot(notch = TRUE) +
        labs(y = input$Happiness_check)
      
      ggplotly(happiness.boxplot)
    })
  })
  # GDP tab
  output$GDPContinentScatter <- renderPlot({
    scatter.plot.GDP.By.Continent  
  })
  
  output$GDPContinentViolin <- renderPlot({
    violin.GDP.by.Continent  
  })
  
  output$GDPperContinent <- renderPlotly({
   density.GDP <-ggplot(GDP.data(), 
                        aes(Log.GDP.Per.Capita,
                            color = sub.region, 
                            fill = sub.region)) +
    geom_density(alpha = 0.3) +
    labs(x = "GDP per Capita")
  
    ggplotly(density.GDP)
  })
  
  # dashboard page
  output$choroplethMapStag <- renderPlot({
    life.ladder.plot
  })
  
  output$GDPConfidence <- renderPlot({
    GDP.Confidence
  })
  
  output$densitySubRegion<- renderPlot({
    density.of.GDP.By.SubRegion
  })
  
  output$correlationMatrix <- renderPlotly({
  ggplotly(correlation.matrix)
  })
  
  output$corrality<- renderPlotly({
    ggplotly(corrality) %>%
      layout(xaxis = list(title = ""), yaxis = list(title = ""))
  })
  
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
