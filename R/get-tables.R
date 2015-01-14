#' gets list of all cbs tables
#' @param ... filter statement to select rows, e.g. Language="nl"
#' @param select \code{character} columns to be returned, by default all columns
#' will be returned.
#' @importFrom whisker whisker.render
#' @importFrom jsonlite fromJSON
#' @export
get_tables <- function(..., select=NULL){
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
# tables <- get_tables(Language="nl", select=c("ShortTitle","Summary"))
