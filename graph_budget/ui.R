library(shiny)
require(ggplot2)
require(RColorBrewer)
# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Budget-o-matic"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    
    numericInput("budget", "Total Budget:", 2000),
    wellPanel(
      numericInput("cost_1", "Cost of Catgoery 1:", 400),
      textInput("cost_lab_1","Category Name:", 'Coats')
    ),
    wellPanel(
      numericInput("cost_2", "Cost of Catgoery 2:", 600),
      textInput("cost_lab_2","Category Name:", 'Hats')
    ),
    wellPanel(
      numericInput("cost_3", "Cost of Catgoery 3:", 300),
      textInput("cost_lab_3","Category Name:", 'Weasels')
    ),
    wellPanel(
      numericInput("cost_4", "Cost of Catgoery 4:", 400),
      textInput("cost_lab_4","Category Name:", 'Chickens')
    ),

    submitButton("Update View")
#     actionButton("submit", "Use Selected Cutoff")
  ),
  
  mainPanel(
    h4("Cost of Project"),
    verbatimTextOutput("garmcost"),
    
#     h4("Total Cost"),
#     verbatimTextOutput("tot_cost"),
    
    div(plotOutput("budgplot"))
    
  )


))


