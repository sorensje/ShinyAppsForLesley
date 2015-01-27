library(shiny)


# Define server logic for graph budget
shinyServer(function(input, output) {

  graph_budg <- reactive({as.numeric(input$budget)}) 
  
  costs <- reactive({c(as.numeric(input$cost_1),as.numeric(input$cost_2),
            as.numeric(input$cost_3),as.numeric(input$cost_4))})
  
  cost_labels<- reactive({c(as.character(input$cost_lab_1),as.character(input$cost_lab_2),
                            as.character(input$cost_lab_3),as.character(input$cost_lab_4))})
  
  output$garmcost <- renderPrint({
        cat(sum(costs()))
        
      })

  
  graph_budget <- function(budget,costs,cost_labels){
    
    total_cost <- sum(costs)
    n_costs <- length(costs)
    leftover <- budget - total_cost
    
    ## graph params
    colors <- c(brewer.pal(n_costs,'Set3'),'#FFFFFF')
    graph_max <- max(total_cost,budget)
    bw= theme_bw()+ theme(axis.ticks = element_blank(), axis.text.x = element_blank())
    theme_set(bw)
    onbudget <- leftover>0
    
    # create df for budget
    dat <- data.frame(costs=c(costs,leftover),cost_labels=factor(c(cost_labels,'Unallocated'),levels=c(cost_labels,'Unallocated')))
    dat$scale_cost <- dat$costs/budget
    dat$budget = budget 
    dat$graph_max = graph_max
    
    ## check budget on track
    if(onbudget==TRUE){
      graph_color = 'chartreuse4'
      graph_mesg = paste("Under Budget by: $",budget-total_cost,sep="")
      mesg_ycord = budget+1
    } else{
      graph_color = 'red'
      graph_mesg = paste("Over Budget by: $",total_cost-budget,sep="")
      mesg_ycord = total_cost+1
    }
    
    
    # print budget w/ ggplot
    print(
      ggplot(dat, aes(x = factor(1), y = costs, fill = cost_labels)) +
      geom_bar(width = .6, colour = "black",stat='identity',alpha=.6) + 
      geom_abline(intercept = budget, colour = "black",linetype=2, size = 1) +
      scale_fill_manual(values=colors,name='Budget Category')+
      scale_y_continuous(limits = c(0,graph_max+.1*graph_max),name="Cumulative Project Cost")+
      scale_x_discrete(name="Budget")+
      theme(axis.title.x = element_text(colour="black", size=16)) +
      theme(axis.title.y = element_text(colour="black", size=16)) +
      annotate(geom="text", .7, y=budget+1, label = paste("Total Budget: $",budget,sep=""), vjust = -1.25)+
      annotate(geom="text", 1.3, y=budget+1, label =graph_mesg , vjust = -1.25,colour=graph_color)+
      ggtitle(label='Total Project costs') +
      geom_text(position="stack", aes(x=factor(1), y=costs, ymax=graph_max,
                                      label=cost_labels, hjust=0.5, vjust=costs/graph_max*15)) +
      theme(plot.title=element_text(face="bold", colour="black", size=22))
    )
  }
 
  output$budgplot <- renderPlot({ graph_budget(graph_budg(),costs(),cost_labels())})

})
