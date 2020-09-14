get_base_url <- function( catalog = "CBS"
                        , base_url = getOption("cbsodataR.base_url", BASE_URL)
){
  ## utility wise a better solution, but performance wise not...
  # ds <- cbs_get_datasets(catalog = NULL)
  # catalog <- ds$Catalog[which(id == ds$Identifier)]
  # if (length(catalog) != 1){
  #   stop('"', id, '"'
  #       , "not found in collection of datasets"
  #       , call. = FALSE
  #       )
  # }
  if (isTRUE(catalog != "CBS")){
    base_url <- "https://dataderden.cbs.nl"
  }
  base_url
}