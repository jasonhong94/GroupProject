#   ____________________________________________________________________________
#    Browser                                                    ####

#dataFrame <- read.csv("Properties_preprocessed.csv",sep = ",")
dataFrame <- read.csv("data/Properties_preprocessed.csv")


choices <- c('None', "Kuala Lumpur"= "dataFrame")
selection <- c( "Location" = "Location","PropertyType" = "PropertyType", "Size Type" = "SizeType" )

dataDisplay <- function(){
    tagList(
        div(class = "container",
            h1 ("House Pricing Data"), class = "title fit-h1"),
            sidebarLayout(
                sidebarPanel(
                    
                    selectInput('dataset', 'Choose a dataset:', choice = choices, selected= 'None' ),
                    
                 
                    sliderInput('obs', 'Number of Observations:', min=1, max=20,
                                value=5, step=5, round=0),
                    
                    h5("Visualisation House Pricing"),
                    selectInput('x', 'Select X-axis:', choice = selection, selected= 'Location' ),
                    
                    actionButton("act", "Click to update"),
                    actionButton("check", "Check Data"),
                    actionButton("predictbutton", "Predict data", class = "btn btn-primary"),
                    
                  
                       
                ),
                mainPanel(
                    uiOutput("input_file"),
                  
                )
            )           
        
    )
}

#   ____________________________________________________________________________
