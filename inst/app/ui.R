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
        , uiOutput("buildquery")
        , actionButton("getData", "Get Data")
      )
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel( "query"
                #, textOutput("rquery")
                , verbatimTextOutput("rquery")
                ),
        tabPanel("data"
                , dataTableOutput('data')
                )
        # ,tabPanel( "table list",       
        #                  dataTableOutput("table_list")
        #         )
      )      
    )
  )
))