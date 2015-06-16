#' Retrieve a data.frame with requested cbs tables
#' 
#' \code{get_table_list} by default a list of all tables and all columns will be retrieved.
#' You can restrict the query by supplying multiple filter statements or by specifying the
#' columns that should be returned.
#' 
#' \note{get_table_list will cache results, so subsequent calls will be much faster.}
#' 
#' @param ... filter statement to select rows, e.g. Language="nl"
#' @param select \code{character} columns to be returned, by default all columns
#' will be returned.
#' @importFrom whisker whisker.render
#' @importFrom jsonlite fromJSON
#' @export
get_table_list <- function(..., select=NULL){
  url <- whisker.render("{{BASEURL}}/{{CATALOG}}/Tables?$format=json"
                       , list( BASEURL = BASEURL
                             , CATALOG = CATALOG
                             )
                       )
  url <- paste0(url, get_query(..., select=select))
  
  tables <- resolve_resource(url, "Retrieving tables from")
  tables
}


## testing

# library(dplyr)
# tables <- get_table_list(Language="nl", select=c("ShortTitle","Summary"))
