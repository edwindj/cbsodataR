#' Gets all data from a cbs table.
#' 
#' This method is deprecated in favor of [cbs_download_data()].
#' 
#' @inherit cbs_download_data 
#' @name download_data-deprecated
download_data <- function( id, path=file.path(id, "data.csv"), ...
                         , select=NULL
                         , typed = FALSE
                         , verbose = TRUE
                         , base_url = getOption("cbsodataR.base_url", BASE_URL)
                         ){
  .Deprecated("cbs_download_data")
  cbs_download_data(id, path = path, select = select, typed = typed, verbose = verbose, base_url = base_url)
}

#testing
#download_data("81819NED")


## big table
#download_data("70072ned")
