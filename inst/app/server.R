library(shiny)
library(cbsodataR)
library(dplyr)

shinyServer(function(input, output, session){
  
  tables <- get_table_list( Language="nl"
                          , select=c("Title", "Summary", "Identifier")
                          ) %>% 
    arrange(gsub("\\W", "", Title))
  
  table_info <- reactiveValues()
  test <- quote(table_info$q)
  table_info$q <- 1
  
  query <- reactiveValues()
  
  observe({
    if (is.null(table_info$meta)){
      return()
    }
    dims <- names(get_dims(table_info$meta))
    for (n in dims){
      input_n <- paste0("q_", n)
      query[[n]] <- input[[input_n]]
    }
  })
  
  observeEvent(input$table, {
    table_info$id <- input$table
    if (!(input$table %in%c("Loading...",""))){
      table_info$meta <- get_meta(input$table)
      
      nms <- isolate(names(query))
      for (n in nms) {
        query[[n]] <- NULL
      }
    }
  })
  
  if (!interactive()){
    session$onSessionEnded(q)
  }
  

  choices = tables$Identifier
  names(choices) = tables$Title
  options = data.frame(label=tables$Title, value=tables$Identifier)
  updateSelectizeInput( session, "table", choices=options, server = T,
                        options=list(placeholder="Select table"))
  
  output$id <- renderText(table_info$id)
  output$table_list <- renderDataTable(tables)
  
  output$buildquery <- renderUI(renderBuildQuery(table_info$meta))
  
  query_text <- reactive(
    get_query(reactiveValuesToList(query), table_info$id, table_info$meta)
  )
  
  output$rquery <- renderText({
    query_text()
  })
  
  cbs_data <- reactive({
    qry <- query_text()
    if (input$getData){
      try({
        .data <- eval(parse(text=qry))
        return(.data)
      }, silent = FALSE)
    } 
  })
  
  output$data <- renderDataTable(cbs_data())

})


get_select <- function(meta){
  #TODO improve
  dataprops <- meta$DataProperties
  data_cols <- dataprops %>% filter(Type %in% c("Topic", "Dimension", "GeoDimension"
                                  , "TimeDimension")
                      )
  data_cols$Key
}

get_dims <- function(meta){
  n <- names(meta) %in% c("DataProperties", "TableInfos")
  dims <- meta[!n]
  dims$select <- meta$DataProperties %>% filter(Type == "Topic")
  dims
}

get_dim_ids <- function(meta){
  paste0("q_", names(get_dims(meta)))
}

renderBuildQuery <- function(meta){
  if (is.null(meta)){
    return(div("No table selected..."))
  }
  dims <- get_dims(meta)
  nms <- names(dims)
  
  sels <- lapply(nms, function(n){
    renderSelect(n, n, dims[[n]])
  })
  div(sels)
}

renderSelect <- function(id, label, categories){
  choices <- setNames(categories$Key, categories$Title)
  inputid <- paste0("q_", id)
  selectizeInput( inputid
                , label
                , choices = choices
                , options = list(Placeholder="Select categories...")
                , multiple=TRUE
                )
}

library(whisker)
format_char <- function(x){
  fc <- x %>% as.character %>% paste0("'",.,"'", collapse =",")
  if (length(x) > 1){
    fc <-   paste0("c(", fc, ")")
  } else if (length(x) == 0){
    return("")
  }
  fc
}

get_query <- function(q, id, meta){
  dims <- names(q)
  dims <- dims[dims != "select"]
  select <- c(dims, q$select)
  q$select <- NULL
  q$select <- select
  #print(ls.str())
  q <- sapply(q, format_char, simplify = FALSE)
  q <- q[sapply(q, nchar) > 0]
  if (length(q)){
    whisker::whisker.render("get_data('{{id}}',\n{{query}})", list(
      id    = id,
      query = paste0('\t', names(q),"=",q, collapse = ",\n")
  ))
  } else{
    whisker::whisker.render("get_data('{{id}}')", list(id=id))
  }
}


#format_char(c("a", "b"))
