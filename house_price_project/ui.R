#   ____________________________________________________________________________
#   UI                                                                      ####

library(shiny)
library(plotly)
library(shinyjs)
library(shinyBS)

source("appParts.R")

### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..



shinyUI(navbarPage(title = "Shniny App Project",
                   theme = "style/style.css",
                   footer = includeHTML("footer.html"),
                   fluid = TRUE, 
                   collapsible = TRUE,
                   
                   # ----------------------------------
                   # tab panel 1 - Home
                   tabPanel("Home",
                            includeHTML("home.html"),
                            tags$script(src = "plugins/scripts.js"),
                            tags$head(
                              tags$link(rel = "stylesheet", 
                                        type = "text/css", 
                                        href = "plugins/font-awesome-4.7.0/css/font-awesome.min.css"),
                              tags$link(rel = "icon", 
                                        type = "image/png", 
                                        href = "images/logo_icon.png")
                            )
                   ),
                   
                   # ----------------------------------
                   # tab panel 2 - Browser
                   tabPanel("Data Analysis",
                            
                            dataDisplay(),
                           
                            includeHTML("scrollToTop.html"),
                            shinyjs::useShinyjs(),
                            tags$head(
                              tags$link(rel = "stylesheet", 
                                        type = "text/css", 
                                        href = "plugins/carousel.css"),
                              tags$script(src = "plugins/holder.js")
                            ),
                            tags$style(type="text/css",
                                       ".shiny-output-error { visibility: hidden; }",
                                       ".shiny-output-error:before { visibility: hidden; }"
                            )
                   )
                   
))