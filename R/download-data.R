#' Gets all data from a cbs table.
#' 
#' Gets all data via bulk download. \code{download_data} dumps the data in (international) csv format.
#' @param id of cbs open data table
#' @param path of data file, defaults to "<id>/data.csv"
#' @param ... optional filter statements to select rows of the data,
#' @param typed Should the data automatically be converted into integer and numeric?
#' @param verbose show the underlying downloading of the data
#' @param select optional names of columns to be returned.
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocal.
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
