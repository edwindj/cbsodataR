library(shiny)

shinyUI(fluidPage(
  
  titlePanel("CBS OData"),
  
  sidebarLayout(
    sidebarPanel(
      selectizeInput("table"
                    , "Table:"
                    , c("Loading...")
                    , selected = NULL
                    , options = list()
                    ),
      shiny::wellPanel(
        div(
          "table id: ", shiny::textOutput("id")
        )
      )
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel( "query"
                , uiOutput("buildquery")
                #, textOutput("rquery")
                , verbatimTextOutput("rquery")
                ),
        tabPanel( "table list",       
                         dataTableOutput("table_list")
                )
      )      
    )
  )
))