# creates a string that can be used in a $filter query
column_filter <- function(column, values, allowed = NULL){
  if (is.character(values)){
    query <- eq(values, column)
  } else if (is_query(values)){
      query <- values
      query$column <- column
  } else {
    stop("Unsupported query: '", values, ".'")
  }
  check_query(query, allowed = allowed)
}

# creates a filter string that can be used in $filter query
# usage: get_filter(Periode=c(2001))
get_filter <- function(..., filter_list=list(...), select = NULL, .meta = NULL){
  if (length(filter_list) == 0){
    return(NULL)
  }
  
  query <- sapply(names(filter_list), function(column){
    filter <- column_filter( column
                           , filter_list[[column]]
                           # check if values are allowed
                           , allowed = .meta[[column]][["Key"]]
                           )
    paste0("(", as.character(filter, column = column), ")")
  })
  
  paste0(query, collapse=" and ")
}

get_select <- function(select){
  query = NULL
  if (length(select) > 0){
    query = paste0(select, collapse = ",")
  }
  query
}

get_query <- function(..., select=NULL){
  query <- ""
  filter <- get_filter(...)
  if (!is.null(filter)){
    query = paste0(query, "&$filter=", filter)
  }
  
  select <- get_select(select)
  if (!is.null(select)){
    query = paste0(query, "&$select=", select)
  }
  query
}


#column_filter("Periode", c(2000, 2001))
#get_filter(Periode=2001:2003, id="2")
#get_query(list(Periode=2001:2003))

