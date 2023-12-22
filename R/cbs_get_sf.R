#' Retrieve a polygon file
#' 
#' Retrieve a polygon sf object.
#' @param region `character` name of region
#' @param year `integer` year of a region
#' @param add_regios if `TRUE` the `$statcode` column is copied to a `$RegioS` column
#' @param verbose if `TRUE` the method is verbose
#' @return [sf::sf()] object with the polygons of the regions specified.
#' @export
#' @example example/cbs_get_maps.R
#' @family map
cbs_get_sf <- function( region
                      , year
                      , add_regios = TRUE
                      , verbose = FALSE
                      ){
  
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
  
  if (isTRUE(add_regios)){
    map_sf$RegioS <- map_sf$statcode
  }
  map_sf
}