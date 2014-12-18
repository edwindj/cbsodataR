#' gets a cbs metadata
#' @param id internal id of CBS table
#' @importFrom whisker whisker.render
#' @importFrom jsonlite fromJSON
#' @export
get_meta <- function(id){
  url <- whisker.render("{{BASEURL}}/{{API}}/{{id}}"
                       , list( BASEURL = BASEURL
                             , API = API
                             , id = id
                             )
                       )
  message("Retrieving meta data for table '",id, "'")
  meta_top <- resolve_resource(url)
  meta <- lapply(meta_top$url, resolve_resource)
  names(meta) <- meta_top$name
  meta
}

#' @importFrom jsonlite fromJSON
resolve_resource <- function(url){
  cat(".")
  jsonlite::fromJSON(url)$value
}


### testing
#meta <- get_meta("81819NED")