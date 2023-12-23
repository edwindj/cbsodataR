#' Prepares dataset for making a map
#' 
#' Adds a `statcode` column to the dataset, so it can be more easily joined with
#' a map retrieved with [cbs_get_sf()].
#' 
#' Regional data uses the `x$RegioS` dimension for data. The "codes" for each region
#' are also used in the cartographic map boundaries of regions as used in [cbs_get_sf()].
#' Unfortunately the codes in `x$RegioS` can have trailing spaces, and the variable
#' used in the mapping material is named `statcode`. This method simply adds 
#' a `statcode` column with trimmed codes from `RegioS`, making it more easy to
#' connect a dataset to a cartographic map.
#' @param x `data.frame` retrieved using [cbs_get_data()]
#' @param ... future use. 
#' @return original dataset with added `statcode` column.
#' @export
#' @example ./example/cbs_get_maps.R
#' @family cartographic map
cbs_add_statcode_column <- function(x,...){
  # retrieve period column (using timedimension)
  
  region_name <- names(unlist(sapply(x, attr, "is_region")))
  
  if (!length(region_name)){
    warning("No region dimension found!")
    return(x)
  }
    
  region <- x[[region_name[1]]]
  
  # region can contain whitespaces..
  # and statcode is the name used in cbs_get_sf
  x$statcode = trimws(region)
  
  x
}

# x <- cbs_get_data("81819NED")
# x1 <- cbs_add_date_column(x)
  
