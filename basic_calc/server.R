library(shiny)

# Server for Lesley's calculator
shinyServer(function(input, output) {
  
  # Generate a summary of the dataset
  output$garmcost <- renderPrint({
    cat(input$price_p_yd * input$n_yd)
  })
  
  output$tot_cost <- renderPrint({
    cat(input$price_p_yd * input$n_yd *input$n_garment)
  })

  
})
