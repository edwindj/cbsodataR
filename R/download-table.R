#' Download a table from statistics Netherlands
#' 
#' @param id Identifier of CBS table (can be retrieved from \code{\link{get_table_list}})
#' @param dir Directory where table should be downloaded
#' @param ... Parameters passed on to \code{\link{download_data}}
#' @param typed Should the data automatically be converted into integer and numeric?
#' @param verbose Print extra messages what is happening.
#' @param cache If metadata is cached use that, otherwise download meta data
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocal.
#' 
#' \code{download_table} retrieves all raw meta data and data and stores these as csv
#' files in the directory specified by \code{dir}. It is possible to add a filter. 
#' A filter is specified with \code{<column_name> = <values>} in which \code{<values>} is a character vector.
#' Rows with values that are not part of the character vector are not returned.
#' @export
#' @examples 
#' \dontrun{
#' 
#' # download meta data and data from inflation/Consumer Price Indices
#'  download_table(id="7196ENG")
#' }
download_table <- function( id
                          , ...
                          , dir=id
                          , cache = FALSE
                          , verbose = TRUE
                          , typed = FALSE
                          , base_url = getOption("cbsodataR.base_url", BASE_URL)){
  .Deprecated("cbs_download_table")
  cbs_download_table(id = id, ..., dir =dir, cache =cache, verbose = verbose, typed = typed, base_url = base_url)
}
