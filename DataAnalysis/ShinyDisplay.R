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
      menuItem("Works Cited", tabName = 'works', icon = icon("globe"))
    )
  ),
  dashboardBody(
    tabItems(
      # what you will see when you are in the dashboard tab
      tabItem(tabName = "exploratory",
              fluidRow(
                tabsetPanel(
                  tabPanel('Background',box(width = 12,
                                            p("General Discription for the panels within the exploratory page."))),
                  tabPanel('graph 1', tabsetPanel(
                    tabPanel("Happiness Trend By Continent",
                             box(title = "Happiness Lvl Over The Years By Continent", 
                                          status = "primary", solidHeader = TRUE,
                                          width = 6, plotlyOutput('happinessTrend')),
                             box(width = 6, p("This is a textbox to discribe the happiness trend by Continent"))),
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
              )), # tabItem1
      tabItem(tabName = "Happiness",
              fluidRow(
                tabsetPanel(
                  tabPanel('Background', box(width = 12, 
                                             p("General Discription for the panels within the happiness page."))),
                  tabPanel('graph 1', box(title = "Corr. Matrix of Happiness Indicators", 
                                          status = "primary", solidHeader = TRUE,
                                          width = 12, plotlyOutput('correlationMatrix')),
                           box(width = 12, 
                               p("Textbox to discribe corr. matrix of Happiness Indicators"))),
                  tabPanel('graph 2', box(width = 12, 
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
                           box(width = 12, 
                               p("Textbox to discribe happiness Indicators and Happiness by Continent "))),
                  tabPanel('graph 3', box(title = "Happiness Indicator Distribution", 
                                          status = "primary", solidHeader = TRUE,
                                          width = 12, plotOutput('HappinessIndicator'),
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
                  box(width = 12, 
                      p("Textbox to discribe Happiness Indicator Distribution"))
                  ) # tabPanel
                ))), # tabItem2
      tabItem(tabName = "warandpeace",
              fluidRow(
                tabsetPanel(
                  tabPanel('Background', width = 12, 
                           box(width = 12, h3("Happiness and Conflict"), 
                               p("This section delves into the correlation between war and conflict and a country's Happiness Score. 
                               The project draws upon one dataset from the Correlates of War Project and two datasets from the ACLED curated data catalog. 
                               The correlation between war and conflict and a country's happiness level is explored, recognizing that ongoing conflicts can lead to a 
                               decline in the maintenance of social infrastructure. This page examines potential trends between global conflicts and the Happiness 
                               Scores of countries, shedding light on the complex interplay between geopolitical factors and well-being.") ,p(),
                               strong("The Correlate of War Project:"), p("The", span("Inter-State War", style = "color:blue"),"dataset 
                               contains wars between the years 1823-2003. The data helps to gain a better understanding about the possible state of countries during the years before 
                               the initial scores were taken."),p(),strong("ACLED Cured Data:"),
                               p("The", span("Number of demonstration events by country-year", style = "color:blue"), "and the", span("Number of political violence events by country-month-year", 
                                 style = "color:blue"), "span between the years 1997-2023. This dataset helps to gain a better understanding about the 
                                 possible state of countries during the same timeframe as the scores gained from the World Happiness Report.")),
                               tabsetPanel(
                                 tabPanel("About Correlate of War Project", 
                                          box(width = 12, strong("The Correlates of War (COW) project facilitates the collection, dissemination, and use of 
                                          free resource, quantitative data in international relations."), p(), p("The wars identifed in this dataset meet certain requirements:"),
                                              p("I. Wars that take place between or among states (members of theinterstate system)"), p("II. Sustained combat, involving organized armed forces, 
                                             resulting in a minimum of 1,000 battle-related combatant fatalities within a 12 month period"),
                                              p("III. A conflict is categorized as a war when both sides have armed forces capable of “effective resistance”"), p(),
                                              strong("Variables in dataset:"), p("WarNum - the number assigned to the war"), p("WarName - the name given to the war"),
                                              p("WarType - 1 = Inter-state war"), p("Ccode – the System Membership number (or Country Code) for the state participant"),
                                              p("State Name - the name of the System Member"), p("StartMonth1 - the month in which sustained combat began"),
                                              p("StartDay1 - the day on which sustained combat began"), p("StartYear1 - the year in which sustained combat began"),
                                              p("EndMonth1 - the month in which sustained combat ended, or the month of the last major engagement after which fatalities declined below the war fatality threshold"),
                                              p("EndDay1- the day on which sustained combat ended, or the day after the last major engagement after which fatalities declined below the war fatality threshold"),
                                              p("EndYear1 - the year in which sustained combat ended, or the year of the last major engagement after which fatalities declined below the war fatality threshold"),
                                              p("StartMonth2 - after a break in the fighting, the month in which sustained combat resumes"), p("StartDay2- after a break in the fighting, the day on which sustained combat resumes"),
                                              p("StartYear2 - after a break in the fighting, the year in which sustained combat resumes"), p("EndMonth2 - after fighting resumes, the month in which sustained combat ended, or the
                                            month of the last major engagement after which fatalities declined below the war fatality threshold"), p("EndDay2- after fighting resumes, the day on which sustained combat ended, or the day",
                                                  "after the last major engagement after which fatalities declined below the war fatality threshold:"), p("EndYear2 - after fighting resumes, the year in which sustained combat ended, or the year
                                          of the last major engagement after which fatalities declined below the war fatality threshold"), p("TransFrom - the War"),p("WhereFought - Region(s) where combat involving the state occurred. Values are:"),
                                                em("1 = W. Hemisphere"),p(), em("2 = Europe"), p(),em("4 = Africa"),p(),em("6 = Middle East"), p(),em("7 = Asia"),p(),em("9 = Oceania"),p(),
                                                em("11 = Europe & Middle East"), p(),em("12 = Europe & Asia"), p(),em("13 = W. Hemisphere & Asia"),p(),em("14 = Europe, Africa & Middle East"),p(),
                                                em("15 = Europe, Africa, Middle East, & Asia"), em("16 = Africa, Middle East, Asia & Oceania"), p(), em("17 = Asia & Oceania"), em("18 = Africa & Middle East"),p(),
                                                em("19 = Europe, Africa, Middle East, Asia & Oceania"),p(), p("Initiator - whether the state initiated the war"),em("1 = Yes"), p(),em("2 = No"),p(),p("TransTo - the WarNum of the war that this war transformed into"),p("Outcome code"), 
                                                em("1 = Winner"), p(),em("2 = Loser"),p(),em("3 = Compromise/Tied"),p(),em("4 = The war was transformed into another type of war"),p(),em("5 = The war is ongoing as of 12/31/2007"),p(),em("6 = Stalemate"),p(),em("7 = Conflict continues at below war level"),p(), em("8 = changed sides"),p(),
                                                p("BatDeaths - the battle-related combatant fatalities suffered by the state"), p(strong("Important: "), "-9 = unknown , -7 = war ongoing as of 12/31/2007, -8 =  Not applicable")
                                              )),
                                tabPanel("About ACLED Cured Data", 
                                         box(width = 12,
                                             strong("The ACLED is an event-based data project designed 
                                             for disaggregated conflict analysis and crisis mapping."),
                                             p(), p("Demonstrations: All protest and violent demonstration events (may overlap with political violence files as they both include Excessive force against protesters)"),
                                             p("Political Violence: All battle, explosions/remote violence, and violence against civilians events"), p(),
                                             strong("Variables in dataset:"), p("Country - Country it occurred "), p("Month - month it occured"), p("Year - year it occured"), p("Events - Occurrence of Instances"))
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
                                                                           min = 1997,
                                                                           max = 2023,
                                                                           value = 2023, step = 1),
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
              fluidRow(box(width = 12, title = "Works Cited", p(em("COW War Data, 1816 – 2007 (v4.0) – Correlates of War"), ". (2020). Correlatesofwar.org. https://correlatesofwar.org/data-sets/cow-war/"),
                           p(em("Curated Data - ACLED"), ". (2023, August 15). ACLED. https://acleddata.com/curated-data-files/#peacekeepers"),
                               p(em("Facebook logo"), ". (2023). R-Charts.com. https://r-charts.com/distribution/dumbbell-plot-ggplot2/"),
                                 p("Holtz, Y. (2023)." , em("The R Graph Gallery – Help and inspiration for R charts"), ". The R Graph Gallery. https://r-graph-gallery.com/"),
                                    p(em("Shiny - Build a user interface"), ". (2023). Posit.co. https://shiny.posit.co/r/getstarted/shiny-basics/lesson2/"),
                                    p("to, I. (2023, January 12).", em("Introduction to Data Visualization with ggplot2"),". Datacamp.com; DataCamp. https://www.datacamp.com/courses/introduction-to-data-visualization-with-ggplot2")))
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
  output$correlationMatrix <- renderPlotly({
    ggplotly(correlation.matrix)
  })

  # output$choroplethMapStag <- renderPlotly({
  #   ggplotly(life.ladder.plot)
  # })
  
  output$happinessSubregionTrend <- renderPlotly({
    ggplotly(trend)
  })
  
  output$HappinessIndicator <- renderPlot({
    data %>%
      ggplot(aes(y=region, x=.data[[input$Happiness_check]])) +
      geom_violin(aes(fill=region), alpha=0.5, color=NA, scale="area", show.legend=FALSE) +
      geom_boxplot(aes(fill=NA), alpha=0.3, width=0.15, outlier.alpha=1, show.legend=FALSE) +
      scale_fill_viridis(discrete=TRUE) +
      theme_minimal()+
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
      theme_minimal() +
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
      theme_minimal() +
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
      theme_minimal() +
      scale_fill_gradientn(colors = coul, name = "Events")+
      theme(legend.position = 'bottom') +
      labs(title = "Violence Across the World") +
      ggeasy::easy_center_title()
    
    ggplotly(violence.plot, tooltip = c("text", "Events"))
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
