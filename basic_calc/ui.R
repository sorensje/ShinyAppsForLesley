library(shiny)

# Define UI forL Lesley's calculator
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Calc-u-lator"),
  
  # use sideBar panels to define inputs
  # the goal was to give Les a quick way to calculate totals for fabric priced by a certain unit
  
  sidebarPanel(
    
    numericInput("price_p_yd", "Cost Per Yard:", 1.40),
    numericInput("n_yd", "Number of yards", 10),
    numericInput("n_garment", "Number of Garments", 10),
    
    
    helpText("Note: while the data view will show only the specified",
             "number of observations, the summary will still be based",
             "on the full dataset."),
    
    submitButton("Update View")
  ),
  
  mainPanel(
    h4("Cost of Garment"),
    verbatimTextOutput("garmcost"),
    
    h4("Total Cost"),
    verbatimTextOutput("tot_cost")
  )

))


