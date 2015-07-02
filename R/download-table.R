#' Download a table from statistics Netherlands
#' 
#' @param id Identifier of CBS table (can be retrieved from \code{\link{get_table_list}})
#' @param dir Directory where table should be downloaded
#' @param ... Parameters passed on to \code{\link{download_data}}
#' @param cache If metadata is cached use that, otherwise download meta data
#' @export
#'
download_table <- function(id, ..., dir=id, cache=FALSE){
  #TODO add untyped vs typed download
  meta <- download_meta(id=id, dir=dir, cache=cache)

  download_data(id=id, path=file.path(dir, "data.csv"), ...)
  meta$directory <- dir
  # maybe we should generate a yaml or datapackage.json file?
  invisible(meta)
}

#' @importFrom yaml as.yaml
write_yaml <- function(x, name){
  file_name <- paste0(name, ".yml")
  message("Writing ", file_name, "...")
  writeLines(yaml::as.yaml(x), con=file_name)
}
