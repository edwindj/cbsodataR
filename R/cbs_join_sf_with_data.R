#' Create a map with data from cbsodataR
#' 
#' Utility function to create an sf map object with data from cbsodataR.
#' 
#' The function is a simple wrapper around [cbs_add_statcode_column()] and
#' [cbs_get_sf()]. 
#' Please note that the resulting [sf::st_sf()] dataset has the same number of 
#' rows as the requested map object, as requested by [cbs_get_sf()], 
#' i.e. not the same rows as `x`. It's the users responsibility to match the correct
#' map to the selection of the data.
#' @family cartographic map
#' @export 
#' @example example/cbs_get_maps.R
#' @param x data retrieved with [cbs_get_data()]
#' @inheritParams cbs_get_sf
cbs_join_sf_with_data <- function(region, year, x, verbose = FALSE){
  map <- cbs_get_sf (region = region
                   , year = year
                   , keep_columns = c("statcode", "statnaam")
                   , verbose = verbose
                   )
  
  x <- cbs_add_statcode_column(x)
  m <- match(map$statcode, x$statcode)
  
  for (n in names(x)){
    map[[n]] <- x[[n]][m]
  }
  map
}
