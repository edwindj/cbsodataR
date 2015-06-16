#' Dumps the meta data into a directory
#' @param id Id of CBS open data table
#' @param dir Directory in which data should be stored. 
#' By default it creates a sub directory with the name of the id
#' @param ... not used
download_meta <- function(id, dir=id, ...){
  dir.create(path=dir, showWarnings = FALSE, recursive = TRUE)
  oldwd <- setwd(dir)
  on.exit(setwd(oldwd))
  
  meta <- get_meta(id)
  
  for (n in names(meta)){
    file_name <- paste0(n, ".csv")
    message("Writing ", file_name, "...")
    write.csv( meta[[n]]
             , file=file_name
             , row.names=FALSE
             , na=""
             )
  }
  invisible(meta)
}

### testing


#dump_meta("81819NED")
