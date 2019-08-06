#' Download a table from statistics Netherlands
#' 
#' This method is deprecated in favor of [cbs_download_table()].
#' @export
#' @inherit cbs_download_table
#' @name download_table-deprecated 
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
