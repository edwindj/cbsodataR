#' gets list of all cbs themes
#' 
#' Returns a list of all cbs themes. 
#' @param ... Use this to add a filter to the query e.g. \code{get_themes(ID=10)}
#' @param select \code{character} vector with names of wanted properties. default is all
#' @importFrom whisker whisker.render
#' @export
get_themes <- function(..., select=NULL){
  url <- whisker.render("{{BASEURL}}/{{CATALOG}}/Themes?$format=json"
                       , list( BASEURL = BASEURL
                             , CATALOG = CATALOG
                             )
                       )
  url <- paste0(url, get_query(..., select=select))  
  themes <- resolve_resource(url, "Retrieving themes from ")
  themes
}



## testing

# library(dplyr)
#themes <- get_themes()
