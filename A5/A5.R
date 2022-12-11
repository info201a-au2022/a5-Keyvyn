# Single File Web Application

# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
source("app_server.R")
library(shinythemes)
library(plotly)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("cyborg"),
  navbarPage("A5",
    tabPanel("Introduction",
    titlePanel(strong("Analyzing C02 Global Emissions Data",
                      h3("Keyvyn Rogers"))),
        mainPanel("The purpose of this shiny web application is to display
                  interactive visualizations that represent global co2
                  emissions dating all the way back to 1850.",
                  p("Due to the high volume of data points, I would like to narrow
                    down these visualizations to the top five global leaders in co2 production 
                    since 1970. From there, we will answer
                    enviromentally impactful questions that include more data from more countries
                    and years.",
                   p("Firstly, I wanted to explore some averages since the 1970s. As we can see
                     the United States",
                     strong("(5246 million tons)"),"and China", strong("(4676 million tonnes)"), "lead the pack for
                     their avergaes. Interestingly enough, China has had the highest year ever of co2 emissions at",
                     strong("(11,472 million tonnes)"),".This is more than double of any country ever. Obviously, although it is 
                     not a country, Antartica is at the end of the pack with barely any CO2 emissions." 
                     ))
        ),
        ),
    tabPanel("CO2 Production since the 1970s",
             titlePanel("Scatter Plot Revealing Data about CO2 emissions since the 1970s"),
                        sidebarLayout(
                          sidebarPanel(
                            sliderInput("slider1", label = "slide to prefered year",
                                        min = 1970, max=2021, value = 2000
                                        ),
                          ),
                          mainPanel(plotlyOutput("co2"),
                          "This is a great way to compare countries by year in terms of their co2 
                          emissions. Its also interesting to compare populations as well!"          
                                    ),
                        ),
             ),
    tabPanel("CO2 Production since the 1970s",
             titlePanel("Line graph Revealing Data about CO2 Emissions By Country Of Choice"),
             sidebarLayout(
               sidebarPanel(
                 textInput("usertext", label = h3("Input which country you are curious about!"),
                           value = "United States"), 
               ),
               mainPanel(plotlyOutput("years"),
                         "Depending what country you type in, you can see how their
                         CO2 emissions have changes since the 70s. Make sure you are spelling
                         correctly!"
                         
               ),
               ),
             ),
    
    )
)




# Define server logic required to draw a histogram
server <- function(input, output) {

    output$co2 <- renderPlotly({
      first_graph <- highest_producers %>% 
        filter(year == input$slider1) %>% 
        ggplot() + 
        geom_point(mapping = aes(x = population , y = co2 , color = country)) + 
        labs(title = "CO2 emissions by country and year") +
        labs(y = "co2 (million tonnes)" , x= "population") 
    })
    
    output$years <- renderPlotly({
      first_graph <- highest_producers %>% 
        filter(country == input$usertext) %>% 
        ggplot() + 
        geom_line(mapping = aes(x = year , y = co2 , color = country)) + 
        labs(title = "CO2 emissions by country and year") +
        labs(y = "co2 (million tonnes)" , x= "year") 
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
