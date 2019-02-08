#' Dumps the meta data into a directory
#' @param id Id of CBS open data table
#' @param dir Directory in which data should be stored. 
#' By default it creates a sub directory with the name of the id
#' @param ... not used
#' @param verbose Print extra messages what is happening.
#' @param cache Should meta data be cached?
#' @return meta data object
#' @param base_url optionally allow to specify a different server. Useful for
#' third party data services implementing the same protocol.
#' @name download_meta-deprecated
download_meta <- function( id, dir=id, ..., verbose = FALSE, cache=FALSE
                         , base_url = getOption("cbsodataR.base_url", BASE_URL)
                         ){
  .Deprecated("cbs_download_meta")
  cbs_download_meta(id = id , dir = dir, ..., verbose = verbose, cache = cache, base_url = base_url)
}
