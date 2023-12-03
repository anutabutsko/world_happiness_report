library(shiny)
library(ggplot2)
library(dplyr)
library(maps)
library(plotly)
library(viridis)
library(ggridges)
library(data.table)
library(ggeasy)

df <- read.csv("DataAnalysis/Datasets/Demonstration_by_country.csv")

ui <- fluidPage(
  titlePanel("Demonstrations Across the World"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("yearInput", 
                  "Select Year:", 
                  min = min(df$Year), 
                  max = max(df$Year), 
                  value = max(df$Year), 
                  step = 1)
    ),
    mainPanel(
      plotlyOutput("mapPlot")
    )
  )
)


server <- function(input, output) {
  
  output$mapPlot <- renderPlotly({
    filtered_df <- df %>%
      filter(Year == input$yearInput) %>%
      group_by(Country) %>%
      summarize(Events = sum(Events, na.rm = TRUE))
    
    world.map <- map_data("world")
    world.map <- world.map%>%
      rename(Country = region)
    unique_world_map <- unique(world.map$Country)
    
    unique_df <- unique(df$Country)
    
    # Names in df that do not match names in world.map
    names_not_in_world_map <- setdiff(unique_df, unique_world_map)
    names_not_in_world_map2 <- setdiff(unique_world_map, unique_df)
    
    # Change the names to match df
    world.map <- world.map %>%
      mutate(Country = replace(Country, Country == "USA", "United States")) %>%
      mutate(Country = replace(Country, Country %in% c("Democratic Republic of the Congo", "Republic of Congo"), "Congo (Brazzaville)")) %>%
      mutate(Country = replace(Country, Country == "UK", "United Kingdom"))%>%
      mutate(Country = replace(Country, Country == "Czech Republic", "Czechia"))%>%
      mutate(Country = replace(Country, Country %in% c('Trinidad', 'Tobago'), "Trinidad and Tobago"))%>%
      mutate(Country = replace(Country, Country == 'Swaziland', "Eswatini"))
    
    df <- df %>%
      mutate(Country = replace(Country, Country == "Hong Kong S.A.R. of China", "China"))%>%
      mutate(Country = replace(Country, Country == "Taiwan Province of China", "Taiwan"))%>%
      mutate(Country = replace(Country, Country == "State of Palestine", "Palestine"))%>%
      mutate(Country = replace(Country, Country == "Turkiye", "Turkey"))%>%
      mutate(Country = replace(Country, Country == "Somaliland region", "Somalia"))
    
    # Join with filtered data
    by.part <- c("Country" = "Country")
    world.map <- left_join(world.map, filtered_df, by.part)
    world.map <- world.map[order(world.map$order),]
    
    # Create the plot
    demonstrations.plot <- ggplot(world.map, aes(long, lat, group = group)) +
      geom_polygon(aes(fill = Events, text = Country), color = 'black', size = 0.2) +
      coord_quickmap() +
      theme_void() +
      scale_fill_viridis(name = "Index") +
      theme(legend.position = 'bottom') +
      labs(title = "Demonstrations Across the World") +
      ggeasy::easy_center_title()
    
    ggplotly(demonstrations.plot, tooltip = c("text", "demonstrations.plot"))
  })
}

shinyApp(ui = ui, server = server)
