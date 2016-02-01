#require(shiny)
#require(UsingR)
require(gridExtra)
require(ggplot2)

data(mtcars)
model <- lm(mpg ~ am + wt + qsec, mtcars)
mpgpredict <- function(am, wt, qsec){
    
    topredict <- data.frame(
        am=c(am), 
        wt=c(wt), 
        qsec=c(qsec))
    
    #return value
    as.numeric(predict(model, topredict))
}



shinyServer(
    function(input, output) {

        output$mpg_prediction <- renderPrint({mpgpredict(am=as.numeric(input$am), wt=input$wt, qsec=input$qsec)})
        
        
        output$theplot <- renderPlot({

            # add predicted car to the dataset to be plot
            toplotdataset <- mtcars[,c(1, 6, 7, 9)]
            toplotdataset$data <- as.factor("observed")
            newcar <- data.frame(
                mpg=c(mpgpredict(am=as.numeric(input$am), wt=input$wt, qsec=input$qsec)),
                am=c(input$am), 
                wt=c(input$wt), 
                qsec=c(input$qsec),
                data= as.factor("prediction")) 
            toplotdataset <- rbind(toplotdataset, newcar)
            
            g1 <- ggplot(toplotdataset, aes(x=wt, y=mpg, color=data, shape=data)) 
            g1 <- g1 + geom_point() 
            g1 <- g1 + theme(legend.position="none")
            g1 <- g1 + ylab("MPG (Milles/US Gallons)")
            g1 <- g1 + xlab("Car Weight (lb/1000)")
            g1 <- g1 + ggtitle("Car Weight x MPG")
            

            g2 <- ggplot(toplotdataset, aes(x=qsec, y=mpg, color=data, shape=data)) + geom_point() 
            g2 <- g2 + theme(legend.position="none")
            g2 <- g2 + ylab("MPG (Milles/US Gallons)")
            g2 <- g2 + xlab("1/4 mile time (seconds)")
            g2 <- g2 + ggtitle("1/4 mile time x MPG")
            
            
            g3 <- ggplot(toplotdataset, aes(x=am, y=mpg, color=data, shape=data))
            g3 <- g3 + geom_point() 
            g3 <- g3 + ylab("MPG (Milles/US Gallons)")
            g3 <- g3 + xlab("Transmission Type (Automatic = 0, Manual = 1)")
            g3 <- g3 + ggtitle("Transmission Type x MPG")
            
            
            grid.arrange(g1, g2, g3, nrow=1)
            #grid.rect(.5,.5,width=unit(.99,"npc"), height=unit(0.99,"npc"), 
            #          gp=gpar(lwd=3, fill=NA, col="black"))
        })
        
    }
)