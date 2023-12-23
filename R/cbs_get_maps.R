CARTOMAP_TOC <- "https://cartomap.github.io/nl/index.csv"

#' Get list of cbs maps
#' 
#' Returns a list of (simplified) maps, that can be used with CBS data.
#' @param verbose if `TRUE` a message with the download url will be printed.
#' @param cache if `TRUE` the result will be cached.
#' @return `data.frame` with region, year and links to geojson
#' @export
#' @example example/cbs_get_maps.R
#' @family cartographic map
cbs_get_maps <- function(verbose = FALSE, cache = TRUE){
  
  if (isTRUE(cache)){
    res <- cache_get(CARTOMAP_TOC)
    if (!is.null(res)){
      if (isTRUE(verbose)){
        message("Retrieving list of geojson files from cache.")
      }
      return(res)
    }
  }
  
  if (isTRUE(verbose)){
    message("Retrieving list of geojson files: '", CARTOMAP_TOC, "'")
  }
  
  maps <- utils::read.csv(url(CARTOMAP_TOC))
  cache_add(CARTOMAP_TOC, maps)
  maps
}

