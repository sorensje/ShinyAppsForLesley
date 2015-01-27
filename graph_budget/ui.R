library(shiny)
require(ggplot2)
require(RColorBrewer)
# Define UI graph_budget
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Budget-o-matic"),
  
  # sideBar is where costs are defined
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
  ),
  
  mainPanel(
    h4("Cost of Project"),
    verbatimTextOutput("garmcost"),
    
    div(plotOutput("budgplot"))
    )
  )
)


