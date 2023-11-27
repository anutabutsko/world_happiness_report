library(shiny)
library(shinydashboard)

# source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/DataAnaylsis.R")
source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/Plotting.R")

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "World Happiness Index"),
  dashboardSidebar(
    sidebarMenu(
      # dashboard has the big picture information about the World Happiness Report (WHR)
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      # this tab look further into the WHR
      menuItem("Happiness", tabName = "Happiness", icon = icon("globe")),
      # this tab has a focus on log GDP per Capita within the WHR
      menuItem("GDP", tabName = "GDP", icon = icon("globe"))
    )
  ),
  dashboardBody(
    tabItems(
      # what you will see when you are in the dashboard tab
      tabItem(tabName = "dashboard",
              # at the very top, you will see a corrality maxtrix that is a 
              # ggplotly interactive graph
              fluidRow(
                box(title = "Corr. of Happiness Indicators", 
                    status = "primary", solidHeader = TRUE,
                    width = fillRow(height = 7), plotlyOutput('corrality'))
              ),
              # underneath you will have two graphs side by side
              fluidRow(
                # this is a cleaner correlation matrix that is also a ggplotly 
                # interacitve
                box(title = "Corr. Matrix of Happiness Indicators", 
                    status = "primary", solidHeader = TRUE,
                    width = 5, plotlyOutput('correlationMatrix')),
                # This is the graph comparing GDP and Confidence of Government
                box(title = "GDP and Confidence in Government", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, plotOutput('GDPConfidence'))
              ), # fluidrow
              # underneath you will have two more graphs side by side
              fluidRow(
                # this is looking at GDP per capita based off Sub-Region
                box(title = "Log GDP Per Capita by Sub-Region", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, plotOutput('GDPBySubRegion')),
                # this is the chlophleth map of the most updated 
                # life.ladder index that a country has submitted
                box(title = "Happiness Index across the World", 
                    status = "primary", solidHeader = TRUE,
                    width = 5, plotOutput('choroplethMapStag'))
              ) # fluidrow
      ), # tabitem1
      # what you will see when you are in the Happiness tab
      tabItem(tabName = "Happiness",
              fluidRow(
                # this is the same cloropleth map from the dashboard
                # but it is now interactive 
                box(title = "Happiness Index across the World", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, plotlyOutput('choroplethMap')),
                # enables you to change the graph based off the year
                box(width = 5,
                    sliderInput("year_slider", "Select Year",
                                min = min(world.map$Year),
                                max = max(world.map$Year),
                                value = min(world.map$Year), step = 1))
              ), # fluidrow  
              # underneath we are looking at the boxplot for each happiness indicator
              fluidRow(
                box(title = "Happiness Index Data Check", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, plotlyOutput('HappinessIndicator')),
                box(width = 5,
                    # radioButton used when you only want one thing selected
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
                ) # box
              ) # fluidrow 
      ), # tabItem2
      # what you will see when you are in the Happiness tab
      tabItem(tabName = "GDP",
              fluidRow(
                # looking at the many graphs of GDP
                # this initial box contains two overarching view of GDP 
                # by Continent
                box(title = "GDP Index by Continent", 
                    status = "primary", solidHeader = TRUE,
                    width = 5,
                    # alloing multiple graphs to be showin on the same window
                    tabsetPanel(
                      tabPanel("graph 1", plotOutput('GDPContinentScatter')),
                      tabPanel("graph 2", plotOutput('GDPContinentViolin')),
                      tabPanel("graph 3", plotOutput('densitySubRegion'))
                    ) # tabsetPanel
                ), # box
                # This one looks at density plots based off sub.region of the country
                # looking one step below continent
                box(title = "GDP Index By Continent", 
                    status = "primary", solidHeader = TRUE,
                    width = 7, plotlyOutput('GDPperContinent')),
                box(width = 7,
                    # radioButton used when you only want one thing selected
                    radioButtons("Continent_check", "Select Continent",
                                 # names of the valid choices
                                 choiceNames =
                                   list('Africa', 'Americas', '
                                        Asia' ,'Europe', 'Oceania'),
                                 choiceValues =
                                         list('Africa', 'Americas', 
                                              'Asia' ,'Europe', 'Oceania'))     
                    ) # box
              ) # fluidrow
      ) # tabItem3
    ) # tabItems
  ) # dashboard body
)

# Define server logic
server <- function(input, output) {
  # reactive allows user inputs to change the graph
  # filtering world.map to the specified year dictated by the slider
  filtered.data <- reactive({
    world.filtered.data <- world.map
    world.filtered.data <- world.filtered.data[world.filtered.data$Year == input$year_slider, ]
    return(world.filtered.data)
  })
  
  # filter whi.df.clean to the specified year dictated by the radioButton
  GDP.data <- reactive({
    gdp.continent <- whi.df.clean
    gdp.continent <- gdp.continent[gdp.continent$region == input$Continent_check, ]
    return(gdp.continent)
  })
  
  # filter whi.df.clean to the specified year dictated by the radioButton
  happy.df <- reactive({
    happy <- whi.df.clean
    happy <- happy[, colnames(happy) %in% input$Happiness_check, drop = FALSE]
    return(happy)
  })
  
  # Happiness tab
  # plot for the interactie choropleth Map
  output$choroplethMap <- renderPlotly({
    # use data from filter.data to create display
    life.ladder.plot <- ggplot(filtered.data(), aes(long, lat, group = group)) +
      geom_polygon(aes(fill = Life.Ladder, text = Country.Name), color = "black", size = 0.2) +
      coord_quickmap() +
      theme_void() +
      scale_fill_viridis(option = 'magma', name = "Index") +
      theme(legend.position = 'bottom') +
      labs(title = paste("Happiness Index across the World - Year", input$year_slider)) +
      ggeasy::easy_center_title()
    
    # tooltip will show life.ladder and country.name when you hover over country
    ggplotly(life.ladder.plot, tooltip = c("text", "Life.Ladder"))
  })
  
  # these are the boxplots on the Happiness Tab
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
  
  # GDP tab
  # Look at Plotting.R for description
  output$GDPContinentScatter <- renderPlot({
    scatter.plot.GDP.By.Continent  
  })
  
  # Look at Plotting.R for description
  output$GDPContinentViolin <- renderPlot({
    violin.GDP.by.Continent  
  })
  
  # creating interactive density plots
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
  # Similar to cloropleth map but not interactive 
  output$choroplethMapStag <- renderPlot({
    life.ladder.plot
  })
  
  # Look at Plotting.R for description
  output$GDPConfidence <- renderPlot({
    GDP.Confidence
  })
  
  output$GDPBySubRegion <- renderPlot({
  histo.GDP.by.Sub.Region
})
  # Look at Plotting.R for description
  output$densitySubRegion<- renderPlot({
    density.of.GDP.By.SubRegion
  })
  
  # gives a general overview of correlation
  # between all the Happiness index
  output$correlationMatrix <- renderPlotly({
  ggplotly(correlation.matrix)
  })
  
  # same thing as correlation Matrix, but alot
  # more indepth
  output$corrality<- renderPlotly({
    ggplotly(corrality) %>%
      layout(xaxis = list(title = ""), yaxis = list(title = ""))
  })

}

# Run the Shiny app
shinyApp(ui = ui, server = server)
