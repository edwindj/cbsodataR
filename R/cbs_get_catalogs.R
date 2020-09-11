#' Retrieves the possible catalog values that can be used for retrieving data
#' 
#' Retrieves the possible catalog values that can be used for retrieving data
#' @inheritParams cbs_get_datasets
#' @export
cbs_get_catalogs <- function(..., base_url = BASE_URL){
  ds <- cbs_get_datasets(..., catalog = NULL, base_url = base_url)
  cats <- data.frame(catalog = unique(ds$Catalog))
  cats$base_url <- ifelse(cats$catalog == "CBS", base_url, "https://dataderden.cbs.nl")
  cats
}