#' Get list of all cbs thematic entries.
#' 
#' Returns a list of all cbs themes. 
#' @param ... Use this to add a filter to the query e.g. `get_themes(ID=10)`.  
#' @param verbose Print extra messages what is happening.
#' @param cache Should the result be cached?
#' @param select `character` vector with names of wanted properties. default is all
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocol.
#' @return A `data.frame` with various properties of SN/CBS themes.
#' 
#' The filter is specified with `<column_name> = <values>` in which `<values>` is a character vector.
#' Rows with values that are not part of the character vector are not returned.
#' @export
#' @examples 
#' \dontrun{
#' # get list of all themes
#' cbs+get_themes()
#' 
#' # get list of all dutch themes from the Catalog "CBS"
#' cbs_get_themes(Language="nl", Catalog="CBS")
#' }
#' @importFrom whisker whisker.render
cbs_get_themes <- function(..., select=NULL, verbose = TRUE, cache = FALSE
                          , base_url = getOption("cbsodataR.base_url", BASE_URL)){
  url <- whisker.render("{{BASEURL}}/{{CATALOG}}/Themes?$format=json"
                       , list( BASEURL = base_url
                             , CATALOG = CATALOG
                             )
                       )
  url <- paste0(url, get_query(..., select=select))  
  themes <- resolve_resource(url, "Retrieving themes from ", verbose = verbose, cache = cache)
  themes
}

#' Get a the list of tables connected to themes
#' @export
#' @param ... Use this to add a filter to the query e.g. `get_tables_themes(ID=10)`.  
#' @param select `character` vector with names of wanted properties. default is all
#' @param verbose Print extra messages what is happening.
#' @param cache Should the result be cached?
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocal.
#' @return A `data.frame` with various properties of SN/CBS themes.
cbs_get_tables_themes <- function(..., select=NULL, verbose = FALSE, cache = TRUE
                                 , base_url = getOption("cbsodataR.base_url", BASE_URL)){
  url <- whisker.render("{{BASEURL}}/{{CATALOG}}/Tables_Themes?$format=json"
                        , list( BASEURL = base_url
                                , CATALOG = CATALOG
                        )
  )
  url <- paste0(url, get_query(..., select=select))  
  table_themes <- resolve_resource(url, "Retrieving themes from ", cache = cache, verbose = verbose)
  table_themes
}


## testing

# library(dplyr)
#themes <- get_themes()
