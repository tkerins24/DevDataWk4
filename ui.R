# ChickWeight Shiny UI
library(shiny)
#library(webshot)
shinyUI(fluidPage(
  titlePanel("Chick Weights by Diet"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderDay", "Select Day Range:",
                  min = 0, max = 22,
                  value = c(0,22),step =1),
      h4("Select Diet(s)"),
      checkboxInput("showDiet1", "Diet1", value = TRUE),
      checkboxInput("showDiet2", "Diet2", value = TRUE),
      checkboxInput("showDiet3", "Diet3", value = TRUE),
      checkboxInput("showDiet4", "Diet4", value = TRUE),
      h4("Options"),
      checkboxInput("jitter", "Add Jitter", value = TRUE),
      checkboxInput("loes", "Show Regression Lines", value = TRUE)
    ),
   
    mainPanel(
      plotOutput("plot1",
                 click = "plot_click",
                 hover = "plot_hover"),
     
    h4("Use click and/or hover on the plot to examine data points"),
#Output click and hover parameters
    verbatimTextOutput("info")
     ))
      
    )
  )
