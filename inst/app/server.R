library(shiny)
library(cbsodata)

shinyServer(function(input, output, session) {
  tables <- get_tables()
  tables$ShortDescription <- NULL
  updateSelectInput(session, "table", choices=tables$Title)
  
  output$table_list <- renderDataTable(tables)
})