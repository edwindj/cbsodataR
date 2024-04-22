#' Gets all data from a cbs table.
#' 
#' Gets all data via bulk download. `cbs_download_data` dumps the data in 
#' (international) csv format.
#' 
#' @param id of cbs open data table
#' @param catalog catalog id, can be retrieved with [cbs_get_datasets()]
#' @param path of data file, defaults to "id/data.csv"
#' @param ... optional filter statements to select rows of the data,
#' @param typed Should the data automatically be converted into integer and numeric?
#' @param verbose show the underlying downloading of the data
#' @param show_progress show a progress bar while downloading.
#' @param select optional names of columns to be returned.
#' @param base_url optionally specify a different server. Useful for
#' third party data services implementing the same protocol.
#' @family download
#' @family data retrieval
#' @export
cbs_download_data <- function( id
                         , path     = file.path(id, "data.csv")
                         , catalog  = "CBS"
                         , ...
                         , select   = NULL
                         , typed    = TRUE
                         , verbose  = FALSE
                         , show_progress = interactive() && !verbose
                         , base_url = getOption("cbsodataR.base_url", BASE_URL)
                         ){
  
  DATASET <- if (typed) "TypedDataSet" else "UntypedDataSet"
  if (show_progress){
    rc <- get_row_count(id, catalog = catalog, ..., base_url = base_url)
    if (rc == 0){
      stop("Selection is empty. Please check your filter statements."
           , call. = FALSE
      )
    }
    pb_value <- 0
    pb <- utils::txtProgressBar(min = 0, max = rc, style = 3)
  }
  base_url <- get_base_url(catalog, base_url)
  url <- whisker.render("{{BASEURL}}/{{BULK}}/{{id}}/{{DATASET}}?$format=json"
                       , list( BASEURL = base_url
                             , BULK    = BULK
                             , id      = id
                             , DATASET = DATASET
                             )
                       )
  url <- paste0(url, get_query(..., select=select))
  
  dir.create(dirname(path), showWarnings = FALSE, recursive = TRUE)
  data_file <- file(path, open = "wt")  
  
  # retrieve data
  if (verbose){
    message("Retrieving data from table '", id ,"'")
  } 
  
  url <- URLencode(url)
  res <- get_json(url, verbose = verbose) #jsonlite::fromJSON(url)
  write.table( res$value, 
               file=data_file, 
               row.names=FALSE, 
               na="",
               sep=","
             )
  url <- res$odata.nextLink

  while(!is.null(url)){
    skip <- gsub(".+skip=(\\w+)", "\\1", url)
    
    if (verbose) {
      message("\nReading...")
    } else if (show_progress){
      pb_value <- pb_value + nrow(res$value)
      utils::setTxtProgressBar(pb, value = pb_value)
    } 
    res <- get_json(url, verbose = verbose) #jsonlite::fromJSON(url)
    
    if (verbose){
      message("\nWriting...")
    } 
    
    
    write.table( res$value
               , file      = data_file
               , row.names = FALSE
               , col.names = FALSE
               , na        = ""
               , sep       = ","
               )
    url <- res$odata.nextLink
    #break
  }
  close(data_file)
  if (verbose){
    message("\nDone!") 
  } 
  
  if (show_progress){
    utils::setTxtProgressBar(pb, value = rc)
    close(pb)
  } 
}

#testing
#download_data("81819NED")


## big table
#download_data("70072ned")
