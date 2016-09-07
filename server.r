milage <- function(wt,gear,am,cyl,carb) {
    3.743157 - 0.049497*cyl - 0.158712*wt + 0.003427*am + 0.035639*gear - 0.036116*carb 
}

library(shiny)
library(HistData)
data(Galton)
shinyServer(

    function(input, output){
#    x<- reactive({as.numeric(input$id2)+10})
    output$owt <- renderPrint({input$wt})
    output$ogear <- renderPrint({as.numeric(input$gear)})
    output$oam <- renderPrint({as.numeric(input$am)})
    output$ocyl <- renderPrint({as.numeric(input$cyl)})
    output$ocarb <- renderPrint({input$carb})
    
    output$omil <- renderPrint({milage(input$wt, as.numeric(input$gear), as.numeric(input$am), as.numeric(input$cyl), input$carb)})
    
#    output$oid3 <- renderText({x() })
#    output$oid4 <- renderText({ 
#      input$gobutton
#      isolate(paste(input$gobutton))
#      })

#      output$odate <- renderPrint({input$date})

     
    
    
#    output$newHist <- renderPlot({
#    hist(Galton$child, xlab='Height', col='lightblue', main='Histogram')
#    mu <- input$mu
#    lines(c(mu,mu), c(0,200), col="red", lwd=5)
#    mse <- mean((Galton$child-mu)^2)
#    text(65,150, paste("mu=",mu))

#    text(65,160, paste("mse=",mse))
#    }
      
#    )
  }
)