#' Retrieve an sf map for plotting
#' 
#' Retrieve a polygon sf object that can be used for plotting.
#' This function only provides the region boundaries.
#' 
#' To use the map for plotting:
#' 
#' - add data columns to the sf data.frame returned by `cbs_get_sf`, e.g. by 
#' using `dplyr::left_join` or otherwise
#' - use `ggplot2`,  `tmap`, `leaflet` or any other plotting library useful for
#' plotting spatial data.
#' @param region `character` name of region
#' @param year `integer` year of a region
#' @param verbose if `TRUE` the method is verbose
#' @param keep_columns `character`, set to `NULL` to retrieve all columns of the map
#' @return [sf::st_sf()] object with the polygons of the regions specified.
#' @export
#' @example example/cbs_get_maps.R
#' @family cartographic map
cbs_get_sf <- function( region
                      , year
                      , keep_columns = c("statcode", "statnaam")
                      , verbose = FALSE
                      ){
  if (isTRUE(verbose)){
    message("Note that `cbs_add_statcode` can be used for connecting the map to the data.")
  }
  
  if (!requireNamespace("sf", quietly = TRUE)){
    message("This function requires package 'sf'.")
    return(invisible())
  }
  
  # TODO improve check
  if (length(region) != 1){
    stop("'region' should have length 1")
  }
  
  if (length(year) != 1){
    stop("'year' should have length 1")
  }
  
  maps <- cbs_get_maps(verbose = verbose)
  
  region_idx <- maps$region == region
  
  if (sum(region_idx) < 1){
    stop("'region' must be one of "
        , paste0("'",unique(maps$region), "'", collapse = ", ")
        , call. = FALSE
        )
  }

  maps <- maps[region_idx,]
  year_idx <- maps$year == year
  
  #check that idx is just 1
  if (sum(year_idx) != 1){
    stop("'",sprintf("%s_%d", region, year),"' is not available.
Available are: "
        , paste0( "'%s_%d'" |> sprintf(region, unique(maps$year))
                , collapse = ", "
                ) 
        , call.= FALSE
        )
  }
  maps <- maps[year_idx,]
  # TODO make this a choice
  
  geojson <- maps$rd
  suppressWarnings({
    map_sf <- sf::read_sf(geojson, quiet = !verbose, crs = 28992)
  })
  
  if (length(keep_columns)){
    map_sf <- map_sf[, keep_columns]
  }
  
  map_sf
}