#' Dumps the meta data into a directory
#' 
#' This method is deprecated in favor of [cbs_download_meta()].
#' @inherit cbs_download_meta
#' @export
#' @name download_meta-deprecated
download_meta <- function( id, dir=id, ..., verbose = FALSE, cache=FALSE
                         , base_url = getOption("cbsodataR.base_url", BASE_URL)
                         ){
  .Deprecated("cbs_download_meta")
  cbs_download_meta(id = id , dir = dir, ..., verbose = verbose, cache = cache, base_url = base_url)
}
