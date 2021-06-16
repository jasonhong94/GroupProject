#   ____________________________________________________________________________
#   Server                                                                  ####

library(shiny)
library(sp)
library(plotly)
library(dplyr)
library(tidyr)
library(magrittr)
library(shinyjs)
library(jsonlite)
library(urltools)
library(utils)
library(rvest)
library(stringr)
library(xml2)
library(selectr)
library(raster)
library(purrr)
library(RColorBrewer)
library(DT)
library(shinyBS)
library(randomForest)
library(caret)
library(modelr)
library(rpart)
library(tidyverse)
library(data.table)
library(ggplot2)


#use the below option code for increase the file input limit,
#options(shinny.maxRequestSize = 9*1024^2)

model <- readRDS("model.rds")

test <- read.csv("data/testing.csv")
### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### Pretty-print function                                                   ####


shinyServer(function(input, output) {
    
    
    output$fileob <- renderPrint({
        if(is.null(data())){
            return()
        }
        str(get(input$dataset))
    })
    
    
    output$summ <- renderPrint({
        if(is.null(input$dataset)){
            return()
        }
        summary(get(input$dataset),
                           sep=input$sep,
                           header= input$header,
                           stringsAsFactors = input$stringAsFactors)
        #)
    })
    
    output$table <- renderTable({
        if(is.null(input$dataset)){
            return()
        }else{
            input$act
            housePrice <- get(input$dataset)
            isolate(head(housePrice, n = input$obs))
        }
    })
    
    
    output$mvalue <- renderPrint({
        if(input$act == 0){
            return()
        }else{
            
            if(input$check == 0){
                return()
            }else
            colSums(is.na(get(input$dataset)))  
        }
    })

    
    output$hist <- renderPlot({
        
            housePrice = get(input$dataset)
            if(input$x == "Location"){
                colName <- housePrice$Location
            }else if (input$x == "PropertyType"){
                colName <- housePrice$Property.Type
            }
            else{
                colName <- housePrice$Size.Type
            }
            
            ggplot(housePrice,aes(x= colName, y= Price, fill = colName))+
                geom_bar(stat = "identity")+
                theme_classic()+
                labs(
                    x = input$x,
                    y = "Price",
                    title = paste(
                        "House pricing on Each Area"
                    )
                )
        
    })
    
    output$downloadData <- downloadHandler({
        filename = function(){
          paste("input$dataset", "csv", sep = ".")  
        }
        
        housePrice = get(input$dataset)
        write.csv(input$dataset,"file")
        
    })
    
    # Prediction results table
    output$tabledata <- renderTable({
        if (input$predictbutton == 0) { 
            return() 
        }else{
            
            Output <- data.frame(predict_Price = predict(model,test), Location = test$Location, Size = test$Size, Room_Number = test$Rooms.Num, Property_type = test$Property.Type)
            head(Output, n = input$obs)
            
        }
    })
    
    output$input_file <- renderUI({
        if(input$act == 0){
            return()
        }else 
            tabsetPanel(
                tabPanel("Data", tableOutput("table"), 
                         h5("Missing value in this dataset:"),
                         verbatimTextOutput("mvalue"), 
                         downloadButton('downloadData', "Download Data")), 
                tabPanel("Structure", verbatimTextOutput("fileob")), 
                tabPanel("Summary", verbatimTextOutput("summ")),
                tabPanel("Visualisation", plotOutput("hist")),
                tabPanel("Predict Data", 
                         h4("Random Forest for Prices Prediction:"),
                         tableOutput("tabledata")))
               
    })
    
})
                                                   

