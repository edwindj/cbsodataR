#' gets list of all cbs themes
#' 
#' Returns a list of all cbs themes. 
#' @param ... Use this to add a filter to the query e.g. \code{get_themes(ID=10)}
#' @importFrom whisker whisker.render
#' @export
get_themes <- function(...){
  url <- whisker.render("{{BASEURL}}/{{CATALOG}}/Themes?$format=json"
                       , list( BASEURL = BASEURL
                             , CATALOG = CATALOG
                             , filter = filter
                             )
                       )

  filter <- get_filter(...)
  if (nchar(filter)){
    url <- paste0(url, "&$filter=", filter)
  }
  
  themes <- resolve_resource(url, "Retrieving themes from ")
  themes
}



## testing

# library(dplyr)
#themes <- get_themes()
