#' Dumps the meta data into a directory
#' 
#' @param id Id of CBS open data table (see [cbs_get_toc()])
#' @param dir Directory in which data should be stored. 
#' By default it creates a sub directory with the name of the id
#' @param catalog catalog id, can be retrieved with [cbs_get_datasets()]
#' @param ... not used
#' @param verbose Print extra messages what is happening.
#' @param cache Should meta data be cached?
#' @return meta data object
#' @param base_url optionally allow to specify a different server. Useful for
#' third party data services implementing the same protocol.
#' @family meta data
#' @family download
#' @export
cbs_download_meta <- function( id
                             , dir=id
                             , catalog = "CBS"
                             , ...
                             , verbose = FALSE
                             , cache=FALSE
                             , base_url = getOption("cbsodataR.base_url", BASE_URL)
                             ){
  dir.create(path=dir, showWarnings = FALSE, recursive = TRUE)
  # oldwd <- setwd(dir)
  # on.exit(setwd(oldwd))
  
  meta <- cbs_get_meta(id, cache = cache, catalog = catalog, verbose = verbose, base_url = base_url)
  
  for (n in names(meta)){
    file_name <- file.path(dir, paste0(n, ".csv"))
    if (verbose){
      message("Writing ", file_name, "...")
    }
    write.csv( meta[[n]]
             , file      = file_name
             , row.names = FALSE
             , na        = ""
             )
  }
  invisible(meta)
}
