# # # backup
# 
# library(shiny)
# library(shinydashboard)
# library(cowplot)
# 
# source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/DataAnaylsis.R")
# source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/Plotting.R")
# 
# # Define UI
# ui <- dashboardPage(
#   dashboardHeader(title = "World Happiness Index"),
#   dashboardSidebar(
#     sidebarMenu(
#       menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
#       menuItem("Widgets", tabName = "widgets", icon = icon("th"))
#     )
#   ),
#   dashboardBody(
#     tabItems(
#       tabItem(tabName = "dashboard",
#               fluidRow(
#                 box(title = "Happiness Index across the World", 
#                     status = "primary", solidHeader = TRUE,
#                     width = 7, plotlyOutput('choroplethMap')),
#                 box(width = 7,
#                     sliderInput("year_slider", "Select Year",
#                                 min = min(world.map$Year),
#                                 max = max(world.map$Year),
#                                 value = min(world.map$Year), step = 1))
#               ) # fluidrow
#       ), # tabitem1
#       tabItem(tabName = "widgets",
#               fluidRow(
#                 box(title = "Happiness Index by Continent", 
#                     status = "primary", solidHeader = TRUE,
#                     width = 7, plotOutput('violinPlot')),
#               ) # fluidrow
#       ) # tabItem2
#     ) # tabItems
#   ) # dashboard body
# )
# 
# # Define server logic
# server <- function(input, output) {
#   filtered.data <- reactive({
#     world.filtered.data <- world.map
#     world.filtered.data <- world.filtered.data[world.filtered.data$Year == input$year_slider, ]
#     return(world.filtered.data)
#   })
#   
#   output$choroplethMap <- renderPlotly({
#     life.ladder.plot <- ggplot(filtered.data(), aes(long, lat, group = group)) +
#       geom_polygon(aes(fill = Life.Ladder, text = Country.Name), color = "black", size = 0.2) +
#       coord_quickmap() +
#       theme_void() +
#       scale_fill_viridis(option = 'magma', name = "Index") +
#       theme(legend.position = 'bottom') +
#       labs(title = paste("Happiness Index across the World - Year", input$year_slider)) +
#       ggeasy::easy_center_title()
#     
#     ggplotly(life.ladder.plot, tooltip = c("text", "Life.Ladder"))
#   })
#   
#   output$violinPlot <- renderPlot({
#     # Assuming you have a ggplot object named violin.GDP.by.Continent
#     # If it's not available, you might need to create it here or source the code that creates it
#     violin.GDP.by.Continent
#   # })
# }
# 
# # Run the Shiny app
# shinyApp(ui = ui, server = server)
# 
# 
# # library(shiny)
# # library(shinydashboard)
# # library(cowplot)
# # 
# # # Load your data - adjust the path accordingly
# # source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/DataAnaylsis.R")
# # source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/Plotting.R")
# # 
# # # Calculate summary data
# # # by_continent <- whi.df.clean %>%
# # #   group_by(Continent) %>%
# # #   summarise(n = n(), Log.GDP.Per.Capita = mean(Log.GDP.Per.Capita, na.rm = TRUE))
# # 
# # # Define UI
# # ui <- dashboardPage(
# #   dashboardHeader(title = "World Happiness Index"),
# #   dashboardSidebar(
# #     sidebarMenu(
# #       menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
# #       menuItem("Widgets", tabName = "widgets", icon = icon("th"))
# #     )
# #   ),
# #   dashboardBody(
# #     tabItems(
# #       tabItem(tabName = "dashboard",
# #               fluidRow(
# #                 box(title = "Happiness Index across the World", 
# #                     status = "primary", solidHeader = TRUE,
# #                     width = 7, plotlyOutput('choroplethMap')),
# #                 box(wiedth = 7,
# #                     sliderInput("year_slider", "Select Year",
# #                                 min = min(world.map$Year),
# #                                 max = max(world.map$Year),
# #                                 value = min(world.map$Year), step = 1))
# #               ) # fluidrow
# #       ), # tabitem1
# #       tabItem(tabName = "widgets",
# #               fluidRow(
# #                 box(title = "Happiness Index by Continent", 
# #                     status = "primary", solidHeader = TRUE,
# #                     width = 7, plotlyOutput('violinPlot')),
# #               ) # fluidrow
# #       ) # tabItem2
# #     ) # tabItems
# #     ) # dashboard body
# # )
# # 
# # # Define server logic
# # server <- function(input, output) {
# #   filtered.data <- reactive({
# #     world.filtered.data <- world.map
# #     world.filtered.data <- world.filtered.data[world.filtered.data$Year == input$year_slider, ]
# #     return(world.filtered.data)
# #   })
# #   
# #   output$choroplethMap <- renderPlotly({
# #     life.ladder.plot <- ggplot(filtered.data(), aes(long, lat, group = group)) +
# #       geom_polygon(aes(fill = Life.Ladder, text = Country.Name), color = "black", size = 0.2) +
# #       coord_quickmap() +
# #       theme_void() +
# #       scale_fill_viridis(option = 'magma', name = "Index") +
# #       theme(legend.position = 'bottom') +
# #       labs(title = paste("Happiness Index across the World - Year", input$year)) +
# #       ggeasy::easy_center_title()
# #     
# #     ggplotly(life.ladder.plot, tooltip = c("text", "Life.Ladder"))
# #     
# #   })
# #   
# #   output$violinPlot <- renderPlot({
# #     # violin.GDP.by.Continent
# #   })
# #   
# # }
# # 
# # # Run the Shiny app
# # shinyApp(ui = ui, server = server)
# 
# # Make sure to load your data and required packages
# # 
# # library(shiny)
# # library(shinydashboard)
# # library(cowplot)
# # # Load your data - adjust the path accordingly
# # source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/DataAnaylsis.R")
# # source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/Plotting.R")
# # 
# # by_continent <- whi.df.clean %>%
# #   group_by(Continent) %>%
# #   summarise(n=n(), Log.GDP.Per.Capita=mean(Log.GDP.Per.Capita, na.rm=TRUE))
# # 
# # 
# # # Define UI
# # ui <- dashboardPage(
# #   dashboardHeader(title = "World Happiness Index"),
# #   dashboardSidebar(
# #     sidebarMenu(
# #       menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
# #       menuItem("Widgets", tabName = "widgets", icon = icon("th"))
# #     )
# #   ),
# #   dashboardBody(
# #     tabItems(
# #       tabItem(tabName = "dashboard",
# #               fluidRow(
# #                 box(plotOutput("plot1", height = 500, width = 800)),
# #               )
# #       ),
# #       tabItem(tabName = "widgets",
# #               h2("Widgets tab content")
# #       )
# #     )
# #   )
# # )
# # 
# # # Define server logic
# # server <- function(input, output) {
# #   output$plot1 <- renderPlotly({
# #     data <- whi.df.clean
# #     
# #     # Plotting the violin plot and box plot
# #     p1 <- plot_ly(violin.GDP.by.Continent)
# #     # Plotting the density plot for Europe
# #     p2 <- plot_ly(density.GDP.by.Europe)
# #     p3 <- plot_ly(scatter.plot.GDP.By.Continent)
# #     p4 <- plot_ly(life.ladder.plot, tooltip = c("text", "Life.Ladder"))
# #     
# #     # Arrange the plots using subplot
# #     subplot(p1, p2, p3, p4, nrows = 2, shareX = TRUE) %>%
# #       layout(title = "Combined Plots")
# #   })
# # }
# # 
# # # Run the Shiny app
# # shinyApp(ui, server)
# 
# 
# # server <- function(input, output) {
# #   output$plot1 <- renderPlot({
# #     data <- war.count.by.country.continent
# #     counts <- table(data$Continent)
# #     barplot(counts, main = "Occurrences by Continent", xlab = "Continent", ylab = "Occurrences")
# #   })
# # }
# # 
# # # Make sure to load your data and required packages
# # 
# # library(shiny)
# # library(shinydashboard)
# # library(ggplot2)
# # library(viridis)
# # library(cowplot)
# # # Load your data - adjust the path accordingly
# # source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/DataAnaylsis.R")
# # source("/Users/yuhanburgess/Documents/GitHub/world_happiness_report/DataAnalysis/Plotting.R")
# # 
# # by_continent <- whi.df.clean %>%
# #   group_by(Continent) %>%
# #   summarise(n=n(), Log.GDP.Per.Capita=mean(Log.GDP.Per.Capita, na.rm=TRUE))
# # 
# # 
# # # Define UI
# # ui <- dashboardPage(
# #   dashboardHeader(title = "World Happiness Index"),
# #   dashboardSidebar(
# #     sidebarMenu(
# #       menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
# #       menuItem("Widgets", tabName = "widgets", icon = icon("th"))
# #     )
# #   ),
# #   dashboardBody(
# #     tabItems(
# #       tabItem(tabName = "dashboard",
# #               fluidRow(
# #                 box(plotOutput("plot1", height = 500, width = 800)),
# #               )
# #       ),
# #       tabItem(tabName = "widgets",
# #               h2("Widgets tab content")
# #       )
# #     )
# #   )
# # )
# # 
# # # Define server logic
# # server <- function(input, output) {
# #   output$plot1 <- renderPlot({
# #     data <- whi.df.clean
# #     
# #     # Plotting the violin plot and box plot
# #     p1 <- data %>%
# #       ggplot(aes(y = Continent, x = Log.GDP.Per.Capita)) +
# #       geom_violin(aes(fill = Continent), alpha = 0.5, color = NA, scale = "area") + 
# #       geom_boxplot(aes(fill = NA), alpha = 0.3, width = 0.15, outlier.alpha = 1) +
# #       scale_fill_viridis(discrete = TRUE, name = "Continent") +
# #       labs(title = "Distribution of GDP per Capita by Continent", x = "GDP per Capita", y = "Continent")
# #     
# #     # Plotting the density plot for Europe
# #     p2 <- data %>%
# #       filter(Continent == "Europe") %>%
# #       ggplot(aes(Log.GDP.Per.Capita, color = Regional.Indicator, fill = Regional.Indicator)) +
# #       geom_density(alpha = 0.3) +
# #       labs(title = "Europe", x = "GDP per Capita")
# #     
# #     # Combine the plots using cowplot
# #     combined_plot <- cowplot::plot_grid(p1, p2, ncol = 1, align = 'v', axis = 'l')
# #     
# #     # Return the combined plot
# #     print(combined_plot)
# #   })
# # }
# # 
# # # Run the Shiny app
# # shinyApp(ui, server)
# 
# 
# library(maps)
# library(dplyr)
# library(ggplot2)
# library(viridis)
# library(ggridges)
# library(data.table)
# library(ggeasy)
# 
# df <- whi.df.clean
# world.map <- map_data(map = "world")
# world.map <- world.map%>%
#   rename(Country.Name = region)
# 
# unique_world_map <- unique(world.map$Country.Name)
# 
# unique_df <- unique(df$Country.Name)
# 
# # Names in df that do not match names in world.map
# names_not_in_world_map <- setdiff(unique_df, unique_world_map)
# names_not_in_world_map2 <- setdiff(unique_world_map, unique_df)
# #
# print(names_not_in_world_map2)
# 
# # change the names to match df
# world.map <- world.map %>%
#   mutate(Country.Name = replace(Country.Name, Country.Name == "USA", "United States")) %>%
#   mutate(Country.Name = replace(Country.Name, Country.Name %in% c("Democratic Republic of the Congo", "Republic of Congo"), "Congo (Brazzaville)")) %>%
#   mutate(Country.Name = replace(Country.Name, Country.Name == "UK", "United Kingdom"))%>%
#   mutate(Country.Name = replace(Country.Name, Country.Name == "Czech Republic", "Czechia"))%>%
#   mutate(Country.Name = replace(Country.Name, Country.Name %in% c('Trinidad', 'Tobago'), "Trinidad and Tobago"))%>%
#   mutate(Country.Name = replace(Country.Name, Country.Name == 'Swaziland', "Eswatini"))
# 
# df <- df %>%
#   mutate(Country.Name = replace(Country.Name, Country.Name == "Hong Kong S.A.R. of China", "China"))%>%
#   mutate(Country.Name = replace(Country.Name, Country.Name == "Taiwan Province of China", "Taiwan"))%>%
#   mutate(Country.Name = replace(Country.Name, Country.Name == "State of Palestine", "Palestine"))%>%
#   mutate(Country.Name = replace(Country.Name, Country.Name == "Turkiye", "Turkey"))%>%
#   mutate(Country.Name = replace(Country.Name, Country.Name == "Somaliland region", "Somalia"))
# 
# by.part <- c("Country.Name" = "Country.Name")
# world.map <- join.df(world.map, df, by.part)
# 
# world.map <- world.map[order(world.map$order),]
# 
# life.ladder.plot <- ggplot(world.map, aes(long, lat, group=group)) +
#   geom_polygon(aes(fill=Life.Ladder, text = Country.Name), color = "black",size = 0.2) +
#   coord_quickmap() +
#   theme_void() +
#   scale_fill_viridis(option='magma', name="Index") +
#   theme(legend.position='bottom') +
#   labs(title="Happiness Index across the World") +
#   ggeasy::easy_center_title()
# 
# ggplotly(life.ladder.plot, tooltip = c("text", "Life.Ladder"))
