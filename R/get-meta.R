#' gets metadata of a cbs table
#' @param id internal id of CBS table
#' @param cache should the result be cached?
#' @importFrom whisker whisker.render
#' @importFrom jsonlite fromJSON
#' @export
get_meta <- function(id, cache=FALSE){
  url <- whisker.render("{{BASEURL}}/{{API}}/{{id}}"
                       , list( BASEURL = BASEURL
                             , API = API
                             , id = id
                             )
                       )
  meta_top <- resolve_resource( url
                              , "Retrieving meta data for table '", id, "'"
                              , cache = cache
                              )
  
  #exclude data sets
  meta_idx = !(meta_top$name %in% c("TypedDataSet", "UntypedDataSet"))
  meta_top <- meta_top[meta_idx,]
  
  meta <- lapply(meta_top$url, resolve_resource, "Retrieving ", url, cache=cache)
  names(meta) <- meta_top$name
  meta
}

### testing
#meta <- get_meta("81819NED")
