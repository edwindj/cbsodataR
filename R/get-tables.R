#' gets list of all cbs tables
#' @param id Identifier of CBS table
#' @importFrom whisker whisker.render
#' @importFrom jsonlite fromJSON
#' @export
get_tables <- function(...){
  url <- whisker.render("{{BASEURL}}/{{CATALOG}}/Tables?$format=json"
                       , list( BASEURL = BASEURL
                             , CATALOG = CATALOG
                             )
                       )
  
  filter <- get_filter(...)
  if (nchar(filter)){
    url <- paste0(url, "&$filter=", filter)
  }
  
  tables <- resolve_resource(url, "Retrieving tables from")
  tables
}


## testing

# library(dplyr)
# tables <- get_tables()
