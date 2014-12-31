# creates a string that can be used in a $filter query
column_filter <- function(key, values){
  if (is.character(values)){
    values <- paste0("'", values, "'")
  }
  query <- paste0(key, " eq ", values)
  query <- paste0(query, collapse=" or ")
  query
}

# creates a filter string that can be used in $filter query
# usage: get_filter(Periode=c(2001))
get_filter <- function(filter_list, ...){
  if (missing(filter_list)){
    filter_list = list()
  }
  filter_list <- c(filter_list, list(...))
  query <- sapply(names(filter_list), function(key){
    filter <- column_filter(key, filter_list[[key]])
    paste0("(", filter, ")")
  })
  
  paste0(query, collapse=" and ")
}


#column_filter("Periode", c(2000, 2001))
#get_filter(list(Periode=2001:2003), id="2")
