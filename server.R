#ChickWeight Shiny Server
library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output) {
  
output$plot1 <- renderPlot({
# Set up plot data depending on which diets are selected
# Initialize empty data frame
  plotdata <- ChickWeight[0,]
#add to this dataframe as specific diets are selected
  if(input$showDiet1){
    plotdata1 <- filter(ChickWeight,Diet==1)
    plotdata <- rbind(plotdata1,plotdata)
  }
  if(input$showDiet2){
    plotdata2 <- filter(ChickWeight,Diet==2)
    plotdata <- rbind(plotdata2,plotdata)
  }
  if(input$showDiet3){
    plotdata3 <- filter(ChickWeight,Diet==3)
    plotdata <- rbind(plotdata3, plotdata)
  }
  if(input$showDiet4){
    plotdata4 <- filter(ChickWeight,Diet==4)
    plotdata <- rbind(plotdata4,plotdata)
  }
  
#Transfer temporary dataframe to final
 fnl_plotdata <- plotdata

# Set up plotting option parameters
#Extract day range from sliderDay input
  dayRange <- input$sliderDay
#Determine min/max weight values scale y axis limits for plotting various ranges
  minmax  <- filter(fnl_plotdata, Time >= dayRange[1] & Time <= dayRange[2])
#Set up jitter width variable  
  offset <- ifelse(input$jitter,.25,0)
#Plot data  
  p <- ggplot(fnl_plotdata, aes(x=Time,y=weight,color = Diet)) + geom_jitter(width = offset)+
    geom_point() +  
    labs(title="Effect of Diet on Chick Weights") +
    labs(x="Time (Days)", y = "Weight (Grams)",legend = "Diet") +
    coord_cartesian(xlim = c(dayRange), ylim = c(min(minmax$weight),max(minmax$weight)))
  
# Add regression lines if checkbox is selected
  if(input$loes){
    p <- p + geom_smooth(method = loess,se = FALSE)
  }
  p
  })
# Set up click and hover tools
output$info <- renderText({
  xy_str <- function(e) {
    if(is.null(e)) return("NULL\n")
    paste0("Day =", round(e$x, 0), " Weight(Grams) =", round(e$y, 0), "\n")
  }
  xy_range_str <- function(e) {
    if(is.null(e)) return("NULL\n")
    paste0("xmin=", round(e$xmin, 1), " xmax=", round(e$xmax, 1), 
           " ymin=", round(e$ymin, 1), " ymax=", round(e$ymax, 1))
  }
  
  paste0(
    "click: ", xy_str(input$plot_click),
    "hover: ", xy_str(input$plot_hover)
  )
  
})
})


  



