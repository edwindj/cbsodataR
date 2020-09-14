#' Download a table from statistics Netherlands
#' 
#' `cbs_download_table` downloads the data and metadata of 
#'  a table from statistics Netherlands and stores it in `csv` format.
#'
#' `cbs_download_table` retrieves all raw meta data and data and stores these as csv
#' files in the directory specified by `dir`. It is possible to add a filter. 
#' A filter is specified with `<column_name> = <values>` in which `<values>` 
#' is a character vector.
#' Rows with values that are not part of the character vector are not returned.
#' 
#' @param id Identifier of CBS table (can be retrieved from [cbs_get_toc()])
#' @param dir Directory where table should be downloaded
#' @param catalog catalog id, can be retrieved with [cbs_get_datasets()]
#' @param ... Parameters passed on to [cbs_download_data()]
#' @param typed Should the data automatically be converted into integer and numeric?
#' @param verbose Print extra messages what is happening.
#' @param cache If metadata is cached use that, otherwise download meta data
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocol.
#' @return meta data object of `id` [cbs_get_meta()].
#' @family download
#' @export
#' @examples 
#' \dontrun{
#' 
#' # download meta data and data from inflation/Consumer Price Indices
#'  download_table(id="7196ENG")
#' }
cbs_download_table <- function( id
                          , catalog = "CBS"
                          , ...
                          , dir=id
                          , cache = FALSE
                          , verbose = TRUE
                          , typed = FALSE
                          , base_url = getOption("cbsodataR.base_url", BASE_URL)){
  meta <- cbs_download_meta( id=id
                           , catalog = catalog
                           , dir=dir
                           , cache=cache
                           , base_url = base_url
                           )
  
  cbs_download_data( id   = id
                   , path = file.path(dir, "data.csv")
                   , catalog = catalog
                   , ...
                   , typed    = typed
                   , verbose  = verbose
                   , base_url = base_url
                   )
  meta$directory <- dir
  # maybe we should generate a yaml or datapackage.json file?
  invisible(meta)
}
